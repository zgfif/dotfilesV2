import QtQuick
import Quickshell.Io


Rectangle {
  height: 30
  width: 30

  color: "transparent"
  
  Process {
    id: batteryProcess

    command: ["cat", "/sys/class/power_supply/BAT1/capacity"]
    // cat /sys/class/power_supply/BAT0/status
    running: true

    stdout: StdioCollector {
      onStreamFinished: {
        let percentage = this.text

        let n = parseInt(percentage, 10)
        
        let text = "";

        if (n <=10) {
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
      }
    }
  }

  Timer {
    interval: 1000

    running: true

    repeat: true

    onTriggered: batteryProcess.running = true
  }

  Text {
    id: batterText

    text: "󰁹"
    
    anchors.centerIn: parent

    color: "white"
  }
}
