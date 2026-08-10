import QtQuick
import Quickshell.Networking





Rectangle {
  height: 30
  width: 30

  color: "transparent"

  Timer {
    interval: 1000

    repeat: true

    running: true

    onTriggered: {
      let network = null;
      
      const icons = ["󰤯", "󰤟", "󰤢", "󰤥", "󰤨"]

      for (const net of Networking.devices.values[1].networks.values) {
        if (net.connected) {
          let icon = icons.values[0]

          let strength = parseFloat(net.signalStrength)

          if (0.75 <= strength < 1) {
              icon = icons[3]
          } else if (0.5<= strength < 0.75) {
            icon = icons[2]
          } else if (0 < strength < 0.5) {
            icon = icons[1]
          } else {
            icon = icons[0]
          }

          text.text = icon
          break;
        }
      }
    }
  }

  Text {
    id: text
    text: "󰤯"
    color: "white"
    anchors.centerIn: parent
  }
}
