# HCL 市场工程快照

`projects/<项目 ID>/` 是普通文件目录，不含内层 `.git`、submodule 或裸仓库。克隆本仓库即可拿到**已提交**的全部工程快照。外层 Git 保留归档的快照历史，但不保留各上游仓库的原始 Git 历史。

`update.sh` 从 HCLHub 公开市场 API 分页发现项目，浅克隆默认分支到临时目录，并将工作树同步到 `projects/`。市场下架的项目不会自动删除；重复运行可增量更新现有快照。`catalog.json` 为最近一次列表；`state.tsv` 与 `logs/` 是本地运行报告。脚本不读取 HCL 登录凭据，不修改 HCL 客户端工程。

依赖 Bash、curl、jq、Git、rsync、flock。Linux、WSL 和常见 CI runner 可运行：

```bash
./update.sh --max-projects 1  # 小样本验证
./update.sh                   # 全量同步
git add catalog.json projects
git commit -m 'Update HCL market snapshots'
```

脚本不自动提交或推送。只有提交后的文件才会出现在下一次 `git clone` 中；历史快照可用 `git log -- projects/<ID>` 查询。磁盘剩余低于 10 GiB 时停止；下载失败、目录冲突均保留原有文件并在日志中报告。未归档上游分支、标签和完整提交历史。
