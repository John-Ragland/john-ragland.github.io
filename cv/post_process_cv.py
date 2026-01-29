"""
Post-process the rendercv generated HTML to match the website's style.
This script:
1. Reads the generated cv.html from rendercv
2. Wraps it with the same header/footer as other pages
3. Adds a link to download the PDF
4. Outputs to the parent directory as cv.html
"""

import os
from pathlib import Path

def create_cv_html():
    """Generate the final cv.html with custom header and PDF download link"""
    
    # Paths
    output_dir = Path('rendercv_output')
    generated_html = output_dir / 'John_Ragland_CV.html'
    generated_pdf = output_dir / 'John_Ragland_CV.pdf'
    final_output = Path('../cv.html')
    pdf_output = Path('../John_Ragland_CV.pdf')
    
    # Check if files exist
    if not generated_html.exists():
        raise FileNotFoundError(f"Generated CV HTML not found at {generated_html}")
    
    # Read the generated CV content
    with open(generated_html, 'r', encoding='utf-8') as f:
        cv_content = f.read()
    
    # Extract just the body content (remove html/head/body tags from rendercv output)
    # This is a simple extraction - you may need to adjust based on actual rendercv output
    import re
    body_match = re.search(r'<body[^>]*>(.*)</body>', cv_content, re.DOTALL)
    if body_match:
        cv_body = body_match.group(1)
    else:
        cv_body = cv_content  # Fallback if pattern doesn't match
    
    # Create the full HTML with custom header
    html_template = f"""<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CV - John Ragland</title>
    <meta name="description" content="Curriculum Vitae">
    
    <!-- SimpleCSS -->
    <link rel="stylesheet" href="https://cdn.simplecss.org/simple.min.css">
    
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
        <section>
            <p>
                <a href="John_Ragland_CV.pdf" style="text-decoration: none; color: inherit;" download>[ pdf ]</a>
            </p>
        </section>

        <section>
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
