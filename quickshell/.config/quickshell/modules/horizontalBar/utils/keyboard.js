// keyboard.js

function convertToShortLayout(longLayout) {
    if (!longLayout)
        return "?"

    if (longLayout.includes("English"))
        return "en"

    if (longLayout.includes("Russian"))
        return "ru"

    return "?"
}



function longLayoutFromKeyboards(text) {
    try {
        const keyboards = JSON.parse(text).keyboards
        const mainKeyboard = keyboards.find(keyboard => keyboard.main)
        
        if (!mainKeyboard)
            return "?"
        
        return mainKeyboard.active_keymap
    } catch (error) {
        console.log("Failed to parse keyboard state: ", error)
        return "?"
    }
}



function longLayoutFromEvent(message) {
    return message.split(">>")[1] ?? "?"
}


// Return true if the message is a layout event.
function containsLayout(message) {
    return message.startsWith("activelayout>>")
}



function pathToSocket(xdgRuntimeDir, signature) {
    return `${xdgRuntimeDir}/hypr/${signature}/.socket2.sock`
}



function getKeyboardsCommand() {
    return ["hyprctl", "devices", "-j"]
}
