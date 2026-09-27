# 春秋小国与战国残余数据包

- `cache.json` 是本包已核定的源数据。人物、王朝、在位、事件与关系在此直接维护；插值与姓氏元数据已经写入对应记录，不在生成时重算。
- 使用统一缓存生成器读取本包缓存并调用共享 SQL 输出器。
- `import.sql` 与 `manifest.json` 是生成文件。来源和年代取舍记录在 manifest 的 `sources`、`notes`。

重新生成：

```sh
node data/imports/generate.mjs chunqiu-minor
```
