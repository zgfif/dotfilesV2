#!/usr/bin/env bash

# activates showing only empty string if not found any desktop files:
shopt -s nullglob

dm=${XDG_CURRENT_DESKTOP:-}

declare -A parameters



in_list() { # in_list "A;B;C" "x:y"
    local -r IFS=";:"
    local x y

    for x in $1; do
        for y in $2; do
            [[ "$x" == "$y" ]] && return 0
        done
    done
    return 1
}



for desktop in /usr/share/applications/*.desktop; do
    parameters=()

    while IFS='=' read -r key value; do
        [[ -z "$key" ]] && continue
        parameters["$key"]="$value"
    done < <(awk '
        /^\[Desktop Entry\]/ { flag=1; next } 
        /^\[/ { flag=0 } 
        flag && /=/ { print }
    ' "$desktop")

    [[ "${parameters[NoDisplay]}" == "true" ]] && continue
    [[ "${parameters[Hidden]}" == "true" ]] && continue

    if [[ -n "$dm" ]]; then
        if [[ -n "${parameters[OnlyShowIn]}" ]] && !in_list "${parameters[OnlyShowIn]}" "$dm"; then
            continue
        fi

        if [[ -n "${parameters[NotShowIn]}" ]] && in_list "${parameters[NotShowIn]}" "$dm"; then
            continue
        fi
    fi

    printf "%s ___ %s ___ %s ___ %s\n" \
        "${parameters[Name]}" "${parameters[Exec]}" \
        "${parameters[Icon]}" "${parameters[Terminal]}"
done

