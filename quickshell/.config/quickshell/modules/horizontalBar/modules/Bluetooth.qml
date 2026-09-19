// Bluetooth.qml

import QtQuick

import Quickshell
import Quickshell.Bluetooth

import "../../../app"
import "../utils/bluetooth.js" as BluetoothUtils

Rectangle {
    id: bluetooth

    readonly property var bluetoothAdapter: Bluetooth.defaultAdapter 

    width: 30
    height: 30

    color: AppState.defaultBackgroundColor

    HoverHandler {
        id: hover
    }

    Text {
        anchors.centerIn: parent

        color: AppState.defaultTextColor
        text: BluetoothUtils.indicator(bluetoothAdapter)

        font {
            pixelSize: AppState.defaultFontSize
            bold: AppState.defaultFontBold
        }
    }

    PopupWindow {
        anchor.item: bluetooth
        
        visible: hover.hovered       
        
        implicitWidth: 140
        implicitHeight: 60

        color: "transparent"
        
        anchor.rect {
            x: (bluetooth.width - implicitWidth) / 2
            y: bluetooth.height + 10
        }

        Rectangle {
            anchors.fill: parent
            color: AppState.defaultPopupBackground
            radius: AppState.defaultPopupRadius

            Text {
                anchors.centerIn: parent
                color: AppState.defaultTextColor
                text: BluetoothUtils.tooltip(bluetoothAdapter)
            }
        }
    }
}
