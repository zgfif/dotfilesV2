function indicator() {
    return "󰂯"
}


function tooltip(bluetoothAdapter) {
    const connectedDevice = getConnectedDevice(bluetoothAdapter)
    
    if (!connectedDevice)
        return "not connected"

    const battery = (connectedDevice.batteryAvailable) ? convertTopercentage(connectedDevice.battery) : 0

    return `${connectedDevice.name} (${battery}%)`
}


function convertTopercentage(number) {
    return (number * 100).toFixed()
}


function getConnectedDevice(bluetoothAdapter) {
    return bluetoothAdapter?.devices.values.find(device => device.connected)
}
