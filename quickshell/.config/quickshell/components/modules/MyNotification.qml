// MyNotification.qml

import QtQuick

import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Notifications

import "../../app"

PanelWindow {
    id: notificationWindow

    WlrLayershell.layer: WlrLayer.Overlay

    property string summary: ""

    implicitWidth: 300
    implicitHeight: 60

    visible: false

    anchors.bottom: true
    margins.bottom: 100

    exclusionMode: ExclusionMode.Ignore

    Timer {
        id: timer
        interval: 2_000

        onTriggered: {
            notificationWindow.visible = false
        }
    }

    color: "transparent"

    Rectangle {
        anchors.fill: parent

        color: AppState.notificationBackground

        radius: AppState.defaultPopupRadius
        border.color: AppState.notificationBorderColor

        Text {
            anchors.centerIn: parent

            width: parent.width - 20

            color: AppState.notificationFontColor

            wrapMode: Text.WordWrap
            
            horizontalAlignment: Text.AlignHCenter
            
            font {
                bold: AppState.defaultFontBold
                pixelSize: AppState.notificationFontSize
                family: AppState.defaultFontFamily
            }

            text: summary
        }
    }

    NotificationServer {
        onNotification: (notification) => {
            summary = notification.summary
            notificationWindow.visible = true
            timer.start()
        }
    }
}
