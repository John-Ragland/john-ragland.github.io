"""
Post-process the rendercv generated HTML to match the website's style.
This script:
1. Reads the generated cv.html from rendercv
2. Wraps it with the same header/footer as other pages
3. Adds a link to download the PDF
4. Outputs to the repo root as cv.html
"""

import os
from pathlib import Path
import re

CV_DIR = Path(__file__).parent.parent / "cv"
ROOT = Path(__file__).parent.parent


def create_simple_cv_content(cv_body):
    """Transform rendercv markdown-body HTML into SimpleCSS-compatible structure"""

    # Remove the markdown-body wrapper and styling
    cv_body = re.sub(r'<article class="markdown-body">', '', cv_body)
    cv_body = re.sub(r'</article>', '', cv_body)

    # Add icons to contact information
    cv_body = re.sub(r'<li>Email:', '<li><i class="fas fa-envelope"></i> Email:', cv_body)
    cv_body = re.sub(r'<li>Location:', '<li><i class="fas fa-map-marker-alt"></i> Location:', cv_body)
    cv_body = re.sub(r'<li>LinkedIn:', '<li><i class="fab fa-linkedin"></i> LinkedIn:', cv_body)
    cv_body = re.sub(r'<li>GitHub:', '<li><i class="fab fa-github"></i> GitHub:', cv_body)

    # Drop the auto-generated "<Name>'s CV" title - the site header already shows the name
    cv_body = re.sub(r'<h1>[^<]*\'s CV</h1>\s*', '', cv_body)

    # Collapse rendercv's li > p wrapper, which otherwise adds a paragraph's
    # worth of margin around every bullet (rendercv's own stylesheet zeroes
    # this out, but we don't carry that stylesheet over).
    cv_body = re.sub(r'<li>\s*<p>(.*?)</p>\s*</li>', r'<li>\1</li>', cv_body, flags=re.DOTALL)

    # Collapse each education entry's "<h2>Institution, Area</h2><p>Degree</p><p>Date</p>"
    # into a single header row (degree / institution / date), matching the PDF layout.
    cv_body = re.sub(
        r'<h2>(.*?)</h2>\s*<p><strong>(.*?)</strong></p>\s*<p>(.*?)</p>',
        r'<div class="cv-entry-header">'
        r'<span class="cv-degree">\2</span>'
        r'<span class="cv-title">\1</span>'
        r'<span class="cv-date">\3</span>'
        r'</div>',
        cv_body,
    )

    return cv_body

def create_cv_html():
    """Generate the final cv.html with SimpleCSS styling"""

    # Paths
    generated_html = CV_DIR / 'rendercv_output' / 'John_Ragland_CV.html'
    generated_pdf = CV_DIR / 'rendercv_output' / 'John_Ragland_CV.pdf'
    final_output = ROOT / 'cv.html'
    pdf_output = ROOT / 'John_Ragland_CV.pdf'

    # Check if files exist
    if not generated_html.exists():
        raise FileNotFoundError(f"Generated CV HTML not found at {generated_html}")

    # Read the generated CV content
    with open(generated_html, 'r', encoding='utf-8') as f:
        cv_content = f.read()

    # Extract just the body content
    body_match = re.search(r'<body[^>]*>(.*)</body>', cv_content, re.DOTALL)
    if body_match:
        cv_body = body_match.group(1)
    else:
        cv_body = cv_content

    # Clean up the content for SimpleCSS
    cv_body = create_simple_cv_content(cv_body)

    # Create the full HTML with custom header and SimpleCSS
    html_template = f"""<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CV - John Ragland</title>
    <meta name="description" content="Curriculum Vitae">

    <!-- SimpleCSS -->
    <link rel="stylesheet" href="https://cdn.simplecss.org/simple.min.css">

    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- Google Font to match the PDF (Source Sans 3) -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Source+Sans+3:ital,wght@0,400;0,600;0,700;1,400&display=swap" rel="stylesheet">

    <!-- Custom CV Styles -->
    <style>
        /* CV-specific styling to match the PDF (typst "classic" theme) layout */
        main {{
            max-width: 820px;
        }}

        .cv-section {{
            font-family: "Source Sans 3", sans-serif;
            color: rgb(0, 0, 0);
            text-align: justify;
            padding: 1rem 0;
        }}

        .cv-section h1 {{
            color: rgb(0, 79, 144);
            border-bottom: 2px solid rgb(0, 79, 144);
            padding-bottom: 0.3rem;
            font-size: 1.3rem;
            font-weight: 700;
            margin-top: 1.8rem;
            margin-bottom: 0.8rem;
        }}

        /* education entry header row: degree | institution, area | date */
        .cv-entry-header {{
            display: flex;
            align-items: baseline;
            gap: 0.75rem;
            margin-top: 0.9rem;
        }}

        .cv-entry-header .cv-degree {{
            flex: 0 0 2.5rem;
            font-weight: 700;
        }}

        .cv-entry-header .cv-title {{
            flex: 1 1 auto;
            font-weight: 700;
        }}

        .cv-entry-header .cv-date {{
            flex: 0 0 auto;
            color: #555;
        }}

        .cv-section ul {{
            margin-left: 1.5rem;
            margin-top: 0.3em;
            margin-bottom: 0.3em;
            line-height: 1.5;
        }}

        .cv-section li {{
            margin-bottom: 0.3em;
        }}

        .cv-section a {{
            color: rgb(0, 79, 144);
            text-decoration: none;
        }}

        .cv-section a:hover {{
            text-decoration: underline;
        }}

        /* Icon spacing */
        .cv-section i {{
            margin-right: 0.5em;
            color: rgb(0, 79, 144);
            width: 1.2em;
            text-align: center;
        }}

        /* PDF download link section - drop SimpleCSS's default section
           border/spacing so it doesn't render as a divider line */
        .cv-pdf-link {{
            border: none !important;
            margin: 0 !important;
            padding: 0 0 1rem !important;
        }}

        .cv-pdf-link .button {{
            font-size: 0.85rem;
            padding: 0.35em 0.9em;
        }}

        /* Contact info at top */
        .cv-section > ul:first-of-type {{
            list-style: none;
            margin-left: 0;
            padding-left: 0;
            text-align: left;
            margin-bottom: 1.5rem;
        }}
    </style>

    <!-- Custom CSS (optional) -->
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <header>
        <h1><a href="index.html" style="text-decoration: none; color: inherit;">John Ragland</a></h1>
        <p>
            Postdoctoral Fellow - Woods Hole Oceanographic Institution</br>
            Developing tools for observing the ocean with sound
        </p>
        <nav>
            <a href="index.html#research">Research</a>
            <a href="projects.html">Project Highlights</a>
            <a href="cv.html">CV</a>
        </nav>
    </header>

    <main>
        <section class="cv-pdf-link">
            <a href="John_Ragland_CV.pdf" class="button" download>Download</a>
        </section>

        <section class="cv-section">
{cv_body}
        </section>
    </main>

    <footer>
        <p>
            &copy; 2026 John Ragland. Built with <a href="https://simplecss.org/">SimpleCSS</a>.
        </p>
    </footer>
</body>
</html>
"""

    # Write the final HTML
    with open(final_output, 'w', encoding='utf-8') as f:
        f.write(html_template)

    print(f"✓ Created {final_output}")

    # Copy the PDF to the web root
    if generated_pdf.exists():
        import shutil
        shutil.copy(generated_pdf, pdf_output)
        print(f"✓ Copied PDF to {pdf_output}")
    else:
        print(f"⚠ Warning: PDF not found at {generated_pdf}")

if __name__ == "__main__":
    create_cv_html()
