import QtQuick
import Quickshell.Services.UPower 
import Quickshell
import "../../app"

Rectangle {
    id: powerMode

    property var powerIcons: ["󰌪", "", "󱐌"]
    
    width: 30
    height: 30

    color: AppState.defaultBackgroundColor
    
    function updatePowerIndicator() {
        let icon = powerIcons[0]
        let profileName = "Save"

        switch (PowerProfiles.profile) {
            case PowerProfiles.Balanced:
                icon = powerIcons[1]
                profileName = "Balanced"
                break

            case PowerProfiles.Performance:
                icon = powerIcons[2]
                profileName = "Performance"
                break
        } 
    
        profileText.text = icon
        popupText.text = profileName
    }

    Component.onCompleted: updatePowerIndicator()

    // update indicator every 1 second
    Timer {
        interval: 1_000
        running: true
        repeat: true

        onTriggered: updatePowerIndicator()
    }

    Text {
        id: profileText  
        anchors.centerIn: parent
        color: AppState.defaultTextColor
    }

    HoverHandler {
        id: hover
    }

    PopupWindow {
        implicitWidth: 80
        implicitHeight: 50

        visible: hover.hovered

        color: AppState.defaultBackgroundColor

        anchor.item: powerMode

        anchor.rect {
            x: -(powerMode.width / 2) - 10
            y: powerMode.height + 10
        }

        Rectangle {
            anchors.fill: parent
            color: AppState.defaultPopupBackground
            radius: AppState.defaultPopupRadius

            Text {
                id: popupText
                color: AppState.defaultTextColor
                anchors.centerIn: parent
            }
        }
    }
}
