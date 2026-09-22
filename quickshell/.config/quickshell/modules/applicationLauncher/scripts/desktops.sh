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
    
    name=$(get_value $desktop Name)
    exec=$(get_value $desktop Exec)
    icon=$(get_value $desktop Icon)
    terminal=$(get_value $desktop Terminal)

    printf "%s ___ %s ___ %s ___ %s\n" "$name" "$exec" "$icon" "$terminal"
  done
}


collect_apps_details
