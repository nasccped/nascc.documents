/* ================================================================================================
 * variables, constants and functions...
 * ============================================================================================= */
#let lang = sys.inputs.at("lang", default: "empty")
#let english = "en"
#let portuguese = "pt"
#let (info, preposition) = {
  if lang == english {
    (yaml("info-" + english + ".yaml"), "at")
  } else if lang == portuguese {
    (yaml("info-" + portuguese + ".yaml"), "no(a)")
  } else {
    panic(
      "\n"+
      "  > invalid lang: '" + lang + "'\n" +
      "  > expected is '" + english + "' or '" + portuguese + "'!\n"
    )
  }
}
#let titles = (
  experience: if lang == portuguese { "Experiência" } else { "Experience" },
  education: if lang == portuguese { "Educação" } else { "Education" },
  idioms: if lang == portuguese { "Idiomas" } else { "Idioms" }
)

#let default_margin = (
  left: 1.6cm,
  right: 1.3cm,
  top: 1.3cm,
  bottom: 1.7cm
)

#let display_from_to_date(from, to) = {
  let dates_bg = gray.lighten(80%)
  let dates_fg = black.lighten(25%)
  let dates_inset = 1.85pt
  let dates_ratio = 15%
  let dates_size = 0.8em

  block(
    height: auto,
    fill: dates_bg,
    inset: dates_inset,
    radius: dates_ratio,
  )[#text(size: dates_size, fill: dates_fg)[#from - #to]]
}

#let display_education(edus, preposition) = {
  stack(
    spacing: 0.7em,
    ..edus.map(edu => {
      let title = edu.title
      let kind = edu.kind
      let at = edu.at.place
      let lnk = edu.at.link
      let from = edu.from
      let to = edu.to

      stack(
        spacing: 0.4em,

        // title, kind and place
        [- #title (#kind) #preposition #link(lnk)[#at]],

        // from - to block
        display_from_to_date(from, to)
      )
    })
  )
}

#let display_experiences(exps, preposition) = {
  for exp in info.experiences {
    let role = exp.role
    let at = exp.at.place
    let lnk = exp.at.link
    let description = exp.description
    let from = exp.from
    let to = exp.to

    stack(
      spacing: 0.4em,

      // role + place heading
      heading(level: 3)[#role #preposition #link(lnk)[#at]],

      // from - to block
      display_from_to_date(from, to),

      // description
      block()[
        #for desc in description {
          [- #desc]
        }
      ]
    )
  }
}

#let main_heading(profile) = {

  // used variables
  let name = profile.name
  let role = profile.role
  let phone = profile.phone
  let location = profile.location
  let timezone = profile.timezone
  let mail = profile.mail
  let linkedin = profile.linkedin
  let github = profile.github

  // change header spacing
  show heading.where(level: 1): it => block(above: 0em, below: 6pt)[#text(size: 1.3em)[#it]]
  show heading.where(level: 2): it => block(above: 0em, below: 12pt)[#text(size: 0.8em)[#it]]

  // turn link pretty
  let shortfy(string) = {
    string.replace("https://", "")
  }

  // main heading
  heading(level: 1)[#name]
  heading(level: 2)[#role]

  // two colums
  grid(columns: (1fr, 1fr),

    // left (location fields)
    [
      #phone \
      #location \
      #timezone
    ],

    // right (contact fields)
    align(right)[
      #link("mailto:" + mail)[#mail] \
      #link(linkedin)[#shortfy(linkedin)] \
      #link(github)[#shortfy(github)]
    ]
  )
}

#let simple_heading(title) = {
  block(above: 1.2em, below: 1.3em, heading(level: 2)[#title])
}

/* ================================================================================================
 * global setters and shows
 * ============================================================================================= */
#set page(paper: "a4", margin: default_margin)
#show link: it => underline(text(fill: navy)[#it])
#show divider: it => block(above: 1em, below: 1em)[
  #line(stroke: black.lighten(20%))
]

/* ================================================================================================
 * render start
 * ============================================================================================= */

#main_heading(info.profile)
#divider()
#info.about

#simple_heading(titles.experience)
#display_experiences(info.experiences, preposition)

#simple_heading(titles.education)
#display_education(info.education, preposition)

// end section (idioms + extra)
#columns(2)[

  #simple_heading(titles.idioms)

  #for id in info.idioms {
    [- #id]
  }

  #colbreak()

  #simple_heading("Extra")

  #for item in info.outros {
    [- #link(item.link)[#item.title], #item.description]
  }
]
