# Development Notes
I am thinking about using python to 'build' the site. So I would write the various sections (like research and projects) in markdown, and then the `build.py` script would convert them to html.

Below is a half baked conversation with AI about that... lol

My prompt:
> Okay, with the python script option, I would have a directory of markdown files, that are either sections of pages, or entire pages.
> I would then build a python script that would build them into html and insert the html segments into the relevant parts of the existing html files..?
> Given that I already have some GHA and python scripts to update the CV, can you outline what a unified frame work would be where the site is 'built' with python every time I push it to github? (or if there is another workflow that is cleaner and makes more sense, I am all ears)


Perfect! Here's a unified framework that builds on your existing setup:

**Proposed Structure**
```
personal_portfolio/
├── content/                    # NEW: Markdown source files
│   ├── research.md
│   ├── intro.md
│   └── refs.bib               # Bibliography for citations
├── templates/                  # NEW: HTML templates with placeholders
│   ├── index.template.html
│   ├── projects.template.html
│   └── cv.template.html
├── build.py                   # NEW: Main build script
├── cv/
│   ├── refresh_cv.py          # EXISTING
│   └── requirements.txt       # UPDATE: add markdown, jinja2
├── .github/workflows/
│   └── build-site.yml         # NEW: Combined workflow
├── index.html                 # GENERATED (gitignored)
├── projects.html              # GENERATED (gitignored)
├── cv.html                    # GENERATED (already done by CV script)
└── imgs/
```

**Workflow**
Locally: Write markdown in content/, run python build.py, preview

On push to main: GHA runs:

refresh_cv.py (updates CV from Zotero)
build.py (builds all HTML from markdown + templates)
Commits generated HTML files
GitHub Pages serves the HTML
**Implementation**
Here's what I'll create for you:

1. build.py - Simple builder using Pandoc + Jinja2
```
#!/usr/bin/env python3
import subprocess
from pathlib import Path
from jinja2 import Template
import yaml

def convert_markdown_to_html(md_file, bib_file=None):
    """Convert markdown to HTML using pandoc with citation support"""
    cmd = ['pandoc', str(md_file), '--to', 'html']
    if bib_file and bib_file.exists():
        cmd.extend(['--bibliography', str(bib_file), '--citeproc'])
    result = subprocess.run(cmd, capture_output=True, text=True)
    return result.stdout

def build_page(template_path, output_path, content_dict):
    """Build HTML page from template and content"""
    template = Template(template_path.read_text())
    output = template.render(**content_dict)
    output_path.write_text(output)
    print(f"✓ Built {output_path}")

if __name__ == "__main__":
    # Convert markdown content
    content_dir = Path('content')
    bib_file = content_dir / 'refs.bib'
    
    research_html = convert_markdown_to_html(
        content_dir / 'research.md', 
        bib_file
    )
    intro_html = convert_markdown_to_html(content_dir / 'intro.md')
    
    # Build pages
    build_page(
        Path('templates/index.template.html'),
        Path('index.html'),
        {'research': research_html, 'intro': intro_html}
    )
```
2. .github/workflows/build-site.yml - Unified workflow
```
name: Build Site

on:
  push:
    branches: [ main ]
  schedule:
    - cron: '0 2 * * 0'  # Weekly CV updates
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest
    permissions:
      contents: write
    
    steps:
    - uses: actions/checkout@v4
    
    - uses: actions/setup-python@v5
      with:
        python-version: '3.11'
        cache: 'pip'
    
    - name: Install dependencies
      run: |
        pip install -r cv/requirements.txt
        sudo apt-get install -y pandoc
    
    - name: Update CV from Zotero
      env:
        ZOTERO_LIBRARY_ID: ${{ secrets.ZOTERO_LIBRARY_ID }}
        ZOTERO_API_KEY: ${{ secrets.ZOTERO_API_KEY }}
      run: |
        cd cv && python refresh_cv.py
    
    - name: Build site
      run: python build.py
    
    - name: Commit changes
      run: |
        git config --local user.email "actions@github.com"
        git config --local user.name "GitHub Actions"
        git add *.html cv/
        git diff --quiet && git diff --staged --quiet || \
          (git commit -m "chore: Auto-build site [skip ci]" && git push)
```

3. Update .gitignore to ignore generated files in dev, but commit them for GH Pages

Alternative (cleaner): Use two branches:

main - source (markdown, templates, build scripts)
gh-pages - built HTML only
Would you like me to set this up? I can:

Create the directory structure
Convert your current index.html into a template
Extract the research section into markdown
Write the build.py script
Create the GHA workflow
Or would you prefer a different approach?