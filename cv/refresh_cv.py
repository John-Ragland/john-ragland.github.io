from pyzotero import zotero
import yaml
import re
import os
from dotenv import load_dotenv, find_dotenv

load_dotenv(find_dotenv())

if __name__ == "__main__":
    # Load credentials from environment variables
    library_id = os.environ.get('ZOTERO_LIBRARY_ID')
    library_type = 'user'
    api_key = os.environ.get('ZOTERO_API_KEY')
    
    if not library_id or not api_key:
        raise ValueError("Please set ZOTERO_LIBRARY_ID and ZOTERO_API_KEY environment variables")
    
    zot = zotero.Zotero(library_id, library_type, api_key)

    publications = os.environ.get('ZOTERO_PUBLICATIONS_COLLECTION', '8QEDMTRG')
    conference_presentations = os.environ.get('ZOTERO_CONFERENCE_COLLECTION', 'ZRKYJLDM')

    zotero_yaml = {}
    zotero_yaml['Peer Reviewed Publications'] = []
    zotero_yaml['Conference Presentations'] = []

    def extract_year_int(date_str):
        """Extract year from various date formats and return as integer"""
        if not date_str:
            return 0
        
        # Try to find a 4-digit year in the string
        year_match = re.search(r'\b(20\d{2})\b', str(date_str))
        if year_match:
            return int(year_match.group(1))
        
        # Fallback: if it starts with a year (YYYY-MM-DD format)
        if '-' in str(date_str):
            try:
                return int(str(date_str).split('-')[0])
            except ValueError:
                pass
        
        # Try to extract any 4-digit number that looks like a year
        try:
            return int(str(date_str)[:4]) if str(date_str)[:4].isdigit() else 0
        except:
            return 0

    items = zot.collection_items(publications)
    publications_list = []  # Temporary list to collect and sort
    
    for item in items:
        if item['data']['itemType'] == 'journalArticle':
            authors = [creator['lastName'] for creator in item['data']['creators'] if creator['creatorType'] == 'author']
            # Bold any appearances of 'Ragland'
            authors = ['**' + author + '**' if author == 'Ragland' else author for author in authors]
            
            # Extract year from date as integer
            date_str = item['data']['date']
            year_int = extract_year_int(date_str)
            
            # Format as bullet items
            title = item['data']['title']
            authors_str = ', '.join(authors)
            doi = item['data'].get('DOI', '')
            doi_link = f"[{doi}](https://doi.org/{doi})" if doi else ""

            publications_list.append({
                'bullet': f"*{title}* {doi_link} - {authors_str} ({year_int})",
                '_sort_year': year_int
            })
            
        elif item['data']['itemType'] == 'preprint':
            authors = [creator['lastName'] for creator in item['data']['creators'] if creator['creatorType'] == 'author']
            # Bold any appearances of 'Ragland'
            authors = ['**' + author + '**' if author == 'Ragland' else author for author in authors]
            
            # Extract year from date as integer
            date_str = item['data']['date']
            year_int = extract_year_int(date_str)
            
            # Format as bullet items (same as journalArticle)
            title = '(in review) ' + item['data']['title']
            authors_str = ', '.join(authors)
            doi = item['data'].get('DOI', '')
            doi_link = f"[{doi}](https://doi.org/{doi})" if doi else ""
            
            publications_list.append({
                'bullet': f"*{title}* {doi_link} - {authors_str} ({year_int})",
                '_sort_year': year_int
            })

    # Sort by year (newest first)
    publications_list.sort(key=lambda x: x['_sort_year'], reverse=True)

    # Remove the temporary sort field and add to final list
    for pub in publications_list:
        year = pub['_sort_year']
        del pub['_sort_year']
        zotero_yaml['Peer Reviewed Publications'].append(pub)

    items = zot.collection_items(conference_presentations)

    for item in items:
        if item['data']['itemType'] == 'conferencePaper':
            authors = [creator['lastName'] for creator in item['data']['creators'] if creator['creatorType'] == 'author']
            # Bold any appearances of 'Ragland'
            authors = ['**' + author + '**' if author == 'Ragland' else author for author in authors]

            # Extract year from date as integer
            date_str = item['data']['date']
            year_int = extract_year_int(date_str)

            conference_entry = {
                'title': item['data']['title'],
                'authors': authors,
                'journal': item['data']['proceedingsTitle'],
                'date': year_int,
            }
            
            # Only add DOI if it exists
            if item['data'].get('DOI'):
                conference_entry['doi'] = item['data']['DOI']
                
            zotero_yaml['Conference Presentations'].append(conference_entry)

    # Sort conference presentations by year (newest first)
    zotero_yaml['Conference Presentations'].sort(key=lambda x: x['date'], reverse=True)

    # Update John_Ragland_CV.yaml with zotero publications
    with open('John_Ragland_CV_base.yaml', 'r') as f:
        cv_data = yaml.safe_load(f)

    # Update the publications sections within cv.sections
    cv_data['cv']['sections']['Peer Reviewed Publications'] = zotero_yaml['Peer Reviewed Publications']
    cv_data['cv']['sections']['Conference Presentations'] = zotero_yaml['Conference Presentations']

    # Write the updated CV data back to the file with cleaner formatting
    with open('John_Ragland_CV.yaml', 'w') as f:
        yaml.dump(cv_data, f, sort_keys=False, default_flow_style=False, allow_unicode=True)

    # Reorder YAML sections according to specified heading order
    def reorder_cv_sections(yaml_file, desired_order):
        """
        Reorder CV sections according to the desired order list
        
        Args:
            yaml_file (str): Path to the YAML file
            desired_order (list): List of section names in desired order
        """
        # Read the current CV data
        with open(yaml_file, 'r') as f:
            cv_data = yaml.safe_load(f)
        
        # Get current sections
        current_sections = cv_data['cv']['sections']
        
        # Create new ordered sections dictionary
        ordered_sections = {}
        
        # Add sections in desired order
        for section_name in desired_order:
            if section_name in current_sections:
                ordered_sections[section_name] = current_sections[section_name]
        
        # Add any remaining sections not in the desired order (at the end)
        for section_name, section_data in current_sections.items():
            if section_name not in ordered_sections:
                ordered_sections[section_name] = section_data
        
        # Update the CV data with reordered sections
        cv_data['cv']['sections'] = ordered_sections
        
        # Write back to file
        with open(yaml_file, 'w') as f:
            yaml.dump(cv_data, f, sort_keys=False, default_flow_style=False, allow_unicode=True)
        
        print(f"Reordered sections in {yaml_file}")
        print("New section order:")
        for i, section in enumerate(ordered_sections.keys(), 1):
            print(f"{i}. {section}")

    # Define your desired section order
    desired_section_order = [
        'education',
        'experience',
        'Peer Reviewed Publications',
        'Invited Talks',
        'awards',
        'Conference Presentations',
        'Media Coverage',
        'Cruise Experience',
        'Open Source Software Contributions'
    ]

    # Reorder the sections
    reorder_cv_sections('John_Ragland_CV.yaml', desired_section_order)

    # render cv
    os.system('rendercv render "John_Ragland_CV.yaml"')
    
    # Post-process the HTML to add custom header and PDF link
    print("\nPost-processing CV HTML...")
    os.system('python post_process_cv.py')