UPDATE "reigns"
SET "title" = CASE "id"
  WHEN 'reign-liu-bang-han-king-han-west' THEN '沛公'
  WHEN 'reign-ying-zheng-qin' THEN '赵政'
  WHEN 'reign-hu-bilie-mongol-empire' THEN '薛禅汗'
  WHEN 'reign-hu-bilie-yuan' THEN '元世祖'
  WHEN 'reign-hu-bilie-yuan-unified' THEN '元世祖'
  WHEN 'reign-sun-yat-sen-roc' THEN '临时大总统'
  WHEN 'reign-yuan-shikai-roc' THEN '大总统'
  WHEN 'reign-li-yuanhong-roc' THEN '大总统'
  WHEN 'reign-feng-guozhang-roc' THEN '代理大总统'
  WHEN 'reign-xu-shichang-roc' THEN '大总统'
  WHEN 'reign-zhou-ziqi-roc' THEN '国务院摄行'
  WHEN 'reign-li-yuanhong-roc-2' THEN '大总统'
  WHEN 'reign-gao-lingwei-roc' THEN '国务院摄行'
  WHEN 'reign-cao-kun-roc' THEN '大总统'
  WHEN 'reign-huang-fu-roc' THEN '国务院摄行'
  WHEN 'reign-duan-qirui-roc' THEN '临时执政'
  WHEN 'reign-hu-weide-roc' THEN '国务院摄行'
  WHEN 'reign-yan-huiqing-roc' THEN '国务院摄行'
  WHEN 'reign-du-xigui-roc' THEN '国务院摄行'
  WHEN 'reign-gu-weijun-roc' THEN '国务院摄行'
  WHEN 'reign-hu-weide-roc-2' THEN '国务院摄行'
  WHEN 'reign-zhang-zuolin-roc' THEN '陆海军大元帅'
  WHEN 'reign-tan-yankai-roc' THEN '国民政府主席'
  WHEN 'reign-mao-zedong-prc' THEN '中央人民政府主席'
  WHEN 'reign-mao-zedong-prc-2' THEN '国家主席'
  WHEN 'reign-liu-shaoqi-prc' THEN '国家主席'
  WHEN 'reign-song-qingling-dong-biwu-prc' THEN '国家副主席共同代行国家主席职权'
  WHEN 'reign-dong-biwu-prc' THEN '国家代主席'
  WHEN 'reign-npc-standing-committee-prc' THEN '全国人大常委会'
  WHEN 'reign-li-xiannian-prc' THEN '国家主席'
  WHEN 'reign-yang-shangkun-prc' THEN '国家主席'
  WHEN 'reign-jiang-zemin-prc' THEN '国家主席'
  WHEN 'reign-hu-jintao-prc' THEN '国家主席'
  WHEN 'reign-xi-jinping-prc' THEN '国家主席'
  WHEN 'reign-jiang-jieshi-chairman-1-roc' THEN '国民政府主席'
  WHEN 'reign-lin-sen-roc' THEN '国民政府主席'
  WHEN 'reign-jiang-jieshi-chairman-roc' THEN '国民政府主席'
  WHEN 'reign-jiang-jieshi-roc' THEN '总统'
  WHEN 'reign-li-zongren-roc' THEN '代总统'
  WHEN 'reign-jiang-jieshi-roc-2' THEN '领导人'
  WHEN 'reign-yan-jiagan-roc' THEN '领导人'
  WHEN 'reign-jiang-jingguo-roc' THEN '领导人'
  WHEN 'reign-li-denghui-roc' THEN '领导人'
  WHEN 'reign-chen-shuibian-roc' THEN '领导人'
  WHEN 'reign-ma-yingjiu-roc' THEN '领导人'
  WHEN 'reign-cai-yingwen-roc' THEN '领导人'
  WHEN 'reign-lai-qingde-roc' THEN '领导人'
  ELSE "title"
END
WHERE "id" IN (
  'reign-liu-bang-han-king-han-west',
  'reign-ying-zheng-qin',
  'reign-hu-bilie-mongol-empire',
  'reign-hu-bilie-yuan',
  'reign-hu-bilie-yuan-unified',
  'reign-zhu-qiyu-regent-ming',
  'reign-sun-yat-sen-roc',
  'reign-yuan-shikai-roc',
  'reign-li-yuanhong-roc',
  'reign-feng-guozhang-roc',
  'reign-xu-shichang-roc',
  'reign-zhou-ziqi-roc',
  'reign-li-yuanhong-roc-2',
  'reign-gao-lingwei-roc',
  'reign-cao-kun-roc',
  'reign-huang-fu-roc',
  'reign-duan-qirui-roc',
  'reign-hu-weide-roc',
  'reign-yan-huiqing-roc',
  'reign-du-xigui-roc',
  'reign-gu-weijun-roc',
  'reign-hu-weide-roc-2',
  'reign-zhang-zuolin-roc',
  'reign-tan-yankai-roc',
  'reign-mao-zedong-prc',
  'reign-mao-zedong-prc-2',
  'reign-liu-shaoqi-prc',
  'reign-song-qingling-dong-biwu-prc',
  'reign-dong-biwu-prc',
  'reign-npc-standing-committee-prc',
  'reign-li-xiannian-prc',
  'reign-yang-shangkun-prc',
  'reign-jiang-zemin-prc',
  'reign-hu-jintao-prc',
  'reign-xi-jinping-prc',
  'reign-jiang-jieshi-chairman-1-roc',
  'reign-lin-sen-roc',
  'reign-jiang-jieshi-chairman-roc',
  'reign-jiang-jieshi-roc',
  'reign-li-zongren-roc',
  'reign-jiang-jieshi-roc-2',
  'reign-yan-jiagan-roc',
  'reign-jiang-jingguo-roc',
  'reign-li-denghui-roc',
  'reign-chen-shuibian-roc',
  'reign-ma-yingjiu-roc',
  'reign-cai-yingwen-roc',
  'reign-lai-qingde-roc'
);
