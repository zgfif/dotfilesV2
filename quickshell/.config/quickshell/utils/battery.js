// battery.js

const BATTERYICONS = ["󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"]



// choose icon for battery indicator
function chooseIcon(battery) {
    const level = battery.percentage

    if (level <= 0.1)
        return BATTERYICONS[0]

    if (level <= 0.2)
        return BATTERYICONS[1]
    
    if (level <= 0.3)
        return BATTERYICONS[2]

    if (level <= 0.4)
        return BATTERYICONS[3]

    if (level <= 0.5)
        return BATTERYICONS[4]

    if (level <= 0.6)
        return BATTERYICONS[5]
    
    if (level <= 0.7)
        return BATTERYICONS[6]
    
    if (level <= 0.8)
        return BATTERYICONS[7]
    
    if (level <= 0.9)
        return BATTERYICONS[8]
    
    return BATTERYICONS[9]
}


function description(battery) {
    return `bat: ${(battery.percentage * 100).toFixed()}%`
}