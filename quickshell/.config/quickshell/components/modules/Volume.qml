import QtQuick
import Quickshell.Io



Rectangle {
  height: 30
  width: 30

  color: "transparent"

  Process {
    id: volumeGetter

    command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]
    
    running: true

    stdout: StdioCollector {
      onStreamFinished: {
        let array = this.text.split(" ")

        let volume = parseFloat(array[array.length - 1])
        
        let elems = ["", "", "", ""]

        if (volume >= 0.66) {
          volumeText.text = elems[3]
        } else if (volume >= 0.33) {
          volumeText.text = elems[2]
        } else if (volume > 0) {
          volumeText.text = elems[1]
        } else {
          volumeText.text = elems[0]
        }
      }
    }

  }

  Timer {
    interval: 1000

    running: true

    repeat: true

    onTriggered: {
      volumeGetter.running = true
    }
  }

  Text {
    id: volumeText

    text: ""

    anchors.centerIn: parent

    color: "white"
  }
}
