#!/usr/bin/env python3
"""Refresh Wikipedia sources in 大陆简体 (variant=zh-cn). Do not convert 繁简 locally."""
from __future__ import annotations

import json
import os
import re
from html import unescape
from urllib.parse import quote
from urllib.request import Request, urlopen

PAGES = {
    "wiki-zhou-feudal.json": "周朝诸侯国君主列表",
    "wiki-qi.json": "齐国君主列表",
    "wiki-qin.json": "秦國君主列表",
}

UA = "EraLens/1.0 (historical data import; zh-cn variant)"


def api_fetch(title: str) -> dict:
    url = (
        "https://zh.wikipedia.org/w/api.php?action=parse"
        f"&page={quote(title)}&prop=text&variant=zh-cn&format=json"
        "&formatversion=2&redirects=1"
    )
    req = Request(url, headers={"User-Agent": UA})
    with urlopen(req, timeout=60) as resp:
        data = json.load(resp)
    if "error" in data:
        raise SystemExit(f"{title}: {data['error']}")
    return data


def strip_edit(html: str) -> str:
    return re.sub(r'<span class="mw-editsection">.*?</span>', "", html, flags=re.S)


def cell_to_md(html: str) -> str:
    def repl_a(m):
        attrs, inner = m.group(1), m.group(2)
        href = re.search(r'href="([^"]+)"', attrs)
        title = re.search(r'title="([^"]*)"', attrs)
        text = unescape(re.sub("<[^>]+>", "", inner)).strip()
        if not href:
            return text
        h = unescape(href.group(1))
        t = unescape(title.group(1)) if title else ""
        return f'[{text}]({h} "{t}")' if t else f"[{text}]({h})"

    s = re.sub(r"<a\s+([^>]+)>(.*?)</a>", repl_a, html, flags=re.S)
    s = re.sub(r"<sup\b[^>]*>.*?</sup>", "", s, flags=re.S)
    s = re.sub(r"<br\s*/?>", " ", s, flags=re.I)
    s = re.sub(r"<[^>]+>", "", s)
    s = unescape(s).replace("\n", " ").replace("|", "/")
    return re.sub(r"\s+", " ", s).strip()


def header_row_index(rows: list[list[str]]) -> int:
    best = 0
    best_score = -1
    for i, row in enumerate(rows[:8]):
        joined = "".join(row)
        score = len(row)
        if re.search(r"称号|谥号|君主|姓名|在位|上任", joined):
            score += 10
        if len(row) >= 3:
            score += 5
        if score > best_score:
            best, best_score = i, score
    return best


def table_to_md(table_html: str) -> str:
    rows = []
    for tr in re.findall(r"<tr\b[^>]*>(.*?)</tr>", table_html, flags=re.S):
        cells = re.findall(r"<t[hd]\b[^>]*>(.*?)</t[hd]>", tr, flags=re.S)
        if cells:
            rows.append([cell_to_md(c) for c in cells])
    if not rows:
        return ""
    lines = []
    cap = re.search(r"<caption\b[^>]*>(.*?)</caption>", table_html, flags=re.S)
    if cap:
        cap_text = cell_to_md(cap.group(1))
        if cap_text:
            lines.append(cap_text)
    hi = header_row_index(rows)
    header = rows[hi]
    lines.append("| " + " | ".join(header) + " |")
    lines.append("| " + " | ".join(["---"] * len(header)) + " |")
    for row in rows[hi + 1 :]:
        if len(row) == 1 and not row[0]:
            continue
        while len(row) < len(header):
            row.append("")
        lines.append("| " + " | ".join(row[: len(header)]) + " |")
    return "\n".join(lines)


def extract_tables(html: str) -> list[str]:
    """Return innermost <table> fragments (nested navboxes contain the real wikitable)."""
    out = []
    for m in re.finditer(r"<table\b[^>]*>(?:(?!<table\b).)*?</table>", html, flags=re.S):
        out.append(m.group(0))
    return out


def table_is_useful(md: str) -> bool:
    header = next((ln for ln in md.split("\n") if ln.startswith("|") and "---" not in ln), "")
    cols = [c.strip() for c in header.split("|") if c.strip()]
    if len(cols) < 3:
        return False
    joined = "".join(cols)
    return bool(re.search(r"称号|谥号|君主|姓名|在位|上任", joined))


def html_to_md(html: str) -> str:
    html = re.sub(r"<style[^>]*>.*?</style>", "", html, flags=re.S)
    html = strip_edit(html)
    parts = []
    i = 0
    heading_or_table = re.compile(r"<h([2-4])\b[^>]*>.*?</h\1>|<table\b", re.S)
    while True:
        m = heading_or_table.search(html, i)
        if not m:
            break
        if m.group(0).startswith("<h"):
            lv = int(m.group(1))
            text = unescape(re.sub("<[^>]+>", "", m.group(0))).strip()
            text = re.sub(r"\[编辑.*", "", text).strip()
            if text:
                parts.append("#" * lv + " " + text)
            i = m.end()
            continue
        # full (possibly nested) table starting at m.start()
        start = m.start()
        depth = 0
        pos = start
        end = None
        for t in re.finditer(r"<table\b[^>]*>|</table>", html[start:], flags=re.S):
            token = t.group(0)
            if token.startswith("<table"):
                depth += 1
            else:
                depth -= 1
                if depth == 0:
                    end = start + t.end()
                    break
        if end is None:
            i = start + 6
            continue
        block = html[start:end]
        for inner in extract_tables(block):
            md = table_to_md(inner)
            if md and table_is_useful(md):
                parts.append(md)
        i = end
    return "\n\n".join(parts) + "\n"


def main() -> None:
    outdir = os.path.join(os.path.dirname(__file__), "sources")
    os.makedirs(outdir, exist_ok=True)
    for filename, title in PAGES.items():
        try:
            data = api_fetch(title)
        except SystemExit as exc:
            print(f"skip {filename}: {exc}")
            continue
        resolved = data["parse"]["title"]
        md = html_to_md(data["parse"]["text"])
        payload = {
            "source_title": resolved,
            "variant": "zh-cn",
            "url": f"https://zh.wikipedia.org/zh-cn/{resolved}",
            "raw_content": md,
        }
        path = os.path.join(outdir, filename)
        with open(path, "w", encoding="utf-8") as f:
            json.dump(payload, f, ensure_ascii=False)
        print(f"{filename}: {resolved} ({len(md)} chars)")


if __name__ == "__main__":
    main()
