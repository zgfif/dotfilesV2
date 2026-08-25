// Battery.qml
import QtQuick

import Quickshell
import Quickshell.Services.UPower

import "../../app"
import "../../utils/battery.js" as BatteryUtils

Rectangle {
    id: battery

    width: 30
    height: 30

    color: AppState.defaultBackgroundColor

    readonly property UPowerDevice device: 
        UPower.devices.values.find(
            device => device.model.startsWith("A")
        )

    Text {
        anchors.centerIn: parent

        color: AppState.defaultTextColor
        text: BatteryUtils.chooseIcon(battery.device)
    }

    HoverHandler {
        id: hover
    }

    // show additional information about battery.
    PopupWindow {
        implicitWidth: 80
        implicitHeight: 40

        visible: hover.hovered
        anchor.item: battery

        color: "transparent"

        anchor.rect {
            x: (battery.width - implicitWidth) / 2
            y: battery.height + 10
        }

        Rectangle {
            anchors.fill: parent
            color: AppState.defaultPopupBackground
            radius: AppState.defaultPopupRadius

            Text {
                anchors.centerIn: parent

                color: AppState.defaultTextColor
                text: BatteryUtils.description(battery.device)
            }
        }
    }
}
