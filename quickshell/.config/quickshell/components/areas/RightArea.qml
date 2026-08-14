import QtQuick
import "../modules"
import "../../app"

Rectangle {
    implicitHeight: 30
    implicitWidth: 200

    anchors {
        right: parent.right
        rightMargin: 8
    }

    color: AppState.defaultBackgroundColor

    DateTime {
        id: dateTime

        anchors.right: parent.right
    }

    Keyboard {
        id: keyboard

        anchors.right: dateTime.left
    }

    Volume {
        id: volume

        anchors.right: keyboard.left
    }

    Battery {
        id: battery

        anchors.right: volume.left
    }

    Network {
        id: network

        anchors.right: battery.left
    }

    PowerMode {
        anchors.right: network.left
    }
}
