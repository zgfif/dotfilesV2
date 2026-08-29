// PowerMode.qml

import QtQuick

import Quickshell
import Quickshell.Services.UPower

import "../../app"
import "../../utils/powerMode.js" as PowerModeUtils

Rectangle {
    id: powerMode
    
    width: 30
    height: 30

    color: AppState.defaultBackgroundColor

    Text {
        anchors.centerIn: parent

        color: AppState.defaultTextColor
        text: PowerModeUtils.indicator(PowerProfiles)
    }

    HoverHandler {
        id: hover
    }

    PopupWindow {
        anchor.item: powerMode

        implicitWidth: 80
        implicitHeight: 60

        visible: hover.hovered

        color: "transparent"

        anchor.rect {
            x: (powerMode.width - implicitWidth) / 2
            y: powerMode.height + 10
        }

        Rectangle {
            anchors.fill: parent

            radius: AppState.defaultPopupRadius
            color: AppState.defaultPopupBackground

            Text {                
                anchors.centerIn: parent
                
                color: AppState.defaultTextColor
                text: PowerModeUtils.tooltip(PowerProfiles)
            }
        }
    }
}
