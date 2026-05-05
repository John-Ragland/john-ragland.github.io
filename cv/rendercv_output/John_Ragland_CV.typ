// Import the rendercv function and all the refactored components
#import "@preview/rendercv:0.3.0": *

// Apply the rendercv template with custom configuration
#show: rendercv.with(
  name: "John Ragland",
  title: "John Ragland - CV",
  footer: context { [#emph[John Ragland -- #str(here().page())\/#str(counter(page).final().first())]] },
  top-note: [ #emph[Last updated in May 2026] ],
  locale-catalog-language: "en",
  text-direction: ltr,
  page-size: "us-letter",
  page-top-margin: 2cm,
  page-bottom-margin: 2cm,
  page-left-margin: 2cm,
  page-right-margin: 2cm,
  page-show-footer: true,
  page-show-top-note: true,
  colors-body: rgb(0, 0, 0),
  colors-name: rgb(0, 79, 144),
  colors-headline: rgb(0, 79, 144),
  colors-connections: rgb(0, 79, 144),
  colors-section-titles: rgb(0, 79, 144),
  colors-links: rgb(0, 79, 144),
  colors-footer: rgb(128, 128, 128),
  colors-top-note: rgb(128, 128, 128),
  typography-line-spacing: 0.6em,
  typography-alignment: "justified",
  typography-date-and-location-column-alignment: right,
  typography-font-family-body: "Source Sans 3",
  typography-font-family-name: "Source Sans 3",
  typography-font-family-headline: "Source Sans 3",
  typography-font-family-connections: "Source Sans 3",
  typography-font-family-section-titles: "Source Sans 3",
  typography-font-size-body: 10pt,
  typography-font-size-name: 30pt,
  typography-font-size-headline: 10pt,
  typography-font-size-connections: 10pt,
  typography-font-size-section-titles: 1.4em,
  typography-small-caps-name: false,
  typography-small-caps-headline: false,
  typography-small-caps-connections: false,
  typography-small-caps-section-titles: false,
  typography-bold-name: true,
  typography-bold-headline: false,
  typography-bold-connections: false,
  typography-bold-section-titles: true,
  links-underline: false,
  links-show-external-link-icon: true,
  header-alignment: center,
  header-photo-width: 3.5cm,
  header-space-below-name: 0.7cm,
  header-space-below-headline: 0.7cm,
  header-space-below-connections: 0.7cm,
  header-connections-hyperlink: true,
  header-connections-show-icons: true,
  header-connections-display-urls-instead-of-usernames: false,
  header-connections-separator: "",
  header-connections-space-between-connections: 0.5cm,
  section-titles-type: "with_partial_line",
  section-titles-line-thickness: 0.5pt,
  section-titles-space-above: 0.5cm,
  section-titles-space-below: 0.3cm,
  sections-allow-page-break: true,
  sections-space-between-text-based-entries: 0.3em,
  sections-space-between-regular-entries: 1.2em,
  entries-date-and-location-width: 4.15cm,
  entries-side-space: 0.2cm,
  entries-space-between-columns: 0.1cm,
  entries-allow-page-break: false,
  entries-short-second-row: false,
  entries-degree-width: 1cm,
  entries-summary-space-left: 0cm,
  entries-summary-space-above: 0cm,
  entries-highlights-bullet:  "•" ,
  entries-highlights-nested-bullet:  "•" ,
  entries-highlights-space-left: 0.15cm,
  entries-highlights-space-above: 0cm,
  entries-highlights-space-between-items: 0cm,
  entries-highlights-space-between-bullet-and-text: 0.5em,
  date: datetime(
    year: 2026,
    month: 5,
    day: 5,
  ),
)


= John Ragland

#connections(
  [#connection-with-icon("location-dot")[Falmouth, MA]],
  [#link("mailto:john.ragland@whoi.edu", icon: false, if-underline: false, if-color: false)[#connection-with-icon("envelope")[john.ragland\@whoi.edu]]],
  [#link("https://linkedin.com/in/john-ragland", icon: false, if-underline: false, if-color: false)[#connection-with-icon("linkedin")[john-ragland]]],
  [#link("https://github.com/john-ragland", icon: false, if-underline: false, if-color: false)[#connection-with-icon("github")[john-ragland]]],
)


== Education

#education-entry(
  [
    #strong[Auburn University], Electrical Engineering

  ],
  [
    2019

  ],
  degree-column: [
    #strong[BS]
  ],
  main-column-second-row: [
    - Graduated #strong[Summa Cum Laude]

  ],
)

#education-entry(
  [
    #strong[Auburn University], Electrical Engineering

  ],
  [
    2020

  ],
  degree-column: [
    #strong[MS]
  ],
  main-column-second-row: [
    - #strong[Thesis]: Digital Simulation and Recreation of a Vacuum Tube Guitar Amp #link("https://etd.auburn.edu//handle/10415/7112")[url]

    - #strong[Advisor]: Thaddeus Roppel

    - #strong[Emphasis] Digital Signal Processing, Real-time Audio Processing, Physical Modeling

  ],
)

#education-entry(
  [
    #strong[University of Washington], Electrical Engineering

  ],
  [
    2024

  ],
  degree-column: [
    #strong[PhD]
  ],
  main-column-second-row: [
    - #strong[Thesis]: Using coherent ambient sound to probe the ocean #link("https://hdl.handle.net/1773/51959")[url]

    - #strong[Advisor]: Shima Abadi

    - #strong[Emphasis]: Acoustic Oceanography: Ambient noise interferometry and ocean acoustic tomography

  ],
)

== Experience

#regular-entry(
  [
    #strong[Woods Hole Oceanographic Institution], Postdoctoral Fellow

  ],
  [
    Woods Hole, MA

    2025 - present

  ],
  main-column-second-row: [
  ],
)

#regular-entry(
  [
    #strong[University of Washington], Postdoctoral Scholar

  ],
  [
    Seattle, WA

    2024 - 2025

  ],
  main-column-second-row: [
  ],
)

#regular-entry(
  [
    #strong[University of Washington], Graduate researcher

  ],
  [
    Seattle, WA

    2020 - 2024

  ],
  main-column-second-row: [
  ],
)

#regular-entry(
  [
    #strong[Applied Research in acoustics], Graduate summer researcher

  ],
  [
    Seattle, WA

    2022

  ],
  main-column-second-row: [
  ],
)

== Peer Reviewed Publications

- #emph[Simultaneous ocean acoustic inversion and source localization for transmission across the Gulf Stream]  - (in prep) Ragland, Colosi, Dzieciuch (2026)

- #emph[Long range, low frequency source localization across the Gulf Stream front using multiple bottom\/surface bounce paths observed on a large aperture vertical array]  - (in prep) Hoekstra, Colosi, #strong[Ragland], Bonnel, Park, Dzieciuch, Alford, Bellerjeau, Voet (2026)

- #emph[Analysis of acoustic fluctuations for 150-km, low frequency transmissions across the Gulf Stream in the vicinity of the New England Seamount chain]  - (in prep) Ragland, Colosi, Hoekstra, Dzieciuch, Alford, Bellerjeau, Gunnar (2026)

- #emph[How Do Tides Affect Underwater Acoustic Propagation: A collaborative approach to improve internal wave modelling at basin to global scales] #link("https://doi.org/10.5670/oceanog.2025.308")[10.5670\/oceanog.2025.308] - Schönau, Hiron, #strong[Ragland], Raja, Skitka, Solano, Xu, Arbic, Buijsman, Chassignet, Coelho, Helber, Shriver, Summers, Verlinden, Wallcraft (2025)

- #emph[Characterizing wind-dependent low-frequency ambient sound with ocean observatories initiative hydrophones] #link("https://doi.org/10.1121/10.0039811")[10.1121\/10.0039811] - #strong[Ragland], Abadi (2025)

- #emph[Receptions of Kauai Beacon transmissions by ocean observatories initiative hydrophones] #link("https://doi.org/10.1121/10.0038971")[10.1121\/10.0038971] - #strong[Ragland], Abadi, Durofchalk, Dall'Osto, Gemba (2025)

- #emph[Using Ocean Ambient Sound to Measure Local Integrated Deep Ocean Temperature] #link("https://doi.org/10.1029/2024GL108943")[10.1029\/2024GL108943] - #strong[Ragland], Abadi, Sabra (2024)

- #emph[Exploring surface source contributions to ocean ambient noise interferometry with airgun shots] #link("https://doi.org/10.1121/10.0015231")[10.1121\/10.0015231] - #strong[Ragland], Abadi (2022)

- #emph[An overview of ambient sound using Ocean Observatories Initiative hydrophones] #link("https://doi.org/10.1121/10.0009836")[10.1121\/10.0009836] - #strong[Ragland], Schwock, Munson, Abadi (2022)

- #emph[Long-term noise interferometry analysis in the northeast Pacific Ocean] #link("https://doi.org/10.1121/10.0009232")[10.1121\/10.0009232] - #strong[Ragland], Abadi, Sabra (2022)

== Invited Talks

- MG&G Group, University of Washington, Seattle WA (2024)

- Navy Research Laboratory, Ocean Sciences Division, Stennis MS (2023)

- MG&G Group, University of Washington, Seattle WA (2023)

- Applied Research Laboratory - UW, Seattle WA (2022)

== Awards

- #strong[ONR Postdoctoral fellowship in Acoustics] (2025) - Office of Naval Research: Fellowship awarded to exceptional early-career researchers who wish to continue research in ocean acoustics or the related disciplines of undersea signal processing, marine structural acoustics and transducer materials science

- #strong[eScience postdoctoral fellowship] (Sept 2024) - University of Washington, eScience Institute: Fellowship awarded to interdisciplinary researchers who are actively involved in developing and\/or utilizing advanced data science tools and techniques in their research at the UW

- #strong[The Daoma and Murray Strasberg Memorial Scholarship] (May 2023) - Acoustical Society of America: Awarded to exceptional graduate students in ocean acoustics with research relevant to naval applications to ocean acoustics

- #strong[ASA best student paper] (Dec 2022) - Acoustical Society of America: Second place at the ASA Nashville in underwater acoustics technical committee

== Conference Presentations

- #emph[Comparing Kauai Beacon receptions to simulated acoustic propagation] (#link("https://doi.org/10.1121/10.0037361")[10.1121\/10.0037361]) - #strong[Ragland], Durofchalk, Dall'Osto, Abadi, Gemba (2025) - 188th Meeting of the Acoustical Society of America

- #emph[Analysis of very low frequency wind driven noise at Ocean Observatories Initiative hydrophones] (#link("https://doi.org/10.1121/10.0037493")[10.1121\/10.0037493]) - #strong[Ragland], Phan, Abadi (2025) - 188th Meeting of the Acoustical Society of America

- #emph[Kauai Beacon receptions and analysis with open-access hydrophones in the North Pacific Ocean] (#link("https://doi.org/10.1121/10.0026938")[10.1121\/10.0026938]) - #strong[Ragland], Durofchalk, Gemba, Dall'Osto, Abadi (2024) - 186th Meeting of the Acoustical Society of America

- #emph[Towards acoustic observations of ocean basin temperatures using the Kauai beacon and Ocean Observatories Initiative Hydrophones] - #strong[Ragland], Durofchalk, Abadi, Dall'Osto, Gemba (2024) - Ocean Sciences Meeting 2024

- #emph[Detecting the Kauai source beacon with ocean observatories innitiative hydrophones] (#link("https://doi.org/10.1121/10.0023175")[10.1121\/10.0023175]) - #strong[Ragland], Durofchalk, Gemba, Abadi (2023) - 185th Meeting of the Acoustical Society of America

- #emph[Using ocean ambient sound to sense arrival time fluctuations due to temperature] (#link("https://doi.org/10.1121/10.0023334")[10.1121\/10.0023334]) - #strong[Ragland], Abadi (2023) - 185th Meeting of the Acoustical Society of America

- #emph[Using distributed acoustic sensing for ocean ambient sound analysis] (#link("https://doi.org/10.1121/10.0018176")[10.1121\/10.0018176]) - #strong[Ragland], Douglass, Abadi (2023) - 184th Meeting of the Acoustical Society of America

- #emph[Towards estimating water column properties using ambient noise interferometry in the deep ocean] - #strong[Ragland], Abadi (2023) - Underwater Acoustics Conference and Exposition

- #emph[Overview of distributed acoustic sensing technology and recently acquired data sets] (#link("https://doi.org/10.1121/10.0018174")[10.1121\/10.0018174]) - Douglass, #strong[Ragland], Abadi (2023) - 184th Meeting of the Acoustical Society of America

- #emph[Comparing distributed acoustic sensing data with hydrophone recordings] (#link("https://doi.org/10.1121/10.0018175")[10.1121\/10.0018175]) - Abadi, Douglass, #strong[Ragland] (2023) - 184th Meeting of the Acoustical Society of America

- #emph[Long-term ambient noise interferometry in the NE Pacific deep ocean] - #strong[Ragland], Abadi (2022) - Ocean Sciences Meeting 2022

- #emph[Overview of ambient noise research and outreach with OOI hydrophones] - #strong[Ragland], Schwock, Liu, Abadi (2022) - AGU Fall Meeting 2022

- #emph[Overview of ocean ambient noise interferometry – Theory and simulation] (#link("https://doi.org/10.1121/10.0016311")[10.1121\/10.0016311]) - #strong[Ragland], Abadi (2022) - 183th Meeting of the Acoustical Society of America

- #emph[Exploring surface source distributions for ocean ambient noise interferometry with airgun shots] (#link("https://doi.org/10.1121/10.0011063")[10.1121\/10.0011063]) - #strong[Ragland], Abadi (2022) - 182th Meeting of the Acoustical Society of America

- #emph[OOIPy: A Python toolbox for accessing and analyzing sata from the Ocean Observatories Initiative] (#link("https://doi.org/10.1121/10.0007845")[10.1121\/10.0007845]) - Schwock, #strong[Ragland], Abadi (2021) - 180th Meeting of the Acoustical Society of America

- #emph[An overview of ambient sound using OOI hydrophone network] (#link("https://doi.org/10.1121/10.0007594")[10.1121\/10.0007594]) - #strong[Ragland], Schwock, Munson, Abadi (2021) - 180th Meeting of the Acoustical Society of America

- #emph[Long-term noise interferometry analysis in the northeast Pacific Ocean] (#link("https://doi.org/10.1121/10.0004609")[10.1121\/10.0004609]) - #strong[Ragland], Abadi (2021) - 179th Meeting of the Acoustical Society of America

- #emph[Estimating ocean variables using ambient noise interferometry] (#link("https://doi.org/10.1121/10.0007697")[10.1121\/10.0007697]) - #strong[Ragland], Abadi (2021) - 180th Meeting of the Acoustical Society of America

- #emph[Ship detection from passive underwater acoustic recordings using machine learning] (#link("https://doi.org/10.1121/10.0007848")[10.1121\/10.0007848]) - Alvaro, Schwock, #strong[Ragland], Abadi (2021) - 180th Meeting of the Acoustical Society of America

== Media Coverage

- #link("https://web.archive.org/web/20230731211310/https://www.ece.uw.edu/spotlight/listening-to-the-ocean-climate-change/")[Listening to the ocean to measure the impact of climate change]

- OOI Science Highlights: #link("https://web.archive.org/web/20230731211602/https://oceanobservatories.org/2022/11/an-overview-of-ambient-sound-using-ooi-hydrophones/")[An Overview of Ambient Sound Using OOI Hydrophones]

== Cruise Experience

- RC0090, 2022, 2 days - deployed mooring with two hydrophones that was recovered one week later. The goal of this deployment was to acoustically measure methane seeps in the Puget Sound.

- RR2411, 2024, 21 days - joint operation to measure deep scattering layer, and low-frequency acoustic propagation around seamounts in the North Atlantic.

- AR90, 2025, 21 days - recovered NESMA acoustic moorings in North Atlantic

== Open Source Software Contributions

- #strong[OOIPy] - python package for accessing OOI hydrophone data #link("https://github.com/Ocean-Data-Lab/ooipy")[GitHub]#link("https://pypi.org/project/ooipy/")[PyPI]#link("https://doi.org/10.5281/zenodo.4276861")[DOI]

- #strong[xrsignal] - python package that ports functionality from scipy.signal to xarray and is compatible with distributed computing #link("https://github.com/John-Ragland/xrsignal")[GitHub] #link("https://pypi.org/project/xrsignal/")[PypI]

- #strong[pygenray] - native python ray tracing code #link("https://github.com/John-Ragland/pygenray")[GitHub] #link("https://pypi.org/project/pygenray/")[PyPI] #link("https://doi.org/10.5281/zenodo.15783848")[DOI]
