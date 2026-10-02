# 吴独立数据包

本包由原 `chunqiu-zhanguo` 按王朝拆分，唯一事实源为 `cache.json`。原 ID、记录内容、日期和置信度保持不变；来源与处理说明维护在 `cache.json.manifest`，父目录保留原完整包说明归档。

在仓库根目录运行：

```bash
node data/imports/generate.mjs chunqiu-zhanguo/wu-chunqiu
node .cursor/skills/eralens-period-import/scripts/validate-import.mjs data/imports/chunqiu-zhanguo/wu-chunqiu/import.sql
```

`import.sql` 和 `manifest.json` 为统一生成器产物。生成前执行全量行所有权审计；不要手工编辑 SQL 或复制其他包拥有的记录。

跨包事件、人物、王朝引用保留原 ID；其目标记录由对应的其他包拥有。独立增量导入前须确保目标实体已存在；全量导入由统一流程安排依赖顺序。其他补充包中的都城、典故和灭国命运线继续由原所有者维护。

本包清理 SQL 仅清理 `wu-chunqiu` 的旧在位 ID，并保留本包缓存列出的在位；不清理其他王朝。
