# 春秋战国数据包

`cache.json` 是本包唯一的结构化事实源，包含已核定的人物、诸侯国、在位、事件、关系和来源说明。修正姓名、称号、年代、精度、置信度、别名或条目链接时，直接编辑缓存；不要在生成脚本中加入 Wiki 解析、年份修补、插值或单条记录覆盖逻辑。

统一生成器只读取缓存并调用共用 SQL 序列化器。重新生成本包 SQL：

```sh
node data/imports/generate.mjs chunqiu-zhanguo
```

这会从同一缓存写出 PostgreSQL `import.sql` 和 `manifest.json`。`cache.json` 中的 `postSql` 只保留替换旧导入记录所需的数据库清理指令。
