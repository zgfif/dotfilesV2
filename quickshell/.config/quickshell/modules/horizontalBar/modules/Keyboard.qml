// Keyboard.qml

import QtQuick

import Quickshell
import Quickshell.Io

import "../../../app"
import "../utils/keyboard.js" as KeyboardUtils

Rectangle {
    id: keyboard

    property string layout: "?"

    width: 30
    height: 30

    color: AppState.defaultBackgroundColor

    // Retrieve the current keyboard layout on startup.
    Process {
        running: true
      
        command: KeyboardUtils.getKeyboardsCommand()

        stdout: StdioCollector {
            id: keyboardsState

            onStreamFinished: {
                const longLayout = 
                    KeyboardUtils.longLayoutFromKeyboards(keyboardsState.text)
                
                keyboard.layout = 
                    KeyboardUtils.convertToShortLayout(longLayout)
            }
        }
    }

    // Listen for Hyprland layout changes.
    Socket {        
        property string xdgRuntimeDir: 
            Quickshell.env("XDG_RUNTIME_DIR")

        property string instanceSignature: 
            Quickshell.env("HYPRLAND_INSTANCE_SIGNATURE")

        connected: xdgRuntimeDir !== "" && instanceSignature !== ""

        path: KeyboardUtils.pathToSocket(
            xdgRuntimeDir, 
            instanceSignature
        )

        parser: SplitParser {
            onRead: message => {
                if (!KeyboardUtils.containsLayout(message))
                    return
                
                const longLayout = KeyboardUtils.longLayoutFromEvent(message)
                
                keyboard.layout = 
                    KeyboardUtils.convertToShortLayout(longLayout)
            }
        }
    }

    // Keyboard layout indicator.
    Text {
        anchors.centerIn: parent

        color: AppState.defaultTextColor
        text: keyboard.layout

        font {
            pixelSize: AppState.defaultFontSize
            bold: AppState.defaultFontBold
        }
    }
}
