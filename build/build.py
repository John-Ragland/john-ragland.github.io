#!/usr/bin/env python3
import pypandoc
from pathlib import Path
from bs4 import BeautifulSoup

ROOT = Path(__file__).parent.parent
CONTENT = ROOT / "content"
TEMPLATE = ROOT / "templates" / "page.html"
BIB = ROOT / "refs.bib"

PAGES = {
    "index.md": "index.html",
    "projects.md": "projects.html",
}


def add_backlinks(html: str) -> str:
    soup = BeautifulSoup(html, "html.parser")

    # Give each inline citation span a unique id and collect citekey -> [ids]
    cite_ids: dict[str, list[str]] = {}
    for span in soup.find_all("span", class_="citation"):
        citekey = span.get("data-cites", "")
        if not citekey:
            continue
        cite_ids.setdefault(citekey, [])
        cite_id = f"cite-{citekey}-{len(cite_ids[citekey])}"
        span["id"] = cite_id
        cite_ids[citekey].append(cite_id)

    # Append ↩ back-links to each reference entry
    for citekey, ids in cite_ids.items():
        ref_div = soup.find(id=f"ref-{citekey}")
        if not ref_div:
            continue
        right = ref_div.find(class_="csl-right-inline") or ref_div
        for i, cite_id in enumerate(ids):
            link = soup.new_tag("a", href=f"#{cite_id}", title="Back to text")
            link.string = "↩" if i == 0 else f"↩{i + 1}"
            right.append(" ")
            right.append(link)

    return str(soup)


for src_name, out_name in PAGES.items():
    src = CONTENT / src_name
    out = ROOT / out_name
    html = pypandoc.convert_file(
        str(src),
        "html",
        extra_args=[
            "--citeproc",
            f"--bibliography={BIB}",
            f"--template={TEMPLATE}",
            f"--csl={ROOT / 'templates' / 'numeric-superscript.csl'}",
            "--metadata=reference-section-title:Sources",
            "--metadata=link-citations=true",
            "--standalone",
        ],
    )
    out.write_text(add_backlinks(html))
    print(f"Built {out_name}")
