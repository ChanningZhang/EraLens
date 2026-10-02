# 宋数据包

本包从 `chunqiu-zhanguo` 原始缓存拆出，以 `cache.json` 为唯一记录源；记录 ID、史实、日期及置信度保持不变，来源与处理说明维护在 `manifest.sources` 和 `manifest.notes`。

从仓库根目录生成与校验本包：

```bash
node data/imports/generate.mjs chunqiu-zhanguo/song-chunqiu
node .cursor/skills/eralens-period-import/scripts/validate-import.mjs data/imports/chunqiu-zhanguo/song-chunqiu/import.sql
```

`import.sql` 和 `manifest.json` 由统一生成器生成，勿手工修改。生成前进行全量行所有权审计；本包仅拥有 宋 的王朝记录及所属人物、在位、事件或补充关联。既有事件、跨国事件参与人物、缺载系统人物和命运线允许通过 ID 引用其他包，不能复制被引用实体或重复写关联行。全新数据库须按总导入流程加载依赖；已有真实数据库中可按本包路径独立生成、校验和导入。

`postSql` 只清理本王朝不在本包在位 ID 白名单中的旧在位，并清理没有在位、事件参与或人物关系引用的孤儿人物，最后重建搜索词。
