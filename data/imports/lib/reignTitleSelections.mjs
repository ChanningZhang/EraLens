/**
 * Explicit reign-title data for records that have a card-specific title.
 * Ming/Qing era names belong in era_names and are selected by the shared
 * period rule, not copied here. Their only emperor-title exceptions are
 * Zhu Yuanzhang's Wu reign, Nurhaci, and Huang Taiji.
 */
export const REIGN_TITLE_SELECTIONS = Object.freeze({
  "reign-liu-bang-han-king-han-west": "沛公",
  "reign-ying-zheng-qin": "赵政",
  "reign-hu-bilie-mongol-empire": "薛禅汗",
  "reign-hu-bilie-yuan": "世祖",
  "reign-hu-bilie-yuan-unified": "世祖",
  "reign-zhu-yuanzhang-wu-zhu": "吴",
  "reign-nurhaci-qing": "太祖",
  "reign-huang-taiji-qing": "太宗",
  "reign-zhu-qiyu-regent-ming": "郕王监国",
  "reign-zhu-yihai-ming-south": "鲁监国",
  "reign-guo-wei-regent-han-hou": "监国",
  "reign-sun-yat-sen-roc": "临时大总统",
  "reign-yuan-shikai-roc": "大总统",
  "reign-li-yuanhong-roc": "大总统",
  "reign-feng-guozhang-roc": "代理大总统",
  "reign-xu-shichang-roc": "大总统",
  "reign-zhou-ziqi-roc": "国务院摄行",
  "reign-li-yuanhong-roc-2": "大总统",
  "reign-gao-lingwei-roc": "国务院摄行",
  "reign-cao-kun-roc": "大总统",
  "reign-huang-fu-roc": "国务院摄行",
  "reign-duan-qirui-roc": "临时执政",
  "reign-hu-weide-roc": "国务院摄行",
  "reign-yan-huiqing-roc": "国务院摄行",
  "reign-du-xigui-roc": "国务院摄行",
  "reign-gu-weijun-roc": "国务院摄行",
  "reign-hu-weide-roc-2": "国务院摄行",
  "reign-zhang-zuolin-roc": "陆海军大元帅",
  "reign-tan-yankai-roc": "国民政府主席",
  "reign-mao-zedong-prc": "中央人民政府主席",
  "reign-mao-zedong-prc-2": "国家主席",
  "reign-liu-shaoqi-prc": "国家主席",
  "reign-song-qingling-dong-biwu-prc": "国家副主席共同代行国家主席职权",
  "reign-dong-biwu-prc": "国家代主席",
  "reign-npc-standing-committee-prc": "全国人大常委会",
  "reign-li-xiannian-prc": "国家主席",
  "reign-yang-shangkun-prc": "国家主席",
  "reign-jiang-zemin-prc": "国家主席",
  "reign-hu-jintao-prc": "国家主席",
  "reign-xi-jinping-prc": "国家主席",
  "reign-jiang-jieshi-chairman-1-roc": "国民政府主席",
  "reign-lin-sen-roc": "国民政府主席",
  "reign-jiang-jieshi-chairman-roc": "国民政府主席",
  "reign-jiang-jieshi-roc": "总统",
  "reign-li-zongren-roc": "代总统",
  "reign-jiang-jieshi-roc-2": "领导人",
  "reign-yan-jiagan-roc": "领导人",
  "reign-jiang-jingguo-roc": "领导人",
  "reign-li-denghui-roc": "领导人",
  "reign-chen-shuibian-roc": "领导人",
  "reign-ma-yingjiu-roc": "领导人",
  "reign-cai-yingwen-roc": "领导人",
  "reign-lai-qingde-roc": "领导人",
});

export function resolveReignTitle(reign) {
  const selectedTitle = REIGN_TITLE_SELECTIONS[reign.id];
  if (selectedTitle !== undefined) return selectedTitle;
  return "";
}
