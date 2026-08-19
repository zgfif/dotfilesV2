import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import "../../app"

Rectangle {
    id: volume

    readonly property var volumeIcons: ["", "", "", ""]
    
    readonly property PwNode audioSink: Pipewire.defaultAudioSink
    
    PwObjectTracker {
	    objects: [volume.audioSink]
	}

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

    function getVolume() {
       return audioSink.audio.volume ?? 0
    }

    function mutedStatus() {
        return audioSink.audio.muted ? "\n[muted]" : ""
    }

    // indicator text
    Text {
        anchors.centerIn: parent

        color: AppState.defaultTextColor
        
        text: chooseIcon(getVolume())
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
                anchors.centerIn: parent

                color: AppState.defaultTextColor
                
                text: `${(getVolume() * 100).toFixed()}%${mutedStatus()}`
            }
        }
    }
}
