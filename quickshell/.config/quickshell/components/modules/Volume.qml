// Volume.qml

import QtQuick

import Quickshell

import Quickshell.Services.Pipewire

import "../../app"
import "../../utils/volume.js" as VolumeUtils

Rectangle {
    id: volume
    
    readonly property PwNode audioSink: Pipewire.defaultAudioSink
    readonly property real level: VolumeUtils.getVolume(audioSink)
    readonly property bool muted: VolumeUtils.isMuted(audioSink)
    
    width: 30
    height: 30

    color: AppState.defaultBackgroundColor
    
    PwObjectTracker {
	    objects: [volume.audioSink]
	}

    Text {
        anchors.centerIn: parent

        color: AppState.defaultTextColor
        text: VolumeUtils.indicator(level, muted)

        font {
            pixelSize: AppState.defaultFontSize
            bold: AppState.defaultFontBold
        }
    }

    HoverHandler {
        id: hover
    }

    PopupWindow {
        anchor.item: volume
        
        visible: hover.hovered

        implicitWidth: 80
        implicitHeight: 60

        anchor.rect {
            x: (volume.width - implicitWidth) / 2
            y: volume.height + 10
        }
        
        color: "transparent"

        Rectangle {
            anchors.fill: parent

            color: AppState.defaultPopupBackground
            radius: AppState.defaultPopupRadius
            
            Text {
                anchors.centerIn: parent

                color: AppState.defaultTextColor
                text: VolumeUtils.tooltip(level, muted)
            }
        }
    }
}
