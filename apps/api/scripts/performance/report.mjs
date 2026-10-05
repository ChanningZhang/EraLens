import { readFileSync, writeFileSync } from 'node:fs';
const read=name=>JSON.parse(readFileSync(new URL(`../../../../docs/performance/${name}.json`,import.meta.url),'utf8'));
const before=read('before'),after=read('after'),correctness=read('correctness'),http=read('http-correctness'),detail=read('detail-context');
if(!before.finishedAt || !after.finishedAt) throw new Error('Both complete benchmarks are required');
for(const key of ['node','sqlite','databaseBytes']) if(before.environment[key]!==after.environment[key]) throw new Error(`Environment differs: ${key}`);
if(before.environment.metadata.source_checksum!==after.environment.metadata.source_checksum) throw new Error('Different content snapshots');
const lookup=(report,name)=>{const item=report.records.find(r=>r.name===name);if(!item)throw new Error(`Missing benchmark: ${name}`);return item;};
const f=n=>Number(n).toFixed(3),pct=(a,b)=>((a-b)/a*100).toFixed(1)+'%',kib=n=>(n/1024).toFixed(1);
const rows=[];
const add=(label,oldName,newName=oldName)=>{const a=lookup(before,oldName),b=lookup(after,newName);rows.push(`| ${label} | ${f(a.ms.median)} | ${f(b.ms.median)} | ${pct(a.ms.median,b.ms.median)} | ${f(a.ms.p95)} → ${f(b.ms.p95)} | ${a.rows.median} → ${b.rows.median} | ${a.queries.median} → ${b.queries.median} |`);};
for(const [label,name] of [['首次连接','repository:first-connection'],['750年','repository:timeline:year-750'],['700–799年','repository:timeline:century-700'],['304–439年（密集时期）','repository:timeline:dense-304-439'],['1368–2026年','repository:timeline:wide-1368-2026'],['空搜索','repository:search:empty'],['搜索李隆基','repository:search:李隆基'],['搜索唐','repository:search:唐'],['搜索开元','repository:search:开元'],['搜索长安','repository:search:长安'],['搜索赤壁','repository:search:赤壁'],['李隆基详情','repository:detail:li-longji'],['唐详情','repository:detail:tang'],['目录','repository:catalog'],['时间边界','repository:bounds'],['指定在位地点映射','repository:mappings'],['地点列表','repository:locations']]) add(label,name);
const splitRows=[],workRows=[],rangeRows=[];
for(const [label,key] of [['750年','year-750'],['700–799年','century-700'],['304–439年','dense-304-439'],['1368–2026年','wide-1368-2026']]) {
  const old=lookup(before,`http:timeline:${key}`),aggregate=lookup(after,`http:timeline:${key}`),split=lookup(after,`http:split-all:${key}`);
  const repoOld=lookup(before,`repository:timeline:${key}`),repoNew=lookup(after,`repository:split-all:${key}`);
  workRows.push(`| ${label} | ${repoOld.queries.median} → ${repoNew.queries.median} | ${repoOld.rows.median} → ${repoNew.rows.median} | ${f(repoOld.sqlMs.median)} → ${f(repoNew.sqlMs.median)} |`);
  rangeRows.push(`| ${label} | ${f(old.ms.min)}–${f(old.ms.max)} | ${f(split.ms.min)}–${f(split.ms.max)} |`);
  const layers=['reigns','events','persons'].map(l=>lookup(after,`repository:${l}:${key}`));
  splitRows.push(`| ${label} | ${f(old.ms.median)} | ${f(aggregate.ms.median)} | ${f(split.ms.median)} | ${pct(old.ms.median,split.ms.median)} | ${f(split.ms.p95)} | ${kib(old.bytes.median)} → ${kib(split.bytes.median)} |`);
  splitRows.push(`\n${label}的 Repository 单层中位数：在位 ${f(layers[0].ms.median)} ms、事件 ${f(layers[1].ms.median)} ms、人物 ${f(layers[2].ms.median)} ms；三层同时调用总耗时 ${f(lookup(after,`repository:split-all:${key}`).ms.median)} ms。\n`);
}
const concurrent=[];
for(const count of [5,10]) { const a=lookup(before,`http:timeline:concurrency-${count}`),b=lookup(after,`http:split-all:concurrency-${count}`);concurrent.push(`| ${count} 个客户端 | ${f(a.ms.median)} | ${f(b.ms.median)} | ${pct(a.ms.median,b.ms.median)} | ${f(a.ms.p95)} → ${f(b.ms.p95)} |`); }
for(const [label,key] of [['人物层隐藏（1368–2026年）','http:persons-hidden'],['连续平移（10个窗口循环）','http:pan']]){const a=lookup(before,key),b=lookup(after,key);concurrent.push(`| ${label} | ${f(a.ms.median)} | ${f(b.ms.median)} | ${pct(a.ms.median,b.ms.median)} | ${f(a.ms.p95)} → ${f(b.ms.p95)} |`);}
const env=before.environment;
const prominentOld=lookup(before,'repository:timeline:year-750'),prominentNew=lookup(after,'repository:timeline:year-750');
const broad=lookup(after,'http:split-all:wide-1368-2026'),broadAggregate=lookup(after,'http:timeline:wide-1368-2026');
const regressions=before.records.flatMap(a=>{const b=after.records.find(b=>b.name===a.name);return b && b.ms.median>a.ms.median ? [`- ${a.name}：${f(a.ms.median)} → ${f(b.ms.median)} ms。`] : [];});
const sqlRows=['repository:timeline:year-750','repository:timeline:wide-1368-2026','repository:search:李隆基','repository:detail:li-longji','repository:mappings'].map(name=>{const a=lookup(before,name),b=lookup(after,name);return `| ${name.replace('repository:','')} | ${f(a.sqlMs.median)} | ${f(b.sqlMs.median)} | ${pct(a.sqlMs.median,b.sqlMs.median)} |`;});
const text=`# SQLite 查询改造前后性能报告

测试日期：2026-10-05（Asia/Shanghai）。

## 结论

- 首要收益来自按需读取与解析：750 年时间轴 Repository 中位数从 **${f(prominentOld.ms.median)} ms 降至 ${f(prominentNew.ms.median)} ms**，改善 **${pct(prominentOld.ms.median,prominentNew.ms.median)}**，向 JavaScript 返回的数据库行数从 ${prominentOld.rows.median} 降至 ${prominentNew.rows.median}。
- 接口拆分提供独立缓存、取消、预取与人物层按需查询；拆分本身增加 HTTP 请求和元数据校验，不能把全部改善归因于拆分。下面同时列出优化后的兼容聚合接口与三层全部完成结果。
- 命运线补齐上下文会增加传输量。1368–2026 年三层响应共 ${kib(broad.bytes.median)} KiB，优化聚合接口 ${kib(broadAggregate.bytes.median)} KiB。上下文人物仅发送称谓字段，省去传记和来源链接；可见人物仍保留原 DTO。
- iOS 原生桥接、浏览器首屏绘制/LCP未进行前后定量采样，不将桌面 Repository 或 HTTP 数据称为页面或 iOS 提速。页面已做功能检查：事件、在位、人物、命运线可见，无捕获到的控制台错误。

## 环境与方法

- 机器：${env.cpu}，${env.platform}/${env.arch}；Node ${env.node}，SQLite ${env.sqlite}。
- 表行数：${Object.entries(env.metadata.counts).map(([name,count])=>`${name} ${count}`).join('；')}。
- 内容库 ${env.databaseBytes} 字节；版本 \`${env.metadata.dataset_version}\`；校验和 \`${env.metadata.source_checksum}\`。前后环境、数据库大小与源校验和自动核对一致。
- 旧实现冻结自提交 \`${env.metadata.source_git_sha}\` 的 Repository；共享历史规则保持原有语义。基准只读访问内容库，未新增索引、字段或重建数据库。
- 正式采样依次运行旧实现与新实现；每个场景预热 10 次，再采样 200 次。首次连接另采样 20 次，每次创建新连接，但未清空操作系统缓存，不是磁盘冷缓存。
- 中位数取排序后第 101 项；P95 取第 190 项（20 次采样则取第 19 项）。每次样本及 min/max 均在原始 JSON 中保存。
- SQL 耗时包含 prepare 和 all；Repository 耗时包含查询、映射和共享规则。HTTP 使用同机回环网络、真实 Fastify 路由、fetch 与 JSON 解析，关闭服务日志，不含公网、TLS或浏览器绘制。
- “行数”是 SQL 向 JavaScript 返回的行数，含重复加载与元数据行，**不是 SQLite 内部实际扫描行数**；扫描方式见查询计划。
- 5/10 并发各采样 200 个客户端完整响应；拆分模式每个客户端发三个并行请求，共 600 个 HTTP 请求。每批的 SQL/行数平均分摊到客户端，不伪称逐请求精确归属；批耗时保存在原始数据。
- 连续平移为 10 个相邻窗口循环，总计 200 帧请求，测未命中浏览器缓存的加载成本。隐藏人物层场景仅调用在位、事件两层。
- 响应大小是 JSON 编码字节数，未压缩；三层按结果数组计数，含数组分隔符，不含 HTTP 头。\`scope\` 对事件和人物保持既有语义，没有新增全层 scope 限制。

## Repository 前后对比

单位：ms。改善为中位耗时降低比例，负数表示回退。

| 场景 | 改造前中位数 | 改造后中位数 | 改善 | P95 前 → 后 | 返回行数 前 → 后 | SQL 次数 前 → 后 |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
${rows.join('\n')}

数据库调用部分单独比较：

| 场景 | 改造前 SQL 中位数 ms | 改造后 SQL 中位数 ms | 改善 |
| --- | ---: | ---: | ---: |
${sqlRows.join('\n')}

人物详情上下文单条 SQL 独立测试：${f(detail.results[0].median)} → ${f(detail.results[1].median)} ms，中位耗时改善 ${pct(detail.results[0].median,detail.results[1].median)}；P95 ${f(detail.results[0].p95)} → ${f(detail.results[1].p95)} ms。这只是详情中的一条 SQL，不等于详情整体收益。

## 聚合接口与拆分接口

三个拆分请求全部返回后停止计时，不将最快单层当作完整时间轴。

${splitRows.filter(r=>r.startsWith('|')).length ? '| 窗口 | 旧聚合中位数 ms | 新聚合中位数 ms | 三层全部完成 ms | 三层相对旧聚合改善 | 三层 P95 ms | 旧聚合 → 三层 KiB |\n| --- | ---: | ---: | ---: | ---: | ---: | ---: |' : ''}
${splitRows.filter(r=>r.startsWith('|')).join('\n')}

${splitRows.filter(r=>!r.startsWith('|')).join('\n')}

三层全部完成的数据库总工作量（与旧聚合相同展示内容；新接口另外提供端点上下文）：

| 窗口 | SQL 次数 前 → 三层 | 返回行数 前 → 三层 | SQL 中位耗时 ms 前 → 三层 |
| --- | ---: | ---: | ---: |
${workRows.join('\n')}

HTTP 完整加载样本的波动范围（其余场景完整范围和逐次样本见原始 JSON）：

| 窗口 | 旧聚合 min–max ms | 三层 min–max ms |
| --- | ---: | ---: |
${rangeRows.join('\n')}

| 场景 | 改造前中位数 ms | 改造后三层/按需完成 ms | 改善 | P95 前 → 后 ms |
| --- | ---: | ---: | ---: | ---: |
${concurrent.join('\n')}

## 查询计划与代价

- 原时间轴、目录、搜索、详情每次执行整表读取并在 JS 筛选；新实现不再走整库加载路径。
- 人物详情通过标量子查询先定位人物，再按 person_id 查询在位，避免旧 CTE 的全表人物/在位扫描。窗口函数仍在该人物的小集合上排序，保留在位总数与序号。
- 王朝窗口使用 dynasties_window_idx，在位上下文使用 reigns_dynasty_idx，地点映射使用 location_mapping_entity_idx 批量读取。事件的点时间 OR 区间条件实际计划是 SCAN events（467 行），普通人物候选是 SCAN p（1455 行），其君主排除子查询使用 reigns_person_idx。未将这些扫描描述为索引定位；收益来自筛选后仅返回候选并减少 JS 解析及无关关联读取。
- 人物搜索的精确匹配与其他实体的子串匹配分成 UNION 两分支。子串分支仍扫描轻量搜索索引，不能声称普通 B-tree 加速任意子串检索。
- 命运关系时间列目前没有索引，关系表仍可扫描；本库只有 ${env.metadata.counts.relations} 行，第一阶段依约不新增索引。
- 查询次数可能增加：版本前后核对、批量参数分组、命运线和所有权上下文都会增加查询。iOS 原生桥接串行执行，这一成本需要设备复测；不能仅依据返回行数判断。
- 原始 JSON 记录各相关 SQL 的实际 EXPLAIN QUERY PLAN。索引命中不代表双端区间都参与索引定位，也不强行消除小集合排序。

## 验证、回退与局限

- 独立旧实现对照：**${correctness.compared} 项通过**，含 ${correctness.contextCases} 个全部人物/在位上下文参数、${correctness.detailCases} 个代表详情、日期边界、搜索、地点和命运线端点。聚合 DTO 与旧实现比较；三层合并与旧前端 mergeTimelineSlices 的展示语义比较，保留其对无在位“君主”的底部排除。
- HTTP 校验 **${http.checks} 项通过**，包括三个接口的 schema、参数错误与版本冲突。
- 本次新增/受影响的定向测试通过，生产构建通过。全量测试有 **5 项既存失败**：shared 的三项先秦详情字段断言、一项宫伯标题断言，以及 Web 的赤眉旧日期断言；在未改造提交的独立副本中复现，日志保存在同目录。本次未修改这些历史称谓规则或数据来消除失败。
${regressions.length ? regressions.join('\n') : '- 本轮同名场景未出现中位耗时回退。'}
- 快速查询可能因版本一致性校验增加小额固定耗时；接口拆分的上下文也会增加流量。当前结果不能外推到更大数据库、远程网络或 iOS 设备。
- 版本检测比较查询前后的 datasetVersion，发现更新最多重试一次；前端各层同窗口且同版本才关联。30 秒版本轮询与窗口重聚焦会刷新缓存身份，未参与本基准的帧耗时。
- 当前没有启动并连接可供采样的 iOS 运行会话，因此原生桥接性能未测；浏览器只作功能检查，未测绘制前后差值。

## 复跑与原始数据

从仓库根目录依次执行：

\`\`\`bash
pnpm performance:contract
pnpm performance:http
pnpm performance:before
pnpm performance:after
pnpm --filter @eralens/api exec tsx scripts/performance/measure-context.ts
node apps/api/scripts/performance/report.mjs
\`\`\`

- [改造前全部样本与查询计划](performance/before.json)
- [改造后全部样本与查询计划](performance/after.json)
- [人物上下文单条 SQL 样本](performance/detail-context.json)
- [契约对照结果](performance/correctness.json)
- [HTTP 校验结果](performance/http-correctness.json)
- [旧提交 shared 失败复现日志](performance/baseline-shared-tests.log)
- [旧提交 Web 失败复现日志](performance/baseline-web-tests.log)

旧实现结束时间：${before.finishedAt}；新实现结束时间：${after.finishedAt}（UTC，完整采样时间保存在 JSON）。
`;
writeFileSync(new URL('../../../../docs/sqlite-performance.md',import.meta.url),text);
console.log('Wrote docs/sqlite-performance.md');
