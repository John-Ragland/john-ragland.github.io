
#import "@preview/fontawesome:0.5.0": fa-icon

#let name = "John Ragland"
#let locale-catalog-page-numbering-style = context { "John Ragland - Page " + str(here().page()) + " of " + str(counter(page).final().first()) + "" }
#let locale-catalog-last-updated-date-style = "Last updated in Jan 2026"
#let locale-catalog-language = "en"
#let design-page-size = "us-letter"
#let design-colors-text = rgb(0, 0, 0)
#let design-colors-section-titles = rgb(0, 79, 144)
#let design-colors-last-updated-date-and-page-numbering = rgb(128, 128, 128)
#let design-colors-name = rgb(0, 79, 144)
#let design-colors-connections = rgb(0, 79, 144)
#let design-colors-links = rgb(0, 79, 144)
#let design-section-titles-font-family = "Source Sans 3"
#let design-section-titles-bold = true
#let design-section-titles-line-thickness = 0.5pt
#let design-section-titles-font-size = 1.4em
#let design-section-titles-type = "with-partial-line"
#let design-section-titles-vertical-space-above = 0.5cm
#let design-section-titles-vertical-space-below = 0.3cm
#let design-section-titles-small-caps = false
#let design-links-use-external-link-icon = true
#let design-text-font-size = 10pt
#let design-text-leading = 0.6em
#let design-text-font-family = "Source Sans 3"
#let design-text-alignment = "justified"
#let design-text-date-and-location-column-alignment = right
#let design-header-photo-width = 3.5cm
#let design-header-use-icons-for-connections = true
#let design-header-name-font-family = "Source Sans 3"
#let design-header-name-font-size = 30pt
#let design-header-name-bold = true
#let design-header-small-caps-for-name = false
#let design-header-connections-font-family = "Source Sans 3"
#let design-header-vertical-space-between-name-and-connections = 0.7cm
#let design-header-vertical-space-between-connections-and-first-section = 0.7cm
#let design-header-use-icons-for-connections = true
#let design-header-horizontal-space-between-connections = 0.5cm
#let design-header-separator-between-connections = ""
#let design-header-alignment = center
#let design-highlights-summary-left-margin = 0cm
#let design-highlights-bullet = "•"
#let design-highlights-nested-bullet = "-"
#let design-highlights-top-margin = 0.25cm
#let design-highlights-left-margin = 0.4cm
#let design-highlights-vertical-space-between-highlights = 0.25cm
#let design-highlights-horizontal-space-between-bullet-and-highlights = 0.5em
#let design-entries-vertical-space-between-entries = 1.2em
#let design-entries-date-and-location-width = 4.15cm
#let design-entries-allow-page-break-in-entries = true
#let design-entries-horizontal-space-between-columns = 0.1cm
#let design-entries-left-and-right-margin = 0.2cm
#let design-page-top-margin = 2cm
#let design-page-bottom-margin = 2cm
#let design-page-left-margin = 2cm
#let design-page-right-margin = 2cm
#let design-page-show-last-updated-date = true
#let design-page-show-page-numbering = true
#let design-links-underline = false
#let design-entry-types-education-entry-degree-column-width = 1cm
#let date = datetime.today()

// Metadata:
#set document(author: name, title: name + "'s CV", date: date)

// Page settings:
#set page(
  margin: (
    top: design-page-top-margin,
    bottom: design-page-bottom-margin,
    left: design-page-left-margin,
    right: design-page-right-margin,
  ),
  paper: design-page-size,
  footer: if design-page-show-page-numbering {
    text(
      fill: design-colors-last-updated-date-and-page-numbering,
      align(center, [_#locale-catalog-page-numbering-style _]),
      size: 0.9em,
    )
  } else {
    none
  },
  footer-descent: 0% - 0.3em + design-page-bottom-margin / 2,
)
// Text settings:
#let justify
#let hyphenate
#if design-text-alignment == "justified" {
  justify = true
  hyphenate = true
} else if design-text-alignment == "left" {
  justify = false
  hyphenate = false
} else if design-text-alignment == "justified-with-no-hyphenation" {
  justify = true
  hyphenate = false
}
#set text(
  font: design-text-font-family,
  size: design-text-font-size,
  lang: locale-catalog-language,
  hyphenate: hyphenate,
  fill: design-colors-text,
  // Disable ligatures for better ATS compatibility:
  ligatures: true,
)
#set par(
  spacing: 0pt,
  leading: design-text-leading,
  justify: justify,
)
#set enum(
  spacing: design-entries-vertical-space-between-entries,
)

// Highlights settings:
#let highlights(..content) = {
  list(
    ..content,
    marker: design-highlights-bullet,
    spacing: design-highlights-vertical-space-between-highlights,
    indent: design-highlights-left-margin,
    body-indent: design-highlights-horizontal-space-between-bullet-and-highlights,
  )
}
#show list: set list(
  marker: design-highlights-nested-bullet,
  spacing: design-highlights-vertical-space-between-highlights,
  indent: 0pt,
  body-indent: design-highlights-horizontal-space-between-bullet-and-highlights,
)

// Entry utilities:
#let bullet-entry(..content) = {
  list(
    ..content,
    marker: design-highlights-bullet,
    spacing: 0pt,
    indent: 0pt,
    body-indent: design-highlights-horizontal-space-between-bullet-and-highlights,
  )
}
#let three-col(
  left-column-width: 1fr,
  middle-column-width: 1fr,
  right-column-width: design-entries-date-and-location-width,
  left-content: "",
  middle-content: "",
  right-content: "",
  alignments: (auto, auto, auto),
) = [
  #block(
    grid(
      columns: (left-column-width, middle-column-width, right-column-width),
      column-gutter: design-entries-horizontal-space-between-columns,
      align: alignments,
      ([#set par(spacing: design-text-leading); #left-content]),
      ([#set par(spacing: design-text-leading); #middle-content]),
      ([#set par(spacing: design-text-leading); #right-content]),
    ),
    breakable: true,
    width: 100%,
  )
]

#let two-col(
  left-column-width: 1fr,
  right-column-width: design-entries-date-and-location-width,
  left-content: "",
  right-content: "",
  alignments: (auto, auto),
  column-gutter: design-entries-horizontal-space-between-columns,
) = [
  #block(
    grid(
      columns: (left-column-width, right-column-width),
      column-gutter: column-gutter,
      align: alignments,
      ([#set par(spacing: design-text-leading); #left-content]),
      ([#set par(spacing: design-text-leading); #right-content]),
    ),
    breakable: true,
    width: 100%,
  )
]

// Main heading settings:
#let header-font-weight
#if design-header-name-bold {
  header-font-weight = 700
} else {
  header-font-weight = 400
}
#show heading.where(level: 1): it => [
  #set par(spacing: 0pt)
  #set align(design-header-alignment)
  #set text(
    font: design-header-name-font-family,
    weight: header-font-weight,
    size: design-header-name-font-size,
    fill: design-colors-name,
  )
  #if design-header-small-caps-for-name [
    #smallcaps(it.body)
  ] else [
    #it.body
  ]
  // Vertical space after the name
  #v(design-header-vertical-space-between-name-and-connections)
]

#let section-title-font-weight
#if design-section-titles-bold {
  section-title-font-weight = 700
} else {
  section-title-font-weight = 400
}

#show heading.where(level: 2): it => [
  #set align(left)
  #set text(size: (1em / 1.2)) // reset
  #set text(
    font: design-section-titles-font-family,
    size: (design-section-titles-font-size),
    weight: section-title-font-weight,
    fill: design-colors-section-titles,
  )
  #let section-title = (
    if design-section-titles-small-caps [
      #smallcaps(it.body)
    ] else [
      #it.body
    ]
  )
  // Vertical space above the section title
  #v(design-section-titles-vertical-space-above, weak: true)
  #block(
    breakable: false,
    width: 100%,
    [
      #if design-section-titles-type == "moderncv" [
        #two-col(
          alignments: (right, left),
          left-column-width: design-entries-date-and-location-width,
          right-column-width: 1fr,
          left-content: [
            #align(horizon, box(width: 1fr, height: design-section-titles-line-thickness, fill: design-colors-section-titles))
          ],
          right-content: [
            #section-title
          ]
        )

      ] else [
        #box(
          [
            #section-title
            #if design-section-titles-type == "with-partial-line" [
              #box(width: 1fr, height: design-section-titles-line-thickness, fill: design-colors-section-titles)
            ] else if design-section-titles-type == "with-full-line" [

              #v(design-text-font-size * 0.4)
              #box(width: 1fr, height: design-section-titles-line-thickness, fill: design-colors-section-titles)
            ]
          ]
        )
      ]
     ] + v(1em),
  )
  #v(-1em)
  // Vertical space after the section title
  #v(design-section-titles-vertical-space-below - 0.5em)
]

// Links:
#let original-link = link
#let link(url, body) = {
  body = [#if design-links-underline [#underline(body)] else [#body]]
  body = [#if design-links-use-external-link-icon [#body#h(design-text-font-size/4)#box(
        fa-icon("external-link", size: 0.7em),
        baseline: -10%,
      )] else [#body]]
  body = [#set text(fill: design-colors-links);#body]
  original-link(url, body)
}

// Last updated date text:
#if design-page-show-last-updated-date {
  let dx
  if design-section-titles-type == "moderncv" {
    dx = 0cm
  } else {
    dx = -design-entries-left-and-right-margin
  }
  place(
    top + right,
    dy: -design-page-top-margin / 2,
    dx: dx,
    text(
      [_#locale-catalog-last-updated-date-style _],
      fill: design-colors-last-updated-date-and-page-numbering,
      size: 0.9em,
    ),
  )
}

#let connections(connections-list) = context {
  set text(fill: design-colors-connections, font: design-header-connections-font-family)
  set par(leading: design-text-leading*1.7, justify: false)
  let list-of-connections = ()
  let separator = (
    h(design-header-horizontal-space-between-connections / 2, weak: true)
      + design-header-separator-between-connections
      + h(design-header-horizontal-space-between-connections / 2, weak: true)
  )
  let starting-index = 0
  while (starting-index < connections-list.len()) {
    let left-sum-right-margin
    if type(page.margin) == "dictionary" {
      left-sum-right-margin = page.margin.left + page.margin.right
    } else {
      left-sum-right-margin = page.margin * 4
    }

    let ending-index = starting-index + 1
    while (
      measure(connections-list.slice(starting-index, ending-index).join(separator)).width
        < page.width - left-sum-right-margin
    ) {
      ending-index = ending-index + 1
      if ending-index > connections-list.len() {
        break
      }
    }
    if ending-index > connections-list.len() {
      ending-index = connections-list.len()
    }
    list-of-connections.push(connections-list.slice(starting-index, ending-index).join(separator))
    starting-index = ending-index
  }
  align(list-of-connections.join(linebreak()), design-header-alignment)
  v(design-header-vertical-space-between-connections-and-first-section - design-section-titles-vertical-space-above)
}

#let three-col-entry(
  left-column-width: 1fr,
  right-column-width: design-entries-date-and-location-width,
  left-content: "",
  middle-content: "",
  right-content: "",
  alignments: (left, auto, right),
) = (
  if design-section-titles-type == "moderncv" [
    #three-col(
      left-column-width: right-column-width,
      middle-column-width: left-column-width,
      right-column-width: 1fr,
      left-content: right-content,
      middle-content: [
        #block(
          [
            #left-content
          ],
          inset: (
            left: design-entries-left-and-right-margin,
            right: design-entries-left-and-right-margin,
          ),
          breakable: design-entries-allow-page-break-in-entries,
          width: 100%,
        )
      ],
      right-content: middle-content,
      alignments: (design-text-date-and-location-column-alignment, left, auto),
    )
  ] else [
    #block(
      [
        #three-col(
          left-column-width: left-column-width,
          right-column-width: right-column-width,
          left-content: left-content,
          middle-content: middle-content,
          right-content: right-content,
          alignments: alignments,
        )
      ],
      inset: (
        left: design-entries-left-and-right-margin,
        right: design-entries-left-and-right-margin,
      ),
      breakable: design-entries-allow-page-break-in-entries,
      width: 100%,
    )
  ]
)

#let two-col-entry(
  left-column-width: 1fr,
  right-column-width: design-entries-date-and-location-width,
  left-content: "",
  right-content: "",
  alignments: (auto, design-text-date-and-location-column-alignment),
  column-gutter: design-entries-horizontal-space-between-columns,
) = (
  if design-section-titles-type == "moderncv" [
    #two-col(
      left-column-width: right-column-width,
      right-column-width: left-column-width,
      left-content: right-content,
      right-content: [
        #block(
          [
            #left-content
          ],
          inset: (
            left: design-entries-left-and-right-margin,
            right: design-entries-left-and-right-margin,
          ),
          breakable: design-entries-allow-page-break-in-entries,
          width: 100%,
        )
      ],
      alignments: (design-text-date-and-location-column-alignment, auto),
    )
  ] else [
    #block(
      [
        #two-col(
          left-column-width: left-column-width,
          right-column-width: right-column-width,
          left-content: left-content,
          right-content: right-content,
          alignments: alignments,
        )
      ],
      inset: (
        left: design-entries-left-and-right-margin,
        right: design-entries-left-and-right-margin,
      ),
      breakable: design-entries-allow-page-break-in-entries,
      width: 100%,
    )
  ]
)

#let one-col-entry(content: "") = [
  #let left-space = design-entries-left-and-right-margin
  #if design-section-titles-type == "moderncv" [
    #(left-space = left-space + design-entries-date-and-location-width + design-entries-horizontal-space-between-columns)
  ]
  #block(
    [#set par(spacing: design-text-leading); #content],
    breakable: design-entries-allow-page-break-in-entries,
    inset: (
      left: left-space,
      right: design-entries-left-and-right-margin,
    ),
    width: 100%,
  )
]

= John Ragland

// Print connections:
#let connections-list = (
  [#fa-icon("location-dot", size: 0.9em) #h(0.05cm)Falmouth, MA],
  [#box(original-link("mailto:john.ragland@whoi.edu")[#fa-icon("envelope", size: 0.9em) #h(0.05cm)john.ragland\@whoi.edu])],
  [#box(original-link("https://linkedin.com/in/john-ragland")[#fa-icon("linkedin", size: 0.9em) #h(0.05cm)john-ragland])],
  [#box(original-link("https://github.com/john-ragland")[#fa-icon("github", size: 0.9em) #h(0.05cm)john-ragland])],
)
#connections(connections-list)



== Education


// YES DATE, YES DEGREE
#three-col-entry(
  left-column-width: 1cm,
  left-content: [#strong[BS]],
  middle-content: [
    #strong[Auburn University], Electrical Engineering
  ],
  right-content: [
    2019
  ],
)
#block(
  [
    #set par(spacing: 0pt)
    #v(design-highlights-top-margin);#highlights([Graduated #strong[Summa Cum Laude]],)
  ],
  inset: (
    left: design-entry-types-education-entry-degree-column-width + design-entries-horizontal-space-between-columns + design-entries-left-and-right-margin,
    right: design-entries-left-and-right-margin,
  ),
)

#v(design-entries-vertical-space-between-entries)
// YES DATE, YES DEGREE
#three-col-entry(
  left-column-width: 1cm,
  left-content: [#strong[MS]],
  middle-content: [
    #strong[Auburn University], Electrical Engineering
  ],
  right-content: [
    2020
  ],
)
#block(
  [
    #set par(spacing: 0pt)
    #v(design-highlights-top-margin);#highlights([#strong[Thesis]: Digital Simulation and Recreation of a Vacuum Tube Guitar Amp #link("https://etd.auburn.edu//handle/10415/7112")[url]],[#strong[Advisor]: Thaddeus Roppel],[#strong[Emphasis] Digital Signal Processing, Real-time Audio Processing, Physical Modeling],)
  ],
  inset: (
    left: design-entry-types-education-entry-degree-column-width + design-entries-horizontal-space-between-columns + design-entries-left-and-right-margin,
    right: design-entries-left-and-right-margin,
  ),
)

#v(design-entries-vertical-space-between-entries)
// YES DATE, YES DEGREE
#three-col-entry(
  left-column-width: 1cm,
  left-content: [#strong[PhD]],
  middle-content: [
    #strong[University of Washington], Electrical Engineering
  ],
  right-content: [
    2024
  ],
)
#block(
  [
    #set par(spacing: 0pt)
    #v(design-highlights-top-margin);#highlights([#strong[Thesis]: Using coherent ambient sound to probe the ocean #link("https://hdl.handle.net/1773/51959")[url]],[#strong[Advisor]: Shima Abadi],[#strong[Emphasis]: Acoustic Oceanography: Ambient noise interferometry and ocean acoustic tomography],)
  ],
  inset: (
    left: design-entry-types-education-entry-degree-column-width + design-entries-horizontal-space-between-columns + design-entries-left-and-right-margin,
    right: design-entries-left-and-right-margin,
  ),
)



== Experience


#two-col-entry(
  left-content: [
    #strong[Woods Hole Oceanographic Institution], Postdoctoral Fellow

    
  ],
  right-content: [
    Woods Hole, MA

2025 - present
  ],
)

#v(design-entries-vertical-space-between-entries)
#two-col-entry(
  left-content: [
    #strong[University of Washington], Postdoctoral Scholar

    
  ],
  right-content: [
    Seattle, WA

2024 - 2025
  ],
)

#v(design-entries-vertical-space-between-entries)
#two-col-entry(
  left-content: [
    #strong[University of Washington], Graduate researcher

    
  ],
  right-content: [
    Seattle, WA

2020 - 2024
  ],
)

#v(design-entries-vertical-space-between-entries)
#two-col-entry(
  left-content: [
    #strong[Applied Research in acoustics], Graduate summer researcher

    
  ],
  right-content: [
    Seattle, WA

2022
  ],
)



== Peer Reviewed Publications


#one-col-entry(content: [#bullet-entry[#emph[How Do Tides Affect Underwater Acoustic Propagation: A collaborative approach to improve internal wave modelling at basin to global scales] #link("https://doi.org/10.5670/oceanog.2025.308")[10.5670\/oceanog.2025.308] - Schönau, Hiron, #strong[Ragland], Raja, Skitka, Solano, Xu, Arbic, Buijsman, Chassignet, Coelho, Helber, Shriver, Summers, Verlinden, Wallcraft \(2025\)]])
#v(design-entries-vertical-space-between-entries)
#one-col-entry(content: [#bullet-entry[#emph[Characterizing wind-dependent low-frequency ambient sound with ocean observatories initiative hydrophones] #link("https://doi.org/10.1121/10.0039811")[10.1121\/10.0039811] - #strong[Ragland], Abadi \(2025\)]])
#v(design-entries-vertical-space-between-entries)
#one-col-entry(content: [#bullet-entry[#emph[Receptions of Kauai Beacon transmissions by ocean observatories initiative hydrophones] #link("https://doi.org/10.1121/10.0038971")[10.1121\/10.0038971] - #strong[Ragland], Abadi, Durofchalk, Dall'Osto, Gemba \(2025\)]])
#v(design-entries-vertical-space-between-entries)
#one-col-entry(content: [#bullet-entry[#emph[Using Ocean Ambient Sound to Measure Local Integrated Deep Ocean Temperature] #link("https://doi.org/10.1029/2024GL108943")[10.1029\/2024GL108943] - #strong[Ragland], Abadi, Sabra \(2024\)]])
#v(design-entries-vertical-space-between-entries)
#one-col-entry(content: [#bullet-entry[#emph[Exploring surface source contributions to ocean ambient noise interferometry with airgun shots] #link("https://doi.org/10.1121/10.0015231")[10.1121\/10.0015231] - #strong[Ragland], Abadi \(2022\)]])
#v(design-entries-vertical-space-between-entries)
#one-col-entry(content: [#bullet-entry[#emph[An overview of ambient sound using Ocean Observatories Initiative hydrophones] #link("https://doi.org/10.1121/10.0009836")[10.1121\/10.0009836] - #strong[Ragland], Schwock, Munson, Abadi \(2022\)]])
#v(design-entries-vertical-space-between-entries)
#one-col-entry(content: [#bullet-entry[#emph[Long-term noise interferometry analysis in the northeast Pacific Ocean] #link("https://doi.org/10.1121/10.0009232")[10.1121\/10.0009232] - #strong[Ragland], Abadi, Sabra \(2022\)]])


== Invited Talks


#one-col-entry(content: [#bullet-entry[MG&G Group, University of Washington, Seattle WA \(2024\)]])
#v(design-entries-vertical-space-between-entries)
#one-col-entry(content: [#bullet-entry[Navy Research Laboratory, Ocean Sciences Division, Stennis MS \(2023\)]])
#v(design-entries-vertical-space-between-entries)
#one-col-entry(content: [#bullet-entry[MG&G Group, University of Washington, Seattle WA \(2023\)]])
#v(design-entries-vertical-space-between-entries)
#one-col-entry(content: [#bullet-entry[Applied Research Laboratory - UW, Seattle WA \(2022\)]])


== Awards


#one-col-entry(content: [#bullet-entry[#strong[eScience postdoctoral fellowship] \(Sept 2024\) - University of Washington, eScience Institute: Fellowship awarded to interdisciplinary researchers who are actively involved in developing and\/or utilizing advanced data science tools and techniques in their research at the UW]])
#v(design-entries-vertical-space-between-entries)
#one-col-entry(content: [#bullet-entry[#strong[The Daoma and Murray Strasberg Memorial Scholarship] \(May 2023\) - Acoustical Society of America: Awarded to exceptional graduate students in ocean acoustics with research relevant to naval applications to ocean acoustics]])
#v(design-entries-vertical-space-between-entries)
#one-col-entry(content: [#bullet-entry[#strong[ASA best student paper] \(Dec 2022\) - Acoustical Society of America: Second place at the ASA Nashville in underwater acoustics technical committee]])


== Conference Presentations


#one-col-entry(content: [#bullet-entry[#emph[Comparing Kauai Beacon receptions to simulated acoustic propagation] \(#link("https://doi.org/10.1121/10.0037361")[10.1121\/10.0037361]\) - #strong[Ragland], Durofchalk, Dall'Osto, Abadi, Gemba \(2025\) - 188th Meeting of the Acoustical Society of America]])
#v(design-entries-vertical-space-between-entries)
#one-col-entry(content: [#bullet-entry[#emph[Analysis of very low frequency wind driven noise at Ocean Observatories Initiative hydrophones] \(#link("https://doi.org/10.1121/10.0037493")[10.1121\/10.0037493]\) - #strong[Ragland], Phan, Abadi \(2025\) - 188th Meeting of the Acoustical Society of America]])
#v(design-entries-vertical-space-between-entries)
#one-col-entry(content: [#bullet-entry[#emph[Kauai Beacon receptions and analysis with open-access hydrophones in the North Pacific Ocean] \(#link("https://doi.org/10.1121/10.0026938")[10.1121\/10.0026938]\) - #strong[Ragland], Durofchalk, Gemba, Dall'Osto, Abadi \(2024\) - 186th Meeting of the Acoustical Society of America]])
#v(design-entries-vertical-space-between-entries)
#one-col-entry(content: [#bullet-entry[#emph[Towards acoustic observations of ocean basin temperatures using the Kauai beacon and Ocean Observatories Initiative Hydrophones] - #strong[Ragland], Durofchalk, Abadi, Dall'Osto, Gemba \(2024\) - Ocean Sciences Meeting 2024]])
#v(design-entries-vertical-space-between-entries)
#one-col-entry(content: [#bullet-entry[#emph[Detecting the Kauai source beacon with ocean observatories innitiative hydrophones] \(#link("https://doi.org/10.1121/10.0023175")[10.1121\/10.0023175]\) - #strong[Ragland], Durofchalk, Gemba, Abadi \(2023\) - 185th Meeting of the Acoustical Society of America]])
#v(design-entries-vertical-space-between-entries)
#one-col-entry(content: [#bullet-entry[#emph[Using ocean ambient sound to sense arrival time fluctuations due to temperature] \(#link("https://doi.org/10.1121/10.0023334")[10.1121\/10.0023334]\) - #strong[Ragland], Abadi \(2023\) - 185th Meeting of the Acoustical Society of America]])
#v(design-entries-vertical-space-between-entries)
#one-col-entry(content: [#bullet-entry[#emph[Using distributed acoustic sensing for ocean ambient sound analysis] \(#link("https://doi.org/10.1121/10.0018176")[10.1121\/10.0018176]\) - #strong[Ragland], Douglass, Abadi \(2023\) - 184th Meeting of the Acoustical Society of America]])
#v(design-entries-vertical-space-between-entries)
#one-col-entry(content: [#bullet-entry[#emph[Towards estimating water column properties using ambient noise interferometry in the deep ocean] - #strong[Ragland], Abadi \(2023\) - Underwater Acoustics Conference and Exposition]])
#v(design-entries-vertical-space-between-entries)
#one-col-entry(content: [#bullet-entry[#emph[Overview of distributed acoustic sensing technology and recently acquired data sets] \(#link("https://doi.org/10.1121/10.0018174")[10.1121\/10.0018174]\) - Douglass, #strong[Ragland], Abadi \(2023\) - 184th Meeting of the Acoustical Society of America]])
#v(design-entries-vertical-space-between-entries)
#one-col-entry(content: [#bullet-entry[#emph[Comparing distributed acoustic sensing data with hydrophone recordings] \(#link("https://doi.org/10.1121/10.0018175")[10.1121\/10.0018175]\) - Abadi, Douglass, #strong[Ragland] \(2023\) - 184th Meeting of the Acoustical Society of America]])
#v(design-entries-vertical-space-between-entries)
#one-col-entry(content: [#bullet-entry[#emph[Long-term ambient noise interferometry in the NE Pacific deep ocean] - #strong[Ragland], Abadi \(2022\) - Ocean Sciences Meeting 2022]])
#v(design-entries-vertical-space-between-entries)
#one-col-entry(content: [#bullet-entry[#emph[Overview of ambient noise research and outreach with OOI hydrophones] - #strong[Ragland], Schwock, Liu, Abadi \(2022\) - AGU Fall Meeting 2022]])
#v(design-entries-vertical-space-between-entries)
#one-col-entry(content: [#bullet-entry[#emph[Overview of ocean ambient noise interferometry – Theory and simulation] \(#link("https://doi.org/10.1121/10.0016311")[10.1121\/10.0016311]\) - #strong[Ragland], Abadi \(2022\) - 183th Meeting of the Acoustical Society of America]])
#v(design-entries-vertical-space-between-entries)
#one-col-entry(content: [#bullet-entry[#emph[Exploring surface source distributions for ocean ambient noise interferometry with airgun shots] \(#link("https://doi.org/10.1121/10.0011063")[10.1121\/10.0011063]\) - #strong[Ragland], Abadi \(2022\) - 182th Meeting of the Acoustical Society of America]])
#v(design-entries-vertical-space-between-entries)
#one-col-entry(content: [#bullet-entry[#emph[OOIPy: A Python toolbox for accessing and analyzing sata from the Ocean Observatories Initiative] \(#link("https://doi.org/10.1121/10.0007845")[10.1121\/10.0007845]\) - Schwock, #strong[Ragland], Abadi \(2021\) - 180th Meeting of the Acoustical Society of America]])
#v(design-entries-vertical-space-between-entries)
#one-col-entry(content: [#bullet-entry[#emph[An overview of ambient sound using OOI hydrophone network] \(#link("https://doi.org/10.1121/10.0007594")[10.1121\/10.0007594]\) - #strong[Ragland], Schwock, Munson, Abadi \(2021\) - 180th Meeting of the Acoustical Society of America]])
#v(design-entries-vertical-space-between-entries)
#one-col-entry(content: [#bullet-entry[#emph[Long-term noise interferometry analysis in the northeast Pacific Ocean] \(#link("https://doi.org/10.1121/10.0004609")[10.1121\/10.0004609]\) - #strong[Ragland], Abadi \(2021\) - 179th Meeting of the Acoustical Society of America]])
#v(design-entries-vertical-space-between-entries)
#one-col-entry(content: [#bullet-entry[#emph[Estimating ocean variables using ambient noise interferometry] \(#link("https://doi.org/10.1121/10.0007697")[10.1121\/10.0007697]\) - #strong[Ragland], Abadi \(2021\) - 180th Meeting of the Acoustical Society of America]])
#v(design-entries-vertical-space-between-entries)
#one-col-entry(content: [#bullet-entry[#emph[Ship detection from passive underwater acoustic recordings using machine learning] \(#link("https://doi.org/10.1121/10.0007848")[10.1121\/10.0007848]\) - Alvaro, Schwock, #strong[Ragland], Abadi \(2021\) - 180th Meeting of the Acoustical Society of America]])


== Media Coverage


#one-col-entry(content: [#bullet-entry[#link("https://web.archive.org/web/20230731211310/https://www.ece.uw.edu/spotlight/listening-to-the-ocean-climate-change/")[Listening to the ocean to measure the impact of climate change]]])
#v(design-entries-vertical-space-between-entries)
#one-col-entry(content: [#bullet-entry[OOI Science Highlights: #link("https://web.archive.org/web/20230731211602/https://oceanobservatories.org/2022/11/an-overview-of-ambient-sound-using-ooi-hydrophones/")[An Overview of Ambient Sound Using OOI Hydrophones]]])


== Cruise Experience


#one-col-entry(content: [#bullet-entry[RC0090, 2022, 2 days - deployed mooring with two hydrophones that was recovered one week later. The goal of this deployment was to acoustically measure methane seeps in the Puget Sound.]])
#v(design-entries-vertical-space-between-entries)
#one-col-entry(content: [#bullet-entry[RR2411, 2024, 21 days - joint operation to measure deep scattering layer, and low-frequency acoustic propagation around seamounts in the North Atlantic.]])
#v(design-entries-vertical-space-between-entries)
#one-col-entry(content: [#bullet-entry[AR90, 2025, 21 days - recovered NESMA acoustic moorings in North Atlantic]])


== Open Source Software Contributions


#one-col-entry(content: [#bullet-entry[#strong[OOIPy] - python package for accessing OOI hydrophone data #link("https://github.com/Ocean-Data-Lab/ooipy")[GitHub]#link("https://pypi.org/project/ooipy/")[PyPI]#link("https://doi.org/10.5281/zenodo.4276861")[DOI]]])
#v(design-entries-vertical-space-between-entries)
#one-col-entry(content: [#bullet-entry[#strong[xrsignal] - python package that ports functionality from scipy.signal to xarray and is compatible with distributed computing #link("https://github.com/John-Ragland/xrsignal")[GitHub] #link("https://pypi.org/project/xrsignal/")[PypI]]])
#v(design-entries-vertical-space-between-entries)
#one-col-entry(content: [#bullet-entry[#strong[pygenray] - native python ray tracing code #link("https://github.com/John-Ragland/pygenray")[GitHub] #link("https://pypi.org/project/pygenray/")[PyPI] #link("https://doi.org/10.5281/zenodo.15783848")[DOI]]])


