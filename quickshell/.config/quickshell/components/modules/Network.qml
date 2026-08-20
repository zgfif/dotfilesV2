import QtQuick
import Quickshell.Networking
import Quickshell
import "../../app"

Rectangle {
    id: network

    property var wifiIcons: ["󰤯", "󰤟", "󰤢", "󰤥", "󰤨"]
    
    width: 30
    height: 30

    color: AppState.defaultBackgroundColor


    function updateNetworkIndicator() {
        const wifiAdapter = Networking.devices.values.find(
            value => /wlp/.test(value.name)
        )
        
        if (!wifiAdapter) {
            textNetwork.text = wifiIcons[0]
            popupText.text = "No WiFi adapter"
            return
        }

        for (const network of wifiAdapter.networks.values) {
            if (!network.connected) {
                continue
            }
            
            const strength = parseFloat(network.signalStrength)
            
            textNetwork.text = chooseIcon(strength)
            popupText.text = `${network.name} ${(strength * 100).toFixed()}%`

            return
        }
        
        textNetwork.text = wifiIcons[0]
        popupText.text = "Disconnected"
    }

    function chooseIcon(level) {
        if (level > 0.9)
            return wifiIcons[4]
        if (level > 0.75)
            return wifiIcons[3]

        if (level > 0.5)
            return wifiIcons[2]

        if (level > 0.25)
            return wifiIcons[1]
        
        return wifiIcons[0]
    }

    Component.onCompleted: updateNetworkIndicator()

    Timer {
        interval: 5_000
        repeat: true
        running: true

        onTriggered: updateNetworkIndicator()
    }

    MouseArea {
        anchors.fill: parent
        onClicked: Quickshell.execDetached({command: ["sh", "-c", "kitty -e 'nmtui'"]})
    }

    HoverHandler {
        id: hover
    }

    Text {
        id: textNetwork
        anchors.centerIn: parent
        color: AppState.defaultTextColor
    }

    PopupWindow {
        anchor.item: network
        
        visible: hover.hovered

        color: AppState.defaultBackgroundColor

        implicitWidth: 140
        implicitHeight: 46

        anchor.rect {
            x: -( implicitWidth / 2) + 15
            y: network.height + 10
        }

        Rectangle {
            anchors.fill: parent
            color: AppState.defaultPopupBackground
            radius: AppState.defaultPopupRadius

            Text {
                id: popupText
                anchors.centerIn: parent
                color: AppState.defaultTextColor
            }
        }
    }
}
