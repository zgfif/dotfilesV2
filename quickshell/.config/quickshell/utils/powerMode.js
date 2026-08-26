// powerMode.js

const PROFILE_ICONS = ["󰌪", "", "󱐌"]


function indicator(powerProfiles) {
    const profile = powerProfiles.profile

    if (profile === powerProfiles.PowerSaver)
        return PROFILE_ICONS[0]

    if (profile === powerProfiles.Balanced)
        return PROFILE_ICONS[1]

    if (profile === powerProfiles.Performance)
        return PROFILE_ICONS[2]

    return "?"
}



function tooltip(powerProfiles) {
    const profile = powerProfiles.profile

    if (profile === powerProfiles.PowerSaver)
        return "Save"

    if (profile === powerProfiles.Balanced)
        return "Balanced"

    if (profile === powerProfiles.Performance)
        return "Performance"

    return "?"
}
