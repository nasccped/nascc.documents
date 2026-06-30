#set page(paper: "a4")
#show link: underline

// display the main title (name + prefered role)
#let main_title(name, role, contact) = {
  let contacts = contact.map(((name, lnk)) => link(lnk)[#name])
  [= #name]
  [==== #role]
  align(center)[#contacts.join([ | ])]
}

// display the experience section
#let experience_section(experience) = {
  [== #experience.title]
  for exp in experience.experiences {
    let role = exp.role
    let employer = if exp.employer.link != none {
      link(exp.employer.link)[#exp.employer.name]
    } else {
      [#exp.employer.name]
    }
    let emp_link = exp.employer.link
    let emp_name = exp.employer.name
    let dates = exp.dates
    [- #role \[#link(emp_link)[#emp_name] | #dates.from \- #dates.to\]]
    [#exp.description]
  }
}

// display the education section
#let education_section(education) = {
  [== #education.title]
  for edu in education.items {
    let name = edu.name
    let kind = edu.kind
    let at = if edu.at.link != none {
      link(edu.at.link)[#edu.at.name]
    } else {
      [#edu.at.name]
    }
    let dates = edu.dates
    [- #name (#kind) \[#at | #dates.from - #dates.to\]]
  }
}

#let language_section(languages) = {
  [= #languages.title]
  for lang in languages.langs {
    [- *#lang.lang:* #lang.result]
  }
}

// unwrap raw data from yaml file (based on a input language).
#let info = {
  let lang = sys.inputs.at("lang", default: "empty")
  if lang != "english" and lang != "portuguese" {
    panic("invalid lang: " + target_lang)
  } else {
    yaml("../info/" + lang + ".yaml")
  }
}

#main_title(info.name, info.role, info.contact)
#info.about
#experience_section(info.experience)
#education_section(info.education)
#language_section(info.languages)
= #info.keywords.title
#info.keywords.content
