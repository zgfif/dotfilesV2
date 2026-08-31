import QtQuick

import Quickshell
import Quickshell.Bluetooth

import "../../app"
import "../../utils/bluetooth.js" as BluetoothUtils
Rectangle {
    id: blth

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
        text: BluetoothUtils.indicator()
    }

    PopupWindow {
        anchor.item: blth
        
        visible: hover.hovered       
        
        implicitWidth: 180
        implicitHeight: 60

        color: "transparent"
        
        anchor.rect {
            x: (blth.width - implicitWidth) / 2
            y: parent.height + 10
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
