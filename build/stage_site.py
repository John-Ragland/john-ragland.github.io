#!/usr/bin/env python3
"""Collect the built site into _site/ for the GitHub Pages deploy.

Run after build/refresh_cv.py and build/build.py. Everything listed here is a
build artifact (or a static asset) — nothing generated is committed to git.
"""
import shutil
from pathlib import Path

ROOT = Path(__file__).parent.parent
SITE = ROOT / "_site"

FILES = [
    "index.html",
    "cv.html",
    "John_Ragland_CV.pdf",
    "style.css",
    "CNAME",
]

DIRS = [
    "media",
]

if SITE.exists():
    shutil.rmtree(SITE)
SITE.mkdir()

missing = []

for name in FILES:
    src = ROOT / name
    if src.exists():
        shutil.copy2(src, SITE / name)
        print(f"✓ {name}")
    else:
        missing.append(name)

for name in DIRS:
    src = ROOT / name
    if src.is_dir():
        shutil.copytree(src, SITE / name)
        print(f"✓ {name}/")
    else:
        missing.append(name + "/")

if missing:
    raise SystemExit(f"✗ Missing expected site files: {', '.join(missing)}")

print(f"\nStaged site at {SITE}")
