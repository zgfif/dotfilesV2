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
        BatteryUtils.getDevice(UPower)

    Text {
        anchors.centerIn: parent

        color: AppState.defaultTextColor
        text: BatteryUtils.indicator(battery.device)
    }

    HoverHandler {
        id: hover
    }

    // Show additional battery information on hover.
    PopupWindow {
        anchor.item: battery

        implicitWidth: 100
        implicitHeight: 60

        visible: hover.hovered

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
                text: BatteryUtils.tooltip(battery.device, UPowerDeviceState)
            }
        }
    }
}
