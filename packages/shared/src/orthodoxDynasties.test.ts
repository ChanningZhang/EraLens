import { describe, expect, it } from "vitest";
import { absMonth } from "./time";
import {
  isOrthodoxAt,
  isOrthodoxReign,
  overlapsOrthodoxSpan,
  ORTHODOX_END_ABS,
  ORTHODOX_FROM_ABS,
  resolveOrthodoxFromAbs,
  resolveOrthodoxSpan,
} from "./orthodoxDynasties";
import {
  ORTHODOX_COLOR_TOKEN,
  resolveDynastyColorToken,
} from "./dynastyColors";

describe("orthodoxDynasties", () => {
  it("marks qin as orthodox only after unification", () => {
    const qin = { id: "qin", startAbs: absMonth(-770) };
    expect(resolveOrthodoxFromAbs(qin)).toBe(ORTHODOX_FROM_ABS.qin);
    expect(isOrthodoxAt(qin, absMonth(-770))).toBe(false);
    expect(isOrthodoxAt(qin, absMonth(-221))).toBe(true);
  });

  it("marks qing as orthodox only from shunzhi after entering china proper", () => {
    const qing = {
      id: "qing",
      startAbs: absMonth(1616, 2),
      endAbs: absMonth(1912, 2),
    };
    expect(resolveOrthodoxFromAbs(qing)).toBe(ORTHODOX_FROM_ABS.qing);
    expect(isOrthodoxAt(qing, absMonth(1636))).toBe(false);
    expect(isOrthodoxAt(qing, absMonth(1643))).toBe(false);
    expect(isOrthodoxAt(qing, absMonth(1644))).toBe(true);
    expect(
      overlapsOrthodoxSpan(qing, absMonth(1616), absMonth(1626)),
    ).toBe(false);
    expect(
      overlapsOrthodoxSpan(qing, absMonth(1626), absMonth(1643)),
    ).toBe(false);
    expect(
      overlapsOrthodoxSpan(qing, absMonth(1643), absMonth(1661)),
    ).toBe(true);
  });

  it("gives gold to 顺治 though he acceded in 1643 before qing orthodox at 1644", () => {
    const qing = {
      id: "qing",
      startAbs: absMonth(1616, 2),
      endAbs: absMonth(1912, 2),
      orthodoxFromAbs: ORTHODOX_FROM_ABS.qing,
    };
    const shunzhi = {
      startAbs: absMonth(1643, 10),
      endAbs: absMonth(1661, 2),
    };
    const huangTaiji = {
      startAbs: absMonth(1626, 10),
      endAbs: absMonth(1643, 9),
    };
    expect(isOrthodoxReign(qing, shunzhi)).toBe(true);
    expect(isOrthodoxReign(qing, huangTaiji)).toBe(false);
  });

  it("marks xia as orthodox from dynasty start", () => {
    const xia = { id: "xia", startAbs: absMonth(-2070) };
    expect(resolveOrthodoxFromAbs(xia)).toBe(xia.startAbs);
    expect(isOrthodoxAt(xia, xia.startAbs)).toBe(true);
  });

  it("prefers persisted orthodoxFromAbs override", () => {
    const dynasty = { id: "qin", startAbs: absMonth(-770), orthodoxFromAbs: absMonth(-220) };
    expect(resolveOrthodoxFromAbs(dynasty)).toBe(absMonth(-220));
  });

  it("builds orthodox span from orthodox start through dynasty end", () => {
    const qin = {
      id: "qin",
      startAbs: absMonth(-770),
      endAbs: absMonth(-206),
    };
    expect(resolveOrthodoxSpan(qin)).toEqual({
      startAbs: ORTHODOX_FROM_ABS.qin,
      endAbs: absMonth(-206),
    });
  });

  it("does not mark pre-unification qin king reign as orthodox", () => {
    const qin = {
      id: "qin",
      startAbs: absMonth(-770),
      endAbs: absMonth(-206),
    };
    const yingZhengKing = {
      startAbs: absMonth(-247),
      endAbs: absMonth(-221, 9),
    };
    const yingZhengEmperor = {
      startAbs: absMonth(-221, 9),
      endAbs: absMonth(-210),
    };
    expect(
      overlapsOrthodoxSpan(qin, yingZhengKing.startAbs, yingZhengKing.endAbs),
    ).toBe(true);
    expect(isOrthodoxReign(qin, yingZhengKing)).toBe(false);
    expect(isOrthodoxReign(qin, yingZhengEmperor)).toBe(true);
  });

  it("marks reigns that overlap orthodox span even when startAbs is earlier", () => {
    const jinWest = {
      id: "jin-west",
      startAbs: absMonth(266, 2),
      endAbs: absMonth(316, 4),
    };
    expect(isOrthodoxAt(jinWest, absMonth(266, 1))).toBe(false);
    expect(
      overlapsOrthodoxSpan(jinWest, absMonth(266, 1), absMonth(290, 12)),
    ).toBe(true);
    expect(
      overlapsOrthodoxSpan(jinWest, absMonth(266, 2), absMonth(290, 12)),
    ).toBe(true);
  });

  it("does not mark 曹丕魏王嗣位 as orthodox before he declared emperor", () => {
    const wei = {
      id: "wei",
      startAbs: absMonth(208, 12),
      endAbs: absMonth(266, 2),
      orthodoxFromAbs: absMonth(220, 12),
    };
    const caoPiKing = {
      startAbs: absMonth(220, 3),
      endAbs: absMonth(220, 12),
    };
    const caoPiEmperor = {
      startAbs: absMonth(220, 12),
      endAbs: absMonth(226, 6),
    };
    expect(isOrthodoxReign(wei, caoPiKing)).toBe(false);
    expect(isOrthodoxReign(wei, caoPiEmperor)).toBe(true);
  });

  it("gives gold to the Sui main line, not to 杨侑 while 炀帝 still lived", () => {
    const sui = {
      id: "sui",
      startAbs: absMonth(581),
      endAbs: absMonth(618),
    };
    const yangGuang = { startAbs: absMonth(604), endAbs: absMonth(618) };
    const yangHao = { startAbs: absMonth(618), endAbs: absMonth(618) };
    const yangYou = {
      startAbs: absMonth(617),
      endAbs: absMonth(618),
      claimTrack: "changan",
    };
    expect(isOrthodoxReign(sui, yangGuang)).toBe(true);
    expect(isOrthodoxReign(sui, yangHao)).toBe(true);
    expect(isOrthodoxReign(sui, yangYou)).toBe(false);
  });

  it("marks roc as orthodox from dynasty start", () => {
    const roc = { id: "roc", startAbs: absMonth(1912, 1) };
    expect(resolveOrthodoxFromAbs(roc)).toBe(roc.startAbs);
    expect(isOrthodoxAt(roc, absMonth(1912, 1))).toBe(true);
    expect(isOrthodoxAt(roc, absMonth(1911))).toBe(false);
  });

  it("marks song-south as orthodox until gongdi surrender; duanzong and dibing stay on main line without gold", () => {
    const songSouth = {
      id: "song-south",
      startAbs: absMonth(1127),
      endAbs: absMonth(1279),
    };
    expect(resolveOrthodoxSpan(songSouth)).toEqual({
      startAbs: songSouth.startAbs,
      endAbs: ORTHODOX_END_ABS["song-south"],
    });
    expect(isOrthodoxReign(songSouth, { startAbs: absMonth(1274, 8), endAbs: absMonth(1276, 2) })).toBe(true);
    expect(isOrthodoxReign(songSouth, { startAbs: absMonth(1276, 6), endAbs: absMonth(1278, 5) })).toBe(false);
    expect(isOrthodoxReign(songSouth, { startAbs: absMonth(1278, 5), endAbs: absMonth(1279, 3) })).toBe(false);
  });

  it("marks yuan as orthodox from gongdi surrender until 1368 even when dynasty ends in 1388", () => {
    const yuan = {
      id: "yuan",
      startAbs: absMonth(1271, 12),
      endAbs: absMonth(1388),
    };
    expect(resolveOrthodoxFromAbs(yuan)).toBe(ORTHODOX_FROM_ABS.yuan);
    expect(resolveOrthodoxSpan(yuan)).toEqual({
      startAbs: ORTHODOX_FROM_ABS.yuan,
      endAbs: ORTHODOX_END_ABS.yuan,
    });
    expect(isOrthodoxAt(yuan, absMonth(1275))).toBe(false);
    expect(isOrthodoxAt(yuan, absMonth(1276, 2))).toBe(true);
    expect(isOrthodoxAt(yuan, absMonth(1278))).toBe(true);
    expect(isOrthodoxAt(yuan, absMonth(1367))).toBe(true);
    expect(isOrthodoxAt(yuan, absMonth(1368))).toBe(true);
    expect(isOrthodoxAt(yuan, absMonth(1369))).toBe(false);
    expect(
      overlapsOrthodoxSpan(yuan, absMonth(1368), absMonth(1370)),
    ).toBe(false);
    expect(
      overlapsOrthodoxSpan(yuan, absMonth(1370), absMonth(1378)),
    ).toBe(false);
    expect(
      overlapsOrthodoxSpan(yuan, absMonth(1367), absMonth(1370)),
    ).toBe(true);
    expect(
      isOrthodoxReign(yuan, {
        startAbs: absMonth(1271, 12),
        endAbs: absMonth(1276, 2),
      }),
    ).toBe(false);
    expect(
      isOrthodoxReign(yuan, {
        startAbs: absMonth(1276, 2),
        endAbs: absMonth(1294, 2),
      }),
    ).toBe(true);
    expect(
      isOrthodoxReign(yuan, {
        startAbs: absMonth(1333, 7),
        endAbs: absMonth(1368, 1),
      }),
    ).toBe(true);
    expect(
      isOrthodoxReign(yuan, {
        startAbs: absMonth(1368),
        endAbs: absMonth(1370, 5),
      }),
    ).toBe(false);
    expect(
      isOrthodoxReign(yuan, {
        startAbs: absMonth(1370, 5),
        endAbs: absMonth(1378, 5),
      }),
    ).toBe(false);
  });

  it("marks zhou-wu as orthodox for wu zetian interregnum", () => {
    const zhouWu = {
      id: "zhou-wu",
      startAbs: absMonth(690, 10),
      endAbs: absMonth(705, 1),
    };
    expect(resolveOrthodoxFromAbs(zhouWu)).toBe(zhouWu.startAbs);
    expect(isOrthodoxAt(zhouWu, absMonth(690, 9))).toBe(false);
    expect(isOrthodoxAt(zhouWu, absMonth(690, 10))).toBe(true);
    expect(isOrthodoxAt(zhouWu, absMonth(700))).toBe(true);
    expect(isOrthodoxAt(zhouWu, absMonth(705, 1))).toBe(true);
    expect(isOrthodoxAt(zhouWu, absMonth(705, 2))).toBe(false);
  });

  it("does not mark split-period dynasties as orthodox", () => {
    const songLiu = { id: "song-liu", startAbs: absMonth(420, 7) };
    const weiNorth = { id: "wei-north", startAbs: absMonth(386) };
    const jinEast = { id: "jin-east", startAbs: absMonth(317) };
    const songNorth = { id: "song-north", startAbs: absMonth(960) };
    const sui = { id: "sui", startAbs: absMonth(581) };

    expect(resolveOrthodoxFromAbs(songLiu)).toBeUndefined();
    expect(resolveOrthodoxFromAbs(weiNorth)).toBeUndefined();
    expect(resolveOrthodoxFromAbs(jinEast)).toBe(jinEast.startAbs);
    expect(resolveOrthodoxFromAbs(songNorth)).toBe(songNorth.startAbs);
    expect(resolveOrthodoxFromAbs(sui)).toBe(sui.startAbs);
  });

  it("does not mark xin or gengshi interregnums as orthodox", () => {
    const xin = { id: "xin", startAbs: absMonth(9, 1) };
    const gengshi = { id: "han-gengshi", startAbs: absMonth(23, 1) };
    const hanEast = { id: "han-east", startAbs: absMonth(25, 8) };

    expect(resolveOrthodoxFromAbs(xin)).toBeUndefined();
    expect(resolveOrthodoxFromAbs(gengshi)).toBeUndefined();
    expect(resolveOrthodoxFromAbs(hanEast)).toBe(hanEast.startAbs);
  });
});

describe("resolveDynastyColorToken orthodox display", () => {
  it("returns gold for orthodox periods and base token otherwise", () => {
    const qin = {
      id: "qin",
      startAbs: absMonth(-770),
      colorToken: "ochre" as const,
    };
    expect(resolveDynastyColorToken(qin, absMonth(-500))).toBe("ochre");
    expect(resolveDynastyColorToken(qin, absMonth(-221))).toBe(ORTHODOX_COLOR_TOKEN);
  });
});
