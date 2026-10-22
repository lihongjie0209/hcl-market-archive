#!/usr/bin/env bash
set -euo pipefail

repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
cd "$repo_dir"
[[ -f catalog.json ]] || { echo 'catalog.json not found' >&2; exit 1; }
grep -q '^<!-- PROJECT_INDEX_START -->$' README.md || { echo 'README index marker missing' >&2; exit 1; }

temp=$(mktemp .runs/index.XXXXXXXX)
trap 'rm -f -- "$temp"' EXIT
sed '/^<!-- PROJECT_INDEX_START -->/,$d' README.md >"$temp"
printf '<!-- PROJECT_INDEX_START -->\n\n' >>"$temp"
total=$(jq -r '.total' catalog.json)
archived=0
while IFS=$'\t' read -r id name description; do
  [[ $id =~ ^[0-9]+$ ]] || { echo "Invalid project ID: $id" >&2; exit 1; }
  if [[ -d projects/$id && ! -e projects/$id/.git ]]; then
    archived=$((archived + 1))
    link="[projects/$id](projects/$id/)"
    status='已归档'
  else
    link='—'
    status='未归档'
  fi
  printf '| %s | %s | %s | %s | %s |\n' "$id" "$name" "$description" "$status" "$link" >>"$temp"
done < <(jq -r '.rows[] | [.projectId, ((.name // "") | gsub("[\\r\\n\\t|]"; " ")), ((.projectDesc // "") | gsub("[\\r\\n\\t|]"; " "))] | @tsv' catalog.json)

sed -i "/^<!-- PROJECT_INDEX_START -->$/a\\\n市场项目：$total；已归档：$archived。\n\n| ID | 项目 | 简介 | 状态 | 本地目录 |\n| --- | --- | --- | --- | --- |" "$temp"
printf '\n<!-- PROJECT_INDEX_END -->\n' >>"$temp"
mv -- "$temp" README.md
printf 'README index: archived=%s catalog=%s\n' "$archived" "$total"
