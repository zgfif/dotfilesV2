import QtQuick
import Quickshell.Networking
import Quickshell



Rectangle {
  id: network

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

      let icon = icons[0]
  
      for (const net of Networking.devices.values[1].networks.values) {
        if (net.connected) {          
          let strength = parseFloat(net.signalStrength)
          
          let message = net.name + "\n" + strength * 100 + "%"
  
          if (strength > 0.75) {
            icon = icons[3]
          } else if (strength > 0.5) {
            icon = icons[2]
          } else if (strength > 0) {
            icon = icons[1]
          }

          textNetwork.text = icon

          popupText.text = message
          break;
        }
      }
    }
  }

  HoverHandler {
    id: hover
  }

  Text {
    id: textNetwork
    text: "󰤯"
    color: "white"
    anchors.centerIn: parent

  }

  PopupWindow {
    anchor.item: network
    
    visible: hover.hovered ? true : false

    color: "transparent"

    implicitHeight: 46
    implicitWidth: 140

    anchor.rect.x: -( implicitWidth / 2) + 15
    anchor.rect.y: network.height + 10

    Rectangle {
      anchors.fill: parent
      
      color: "black"

      radius: 10

      Text {
        id: popupText

        anchors.centerIn: parent
        
        color: "white"

        text: "Alena"
      }
    }
  }
}
