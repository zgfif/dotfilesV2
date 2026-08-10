import QtQuick
import Quickshell.Services.UPower 


Rectangle {  
  height: 30
  width: 30

  color: "transparent"

  Timer {
    interval: 1000

    running: true

    repeat: true

    onTriggered: {
      const profile = PowerProfiles.profile

      let text = ""

      if (profile == 0) {
        text = "󰌪"
      } else if (profile == 1) {
        text = ""
      } else {
        text = "󱐌"
      }
      profileText.text = text
    }
  }

  Text {
    id: profileText
  
    text: ""
    anchors.centerIn: parent

    color: "white"
  }
}
