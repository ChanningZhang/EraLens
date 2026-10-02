# 秦数据包

本包位于 `data/imports/chunqiu-zhanguo/qin/`，唯一记录源为 `cache.json`；来源及处理说明维护在其 `manifest` 中。它由原春秋战国包拆出，保留原记录 ID、内容与日期。

从仓库根目录生成与校验：

```bash
node data/imports/generate.mjs chunqiu-zhanguo/qin
node .cursor/skills/eralens-period-import/scripts/validate-import.mjs data/imports/chunqiu-zhanguo/qin/import.sql
```

`import.sql` 和 `manifest.json` 由统一生成器维护。生成前须通过全量行所有权审计；本包只拥有当前王朝的记录，跨王朝事件与关系可以引用其他包的实体，引用对象由对应包唯一维护。单包导入前须确保依赖实体已入库，首次全量加载使用仓库统一真实数据导入流程。缺载在位引用共有的 `system-missing-ruler` 人物，不在本包重复定义。

秦帝国段 `reign-ying-zheng`、`reign-ying-huhai`、`reign-ying-ziying` 仍由 `qin-han` 包唯一拥有，本包只引用并在清理白名单中保留它们。

旧在位清理限定当前王朝，白名单包含本包在位 ID 及上述三条跨包在位；涉及人物的清理仅处理失去所有在位、事件与关系引用的孤儿。父目录保存原完整 manifest 的归档。
