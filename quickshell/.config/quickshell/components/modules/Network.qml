import QtQuick
import Quickshell.Networking
import Quickshell
import "../../app"
import "../../utils/network.js" as NetworkUtils

Rectangle {
    id: network

    width: 30
    height: 30
    color: AppState.defaultBackgroundColor

    readonly property var wifiAdapter: Networking.devices.values.find(
        value => value.name.startsWith("wlp")
    )

    // run nmtui after clicking on indicator
    TapHandler {
        onTapped: Quickshell.execDetached({
            command: ["kitty", "-e", "nmtui"]
        })
    }

    HoverHandler {
        id: hover
    }

    Text {
        id: textNetwork

        anchors.centerIn: parent
        color: AppState.defaultTextColor
        text: NetworkUtils.chooseIcon(network.wifiAdapter)
    }

    PopupWindow {
        anchor.item: network
        visible: hover.hovered

        color: AppState.defaultBackgroundColor

        implicitWidth: 140
        implicitHeight: 46

        anchor.rect {
            x: -(implicitWidth / 2) + network.width / 2
            y: network.height + 10
        }

        Rectangle {
            anchors.fill: parent
            color: AppState.defaultPopupBackground
            radius: AppState.defaultPopupRadius

            Text {
                anchors.centerIn: parent
                color: AppState.defaultTextColor
                text: NetworkUtils.description(network.wifiAdapter)
            }
        }
    }
}
