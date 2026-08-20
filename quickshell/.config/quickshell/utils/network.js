const WIFIICONS = ["󰤯", "󰤟", "󰤢", "󰤥", "󰤨"]



// choose Network indicator icon
function chooseIcon(wifiAdapter) {
    if (!wifiAdapter)
        return "?"

    const network = connectedNetwork(wifiAdapter)
    const strength = signalStrength(network)

    if (strength > 0.9)
        return WIFIICONS[4]
    if (strength > 0.75)
        return WIFIICONS[3]

    if (strength > 0.5)
        return WIFIICONS[2]

    if (strength > 0.25)
        return WIFIICONS[1]
    
    return WIFIICONS[0]
}



// return connected AP
function connectedNetwork(wifiAdapter) {
    for (const network of wifiAdapter.networks.values) {
        if (!network.connected) {
            continue
        }
        return network
    }   
}



// description for tooltip on network indicator
function description(wifiAdapter) {
    if (!wifiAdapter)
        return "?"

    const network = connectedNetwork(wifiAdapter)
    const name = networkName(network)
    const strength = signalStrength(network)

    return `${name}\n${(strength * 100).toFixed()}%`
}


// return AP name
function networkName(network) {
    return network.name
}


// return AP signal strength
function signalStrength(network) {
    return parseFloat(network.signalStrength)
}
