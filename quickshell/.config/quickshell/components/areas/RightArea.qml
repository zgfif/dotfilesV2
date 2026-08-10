import QtQuick
import Quickshell.Io

import "../modules"



Rectangle {
  height: 30
  width: 200

  anchors {
    right: parent.right
    rightMargin: 8
  }

  color: "transparent"

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
