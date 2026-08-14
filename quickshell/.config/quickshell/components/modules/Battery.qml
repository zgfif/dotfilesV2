import QtQuick
import Quickshell.Io
import Quickshell



Rectangle {
  height: 30
  width: 30

  id: battery
  color: "transparent"
  
  Process {
    id: batteryProcess

    command: ["cat", "/sys/class/power_supply/BAT1/capacity"]
    
    running: true

    stdout: StdioCollector {
      onStreamFinished: {
        let percentage = this.text
        
        popupText.text = percentage

        let n = parseInt(percentage, 10)
        
        let text = "";

        if (n <=10) {
          batterText.color = "red"
          text = "󰁺"
        } else if (n <= 20) {
          text = "󰁻"
        } else if (n <= 30) {
          text = "󰁼"
        } else if (n <= 40) {
          text = "󰁽"
        } else if (n <= 50) {
          text = "󰁾"
        } else if (n <= 60) {
          text = "󰁿"
        } else if (n <= 70) {
          text = "󰂀"
        } else if (n <= 80) {
          text = "󰂁"
        } else if (n <= 90) {
          text = "󰂂"
        } else {
          text = "󰁹"
        }

        batterText.text = text
        popupText.text = "bat: "+ n + "%"
      }
    }
  }


  Timer {
    interval: 1000

    running: true

    repeat: true

    onTriggered: { 
      batteryProcess.running = true
    }
  }

  Text {
    id: batterText

    text: "󰁹"
    
    anchors.centerIn: parent

    color: "white"
  }

  HoverHandler {
    id: hover
  }

  PopupWindow {
    implicitHeight: 40
    implicitWidth: 80

    anchor.item: battery

    visible: hover.hovered ? true: false

    color: "transparent"

    anchor.rect.x: -(battery.width / 2) - 10
    anchor.rect.y: battery.height + 10

    Rectangle {
      color: "black"

      anchors.fill: parent

      radius: 10

      Text {
        id: popupText
        text: "60%"
        
        anchors.centerIn: parent
        
        color: "white"
      }
    }
  }
}
