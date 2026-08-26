// battery.js

const BATTERY_ICONS = [
    "󰁺", 
    "󰁻", 
    "󰁼", 
    "󰁽", 
    "󰁾", 
    "󰁿", 
    "󰂀", 
    "󰂁", 
    "󰂂", 
    "󰁹"
]



function getDevice(UPower) {
    return UPower.devices.values.find(
        device => device.isLaptopBattery
    ) ?? null
}


function chooseIcon(battery) {
    if (!battery)
        return "?"

    const level = battery.percentage

    if (level <= 0.1)
        return BATTERY_ICONS[0]

    if (level <= 0.2)
        return BATTERY_ICONS[1]
    
    if (level <= 0.3)
        return BATTERY_ICONS[2]

    if (level <= 0.4)
        return BATTERY_ICONS[3]

    if (level <= 0.5)
        return BATTERY_ICONS[4]

    if (level <= 0.6)
        return BATTERY_ICONS[5]
    
    if (level <= 0.7)
        return BATTERY_ICONS[6]
    
    if (level <= 0.8)
        return BATTERY_ICONS[7]
    
    if (level <= 0.9)
        return BATTERY_ICONS[8]
    
    return BATTERY_ICONS[9]
}



function tooltip(battery) {
    if (!battery)
        return "?"

    const percentage = (battery.percentage * 100).toFixed()
    
    return `bat: ${percentage}%`
}
