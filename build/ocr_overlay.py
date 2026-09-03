"""Generate a selectable, invisible text overlay for a scanned image of typewritten text.

Runs Tesseract OCR in hOCR mode to get per-word bounding boxes, then emits an
HTML snippet with the image plus a transparent text layer positioned on top
of it (percentage-based, so it stays aligned when the image is responsive).

Low-confidence words are printed as a proofreading checklist -- OCR on
scanned/stylized text is never perfect, so review and hand-correct the
generated span text before publishing.

Usage:
    python build/ocr_overlay.py imgs/website_blurb.jpeg [-o output.html] [--min-conf 70]
"""
import argparse
import subprocess
import sys
import tempfile
from pathlib import Path

from bs4 import BeautifulSoup


def parse_bbox(title: str) -> tuple[int, int, int, int]:
    """Extract 'bbox x0 y0 x1 y1' from an hOCR title attribute."""
    for part in title.split(";"):
        part = part.strip()
        if part.startswith("bbox"):
            x0, y0, x1, y1 = (int(v) for v in part.split()[1:5])
            return x0, y0, x1, y1
    raise ValueError(f"no bbox found in title: {title!r}")


def parse_conf(title: str) -> float:
    for part in title.split(";"):
        part = part.strip()
        if part.startswith("x_wconf"):
            return float(part.split()[1])
    return 100.0


def run_tesseract_hocr(image_path: Path) -> str:
    with tempfile.TemporaryDirectory() as tmpdir:
        out_base = Path(tmpdir) / "ocr"
        subprocess.run(
            ["tesseract", str(image_path), str(out_base), "hocr"],
            check=True,
            capture_output=True,
        )
        return (out_base.with_suffix(".hocr")).read_text()


def extract_words(hocr: str):
    soup = BeautifulSoup(hocr, "html.parser")
    page = soup.find("div", class_="ocr_page")
    page_x0, page_y0, page_x1, page_y1 = parse_bbox(page["title"])
    page_w, page_h = page_x1 - page_x0, page_y1 - page_y0

    words = []
    for span in soup.find_all("span", class_="ocrx_word"):
        text = span.get_text().strip()
        if not text:
            continue
        x0, y0, x1, y1 = parse_bbox(span["title"])
        conf = parse_conf(span["title"])
        words.append(
            {
                "text": text,
                "conf": conf,
                "left_pct": 100 * x0 / page_w,
                "top_pct": 100 * y0 / page_h,
                "width_pct": 100 * (x1 - x0) / page_w,
                "height_pct": 100 * (y1 - y0) / page_h,
                "font_size_vw": round(100 * (y1 - y0) / page_w, 3),
            }
        )
    return words, page_w, page_h


def build_html(image_path: Path, words: list[dict]) -> str:
    alt_text = " ".join(w["text"] for w in words)
    lines = [
        '<div class="ocr-overlay">',
        f'  <img src="{image_path.as_posix()}" alt="{alt_text}">',
        '  <div class="ocr-text">',
    ]
    for w in words:
        style = (
            f"left:{w['left_pct']:.3f}%; top:{w['top_pct']:.3f}%; "
            f"width:{w['width_pct']:.3f}%; height:{w['height_pct']:.3f}%; "
            f"font-size:{w['font_size_vw']:.3f}vw;"
        )
        lines.append(f'    <span class="ocr-word" style="{style}">{w["text"]} </span>')
    lines.append("  </div>")
    lines.append("</div>")
    return "\n".join(lines)


def print_report(words: list[dict], min_conf: float):
    flagged = [w for w in words if w["conf"] < min_conf]
    if not flagged:
        print(f"No words below confidence {min_conf:.0f} -- still proofread before publishing.", file=sys.stderr)
        return
    print(f"\n{len(flagged)} low-confidence word(s) to review (conf < {min_conf:.0f}):", file=sys.stderr)
    for w in flagged:
        print(f"  {w['conf']:5.1f}  {w['text']!r}", file=sys.stderr)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("image", type=Path, help="path to the scanned image")
    parser.add_argument("-o", "--output", type=Path, help="write HTML snippet here (default: stdout)")
    parser.add_argument("--min-conf", type=float, default=70.0, help="flag words below this OCR confidence (0-100)")
    args = parser.parse_args()

    hocr = run_tesseract_hocr(args.image)
    words, page_w, page_h = extract_words(hocr)
    if not words:
        print("No text detected in image.", file=sys.stderr)
        sys.exit(1)

    html = build_html(args.image, words)
    if args.output:
        args.output.write_text(html + "\n")
        print(f"Wrote overlay HTML to {args.output}", file=sys.stderr)
    else:
        print(html)

    print_report(words, args.min_conf)


if __name__ == "__main__":
    main()
