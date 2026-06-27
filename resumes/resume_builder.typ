// default paper format for remuse.
#set page(paper: "a4")

// returns the info data based on a language field (expecting 'english' or 'portuguese').
#let get_info_data(lang) = {
  let info_path = if lang == "english" {
    "../info/english.json"
  } else if lang == "portuguese" {
    "../info/portuguese.json"
  } else {
    panic("invalid lang: " + target_lang)
  }
  json(info_path)
}

#let info = get_info_data(sys.inputs.at("lang", default: "empty"))

= #info.name
====== #info.prefered_role
