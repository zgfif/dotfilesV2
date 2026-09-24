#!/usr/bin/bash

get_value () {
  local filepath="$1"
  local attribute="$2"

  awk -F "=" -v attribute="$attribute" '
    /^\[Desktop Entry\]/ { flag=1; next }
    /^\[/ { flag=0 } 
    flag && $0 ~ "^" attribute "=" {print $2}
  ' "$filepath"
}


collect_apps_details () {
  local -r directory="/usr/share/applications"


  for desktop in "$directory"/*.desktop; do
    local name
    local exec
    local icon
    local terminal
    local no_display
    local hidden
    local only_show_in
    local not_show_in

    no_display=$(get_value $desktop NoDisplay)
    hidden=$(get_value $desktop Hidden)
    only_show_in=$(get_value $desktop OnlyShowIn)
    not_show_in=$(get_value $desktop NotShowIn)

    if [[ $no_display == "true" ]]; then
      continue
    fi

    if [[ $hidden == "true" ]]; then
      continue
    fi

    if [[ -n $only_show_in ]]; then
      continue
    fi

    if [[ -n $not_show_in ]]; then
      continue
    fi

    name=$(get_value $desktop Name)
    exec=$(get_value $desktop Exec)
    icon=$(get_value $desktop Icon)
    terminal=$(get_value $desktop Terminal)

    printf "%s ___ %s ___ %s ___ %s\n" "$name" "$exec" "$icon" "$terminal"
  done
}


collect_apps_details
