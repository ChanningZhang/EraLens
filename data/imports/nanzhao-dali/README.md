# 南诏与大理数据包

- `cache.json` 是本包已核定的源数据。人物、王朝、在位、事件和关系记录直接在这里维护；时间字段同时保留公历值与 `AbsMonth`。
- 统一生成器只读取缓存并调用共享 SQL 输出器，不在生成时推算或修补朝代记录。
- `import.sql` 与 `manifest.json` 是生成文件。事实来源与年代取舍写在缓存记录和 `cache.json` 内的 `manifest.sources` / `manifest.notes`。

重新生成：

```sh
node data/imports/generate.mjs nanzhao-dali
```
