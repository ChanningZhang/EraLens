# 春秋战国王朝数据包

原时期包已按王朝拆成 19 个独立子包。每个子包的 `cache.json` 是当前事实源，`import.sql` 与 `manifest.json` 由统一生成器产出；本目录只负责分组，不拥有数据库行。

## 王朝目录

- [邹](zou-state/README.md)：`zou-state/`
- [齐](qi-chunqiu/README.md)：`qi-chunqiu/`
- [晋](jin-chunqiu/README.md)：`jin-chunqiu/`
- [楚](chu-chunqiu/README.md)：`chu-chunqiu/`
- [燕](yan-chunqiu/README.md)：`yan-chunqiu/`
- [宋](song-chunqiu/README.md)：`song-chunqiu/`
- [鲁](lu-chunqiu/README.md)：`lu-chunqiu/`
- [卫](wei-weiguo/README.md)：`wei-weiguo/`
- [郑](zheng-chunqiu/README.md)：`zheng-chunqiu/`
- [曹](cao-chunqiu/README.md)：`cao-chunqiu/`
- [吴](wu-chunqiu/README.md)：`wu-chunqiu/`
- [越](yue-chunqiu/README.md)：`yue-chunqiu/`
- [中山](zhongshan/README.md)：`zhongshan/`
- [韩](han-warring/README.md)：`han-warring/`
- [赵](zhao-warring/README.md)：`zhao-warring/`
- [魏](wei-warring/README.md)：`wei-warring/`
- [秦](qin/README.md)：`qin/`
- [西虢国](guo-chunqiu/README.md)：`guo-chunqiu/`
- [东虢国](guo-east/README.md)：`guo-east/`

## 生成与导入

生成单个王朝（例如齐）：

```sh
node data/imports/generate.mjs chunqiu-zhanguo/qi-chunqiu
node .cursor/skills/eralens-period-import/scripts/validate-import.mjs data/imports/chunqiu-zhanguo/qi-chunqiu/import.sql
```

生成全部包：`node data/imports/generate.mjs --all`。生成、所有权审计、全量导入、命运线读取、字体检查和去重工具均递归发现子包。`pnpm db:import` 按 manifest 的窗口与导入阶段排序导入，跨包关联沿用统一延期处理。

记录 ID、历史事实、日期、置信度及详情来源链接保持原样。君主人物与在位归对应王朝；无在位人物也各有唯一所有者，所在包只表示维护归属，不新增历史关联。事件及其内嵌关联由 `dynastyIds` 中首个王朝的包唯一拥有；其他王朝通过 ID 引用。补充事件王朝关联按被关联王朝分包；补充人物关联跟随人物所有者。系统占位人物、其他时期的事件、都城和灭国关系继续引用原所有者，不重复写入。

秦帝国段在位继续由 `qin-han` 包拥有；秦包的清理白名单保留这些跨包记录。各包清理 SQL 只作用于所属王朝。

拆分前完整来源与处理说明存于 [provenance.json](provenance.json)，供追溯使用，不参与生成或导入。后续维护请修改对应子包的缓存与 manifest 元数据。
