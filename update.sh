#!/usr/bin/env bash
set -euo pipefail

usage() { printf 'Usage: %s [--max-projects N] [--catalog-only]\n' "$0"; }
max_projects=0
catalog_only=0
while (($#)); do
  case "$1" in
    --max-projects) (($# >= 2)) || { usage >&2; exit 2; }; max_projects=$2; shift 2 ;;
    --catalog-only) catalog_only=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) usage >&2; exit 2 ;;
  esac
done
[[ $max_projects =~ ^[0-9]+$ ]] || { echo 'max-projects must be a nonnegative integer' >&2; exit 2; }
for command in curl jq git rsync df awk date mktemp flock rm; do
  command -v "$command" >/dev/null || { printf 'Missing command: %s\n' "$command" >&2; exit 2; }
done

repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
cd "$repo_dir"
git rev-parse --is-inside-work-tree >/dev/null
mkdir -p .runs projects logs
exec 9>.runs/update.lock
flock -n 9 || { echo 'Another update is running' >&2; exit 1; }
run_dir=$(mktemp -d .runs/run.XXXXXXXX)
trap 'rm -rf -- "$run_dir"' EXIT
api='https://hclhub.h3c.com/api/Pubhclhub/projects'
page_size=100
page=1
total=-1
received=0
pages=()
while :; do
  page_file="$run_dir/page-$page.json"
  curl --fail --silent --show-error --location --retry 3 --retry-delay 2 \
    --connect-timeout 10 --max-time 60 --proto '=https' --proto-redir '=https' \
    --get --data-urlencode "page=$page" --data-urlencode "rows=$page_size" \
    --data-urlencode 'categoryIds=' --data-urlencode 'sort=update_time' \
    --data-urlencode 'projectName=' "$api" --output "$page_file"
  jq -e '.code == 0 and (.data.total | type == "number") and (.data.rows | type == "array")' \
    "$page_file" >/dev/null || { echo "Invalid market page $page" >&2; exit 1; }
  current_total=$(jq -r '.data.total' "$page_file")
  count=$(jq -r '.data.rows | length' "$page_file")
  if ((total < 0)); then total=$current_total; fi
  if ((current_total != total || (count == 0 && received < total))); then
    echo 'Market catalog changed during pagination; no project snapshots changed' >&2
    exit 1
  fi
  pages+=("$page_file")
  received=$((received + count))
  ((received < total)) || break
  page=$((page + 1))
  ((page <= 100)) || { echo 'Market pagination exceeded 100 pages' >&2; exit 1; }
done

checked_at=$(date -u '+%Y-%m-%dT%H:%M:%SZ')
jq -s --arg checked_at "$checked_at" \
  '{checked_at:$checked_at,total:.[0].data.total,rows:([.[].data.rows[]] | sort_by(.projectId) | unique_by(.projectId))}' \
  "${pages[@]}" >"$run_dir/catalog.json"
unique=$(jq -r '.rows | length' "$run_dir/catalog.json")
if ((unique != total)); then
  printf 'Market catalog has %s unique IDs, expected %s\n' "$unique" "$total" >&2
  exit 1
fi
cp -- "$run_dir/catalog.json" catalog.json
printf 'Catalog: %s projects (%s)\n' "$total" "$checked_at"
((catalog_only == 0)) || exit 0

printf 'checked_at\tproject_id\tstatus\tcommit\n' >"$run_dir/state.tsv"
success=0
failed=0
processed=0
export GIT_TERMINAL_PROMPT=0
export GCM_INTERACTIVE=Never
while IFS=$'\t' read -r project_id raw_url branch; do
  if ((max_projects > 0 && processed >= max_projects)); then break; fi
  processed=$((processed + 1))
  status=failed
  commit=-
  log_file="logs/$project_id.log"
  dest="projects/$project_id"
  : >"$log_file"
  if [[ ! $project_id =~ ^[0-9]+$ || ! $branch =~ ^[A-Za-z0-9][A-Za-z0-9._/-]*$ ||
        $branch == *..* || $branch == */ ||
        ! $raw_url =~ ^https?://hclhub\.h3c\.com/repo/[A-Za-z0-9._/-]+(\.git)?/?$ ||
        $raw_url == *..* ]]; then
    printf 'Rejected invalid catalog entry\n' >"$log_file"
  else
    url=${raw_url/http:\/\//https:\/\/}
    url=${url%/}
    [[ $url == *.git ]] || url="$url.git"
    free_kib=$(df -Pk . | awk 'NR==2 {print $4}')
    if ((free_kib < 10 * 1024 * 1024)); then
      printf 'Stopped: less than 10 GiB free\n' >"$log_file"
      printf '%s\t%s\tdisk_low\t-\n' "$checked_at" "$project_id" >>"$run_dir/state.tsv"
      echo 'Disk guard reached; stopping before the next project' >&2
      failed=$((failed + 1))
      break
    fi
    work="$run_dir/clone-$project_id"
    stage="$run_dir/stage-$project_id"
    if git -c credential.helper= clone --quiet --depth 1 --single-branch \
        --branch "$branch" "$url" "$work" >"$log_file" 2>&1; then
      commit=$(git -C "$work" rev-parse HEAD)
      mkdir -p "$stage"
      if rsync -a --exclude='.git' "$work/" "$stage/" >>"$log_file" 2>&1 &&
          [[ ! -e $dest || ( -d $dest && ! -e $dest/.git &&
              -z $(git status --porcelain -- "$dest") ) ]]; then
        mkdir -p "$dest"
        if rsync -a --delete --exclude='.git' "$stage/" "$dest/" >>"$log_file" 2>&1; then
          status=snapshotted
        fi
      else
        printf 'Target is a Git repository or snapshot staging failed; preserved target\n' >>"$log_file"
      fi
    fi
  fi
  if [[ $status == snapshotted ]]; then
    success=$((success + 1))
  else
    failed=$((failed + 1))
  fi
  printf '%s\t%s\t%s\t%s\n' "$checked_at" "$project_id" "$status" "$commit" >>"$run_dir/state.tsv"
  printf '%s/%s id=%s %s\n' "$processed" "$total" "$project_id" "$status"
  [[ ! -e ${work:-} ]] || rm -r -- "$work"
  [[ ! -e ${stage:-} ]] || rm -r -- "$stage"
  unset work stage
done < <(jq -r '.rows[] | [.projectId,.gitHttpUrl,.defaultBranch] | @tsv' catalog.json)

cp -- "$run_dir/state.tsv" state.tsv
printf 'Completed: processed=%s success=%s failed=%s catalog_total=%s\n' \
  "$processed" "$success" "$failed" "$total"
((failed == 0))
