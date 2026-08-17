import QtQuick
import Quickshell
import Quickshell.Io
import "../../app"

Rectangle {
    id: volume

    property var volumeIcons: ["", "", "", ""]
    
    width: 30
    height: 30

    color: AppState.defaultBackgroundColor

    function chooseIcon(level) {
        if (level >= 0.66)
            return volumeIcons[3]
        
        if (level >= 0.33)
            return volumeIcons[2]
        
        if (level > 0)
            return volumeIcons[1]

        return volumeIcons[0]
    }

    function isMuted(message) {
        return /\[MUTED\]/.test(message)
    }

    function volumeLevel(message) {
        const reg = /(\d+\.\d+)/
        const result = message.match(reg)

        return result !== null ? parseFloat(result[0]) : NaN
    }

    // process to retrieve volume level.
    Process {
        id: volumeGetter

        command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]
        
        running: true

        stdout: StdioCollector {
            onStreamFinished: {                
                const mutedStatus = isMuted(this.text) ? "\n[MUTED]" : ""
                const vol = volumeLevel(this.text)

                if (Number.isNaN(vol))
                    return
                
                volumeText.text = chooseIcon(vol)
                popupText.text = `Vol: ${(vol * 100).toFixed()}%${mutedStatus}`

            }
        }

    }

    // each 1000 ms run process to retrieve volume level
    Timer {
        interval: 1000
        running: true
        repeat: true
        
        onTriggered: volumeGetter.running = true
    }

    // indicator text
    Text {
        id: volumeText
        anchors.centerIn: parent
        color: AppState.defaultTextColor
    }

    HoverHandler {
       id: hover
    }

    // shows additional info when hover on volume item
    PopupWindow {
        visible: hover.hovered
        
        anchor.item: volume

        implicitWidth: 80
        implicitHeight: 46

        anchor.rect {
            x: -(volume.width / 2) - 10
            y: volume.height + 10
        }
        
        color: AppState.defaultBackgroundColor

        Rectangle {
            anchors.fill: parent
            radius: AppState.defaultPopupRadius
            color: AppState.defaultPopupBackground
            
            // popup window text.
            Text {
                id: popupText
                anchors.centerIn: parent
                color: AppState.defaultTextColor
            }
        }
    }
}
