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
import re

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
    
    return cv_body

def create_cv_html():
    """Generate the final cv.html with SimpleCSS styling"""
    
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
    
    <!-- Custom CV Styles -->
    <style>
        /* CV-specific styling to match PDF layout */
        .cv-section {{
            margin-top: 2rem;
        }}
        
        .cv-section h1 {{
            color: rgb(0, 79, 144);
            border-bottom: 2px solid rgb(0, 79, 144);
            padding-bottom: 0.3rem;
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }}
        
        .cv-section h2 {{
            font-size: 1.1rem;
            margin-top: 1.2rem;
            margin-bottom: 0.5rem;
            font-weight: 600;
        }}
        
        .cv-section ul {{
            margin-left: 1.5rem;
            margin-bottom: 1rem;
            line-height: 1.6;
        }}
        
        .cv-section a {{
            color: rgb(0, 79, 144);
            text-decoration: none;
        }}
        
        .cv-section a:hover {{
            text-decoration: underline;
        }}
        
        /* Better spacing for lists */
        .c
        
        /* Icon spacing */
        .cv-section i {{
            margin-right: 0.5em;
            color: rgb(0, 79, 144);
            width: 1.2em;
            text-align: center;
        }}v-section li {{
            margin-bottom: 0.3rem;
        }}
        
        /* Contact info at top */
        .cv-section > ul:first-of-type {{
            list-style: none;
            margin-left: 0;
            padding-left: 0;
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
        <section>
            <p>
                <a href="John_Ragland_CV.pdf" style="text-decoration: none; color: inherit;" download>[ pdf ]</a>
            </p>
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
