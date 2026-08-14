import QtQuick
import Quickshell.Services.UPower 
import Quickshell



Rectangle {
  id: powerMode
  
  height: 30
  width: 30

  color: "transparent"

  Timer {
    interval: 1000

    running: true

    repeat: true

    onTriggered: {
      const profile = PowerProfiles.profile

      let icon = ""
      let desc = ""
  
      if (profile == 1) {
        icon = ""
        desc = "Balanced"
      } else if (profile == 2) {
        icon = "󱐌"
        desc = "Performance"
      } else {
        icon = "󰌪"
        desc = "Save"
      }

      profileText.text = icon
      popupText.text = desc
    }
  }

  Text {
    id: profileText
  
    text: ""
    anchors.centerIn: parent

    color: "white"
  }

  HoverHandler {
    id: hover
  }

  PopupWindow {
    visible: hover.hovered ? true : false
    implicitHeight: 50
    implicitWidth: 80

    color: "transparent"

    anchor.item: powerMode

    anchor.rect.x: -(powerMode.width / 2) - 10
    anchor.rect.y: powerMode.height + 10

    Rectangle {
      anchors.fill: parent

      color: "black"
      
      radius: 10

      Text {
        id: popupText
        
        text: "PF"
        
        color: "white"
        
        anchors.centerIn: parent
      }
    }
  }
}
