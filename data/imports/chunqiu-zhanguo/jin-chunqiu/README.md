# 晋数据包

本包从 `chunqiu-zhanguo` 原始缓存拆出，以 `cache.json` 为唯一记录源；记录 ID、史实、日期及置信度保持不变，来源与处理说明维护在 `manifest.sources` 和 `manifest.notes`。

从仓库根目录生成与校验本包：

```bash
node data/imports/generate.mjs chunqiu-zhanguo/jin-chunqiu
node .cursor/skills/eralens-period-import/scripts/validate-import.mjs data/imports/chunqiu-zhanguo/jin-chunqiu/import.sql
```

`import.sql` 和 `manifest.json` 由统一生成器生成，勿手工修改。生成前进行全量行所有权审计；本包仅拥有 晋 的王朝记录及所属人物、在位、事件或补充关联。既有事件、跨国事件参与人物、缺载系统人物和命运线允许通过 ID 引用其他包，不能复制被引用实体或重复写关联行。全新数据库须按总导入流程加载依赖；内容快照由所有源包整库构建；本包可独立生成并校验 SQL。
