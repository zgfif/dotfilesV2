// bluetooth.js

function indicator(bluetoothAdapter) {
    if (!bluetoothAdapter.enabled)
        return "󰂲"

    if (!getConnectedDevice(bluetoothAdapter))
        return "󰂯"

    return "󰂰"
}



function tooltip(bluetoothAdapter) {
    const device = getConnectedDevice(bluetoothAdapter)
    
    if (!device)
        return "disconnected"
    
    if (!device.batteryAvailable)
        return "no battery"

    const deviceName = device.name ?? ""

    const deviceBattery = device.battery ?? 0

    return `${deviceName}\n${toPercents(deviceBattery)}%`
}



function getConnectedDevice(bluetoothAdapter) {
    return bluetoothAdapter?.devices.values.find(device => device.connected)
}



function toPercents(number) {
    return (number * 100).toFixed()
}
