# 蔡独立数据包

本包维护蔡国王朝、君主与在位记录。唯一事实源为 `cache.json`；`import.sql` 与 `manifest.json` 由统一生成器产出。

从仓库根目录运行：

```sh
node data/imports/generate.mjs chunqiu-zhanguo/cai-chunqiu
node .cursor/skills/eralens-period-import/scripts/validate-import.mjs data/imports/chunqiu-zhanguo/cai-chunqiu/import.sql
```

跨包实体仅按 ID 引用，不复制由其他包拥有的人物、事件或普通关联。
