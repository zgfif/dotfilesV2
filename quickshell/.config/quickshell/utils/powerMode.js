// powerMode.js

const PROFILES = [
    {
        icon: "󰌪",
        name: "Power saver"
    },
    {
        icon: "",
        name: "Balanced"
    },
    {
        icon: "󱐌",
        name: "Performance"
    },
    {
        icon: "?",
        name: "?"
    }
]



function getProfileInfo(powerProfiles) {
    switch(powerProfiles.profile) {
        case powerProfiles.PowerSaver:
            return PROFILES[0]
        
        case powerProfiles.Balanced:
               return PROFILES[1]

        case powerProfiles.Performance:
            return PROFILES[2]
        
        default:
            return PROFILES[3]
    }
}



function indicator(powerProfiles) {
    return getProfileInfo(powerProfiles).icon
}



function tooltip(powerProfiles) {
    return getProfileInfo(powerProfiles).name
}
