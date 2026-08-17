import QtQuick
import Quickshell.Io
import "../../app"

Rectangle {
    id: keyboard

    width: 30
    height: 30

    color: AppState.defaultBackgroundColor

    // process to retrieve current keyboard layout.
    Process {
        running: true
      
        command: ["sh", "-c", "hyprctl devices -j | jq -r '.keyboards[8].active_keymap'"]

        stdout: StdioCollector {
            onStreamFinished: {
                keyboardText.text = getShortForm(this.text)
            }
        }
    }

    function getShortForm(longForm) {      
        if (/English/.test(longForm)) {
            return "en"
        } else if (/Russian/.test(longForm)) {
            return "ru"
        }

        return ""
    }

    // process to retrieve the Hyprland instance signature.
    Process {    
        running: true

        command: ["sh", "-c", "echo $HYPRLAND_INSTANCE_SIGNATURE"]

        stdout: StdioCollector {
            onStreamFinished: {
                const signature = this.text.trim()
                
                if (signature === "") {
                    return
                }

                kbSocket.instanceSignature = signature
                kbSocket.connected = true
            }
        }
    }

    // Socket which listens for Hyprland events.
    Socket {
        id: kbSocket
        
        property string instanceSignature: ""

        path: "/run/user/1000/hypr/" + kbSocket.instanceSignature + "/.socket2.sock"
        
        connected: false
            
        parser: SplitParser {
            onRead: message => {
                if (!message.startsWith("activelayout>>"))
                    return
                
                const layout = message.split(">>")[1]
                keyboardText.text = getShortForm(message)
            }
        }
    }

    Text {
        id: keyboardText

        anchors.centerIn: parent

        color: AppState.defaultTextColor

        font {
            pixelSize: AppState.defaultFontSize
            bold: AppState.defaultFontBold
        }
    }
}
