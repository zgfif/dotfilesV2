import QtQuick
import Quickshell.Io
import Quickshell



Rectangle {
  id: volume

  height: 30
  width: 30

  color: "transparent"

  Process {
    id: volumeGetter

    command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]
    
    running: true

    stdout: StdioCollector {
      onStreamFinished: {
        const elems = ["", "", "", ""]
        
        let status = ""

        let icon = elems[0]
        
        let array = this.text.split(" ")

        let volumeElement = array[array.length - 1].replace("\n", "")

        if (volumeElement == "[MUTED]") { 
          volumeElement = array[array.length - 2]
          status = "\n[MUTED]"
        }

        icon = elems[0]
        
        let volume = Number(parseFloat(volumeElement).toFixed(2))

        if (volume >= 0.66) {
          icon = elems[3]
        } else if (volume >= 0.33) {
          icon = elems[2]
        } else if (volume > 0) {
          icon = elems[1]
        } else {
          icon = elems[0]
        }

        volumeText.text = icon
        popupText.text = "Vol: " + volume * 100 + "%" + status
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

  HoverHandler {
    id: hover
  }

  PopupWindow {
    visible: hover.hovered ? true : false
    anchor.item: volume

    implicitHeight: 46
    implicitWidth: 80

    anchor.rect.x: -(volume.width / 2) - 10
    anchor.rect.y: volume.height + 10

    color: "transparent"

    Rectangle {
      anchors.fill: parent
      radius: 10

      color: "black"

      Text {
        id: popupText
        text: "Vol: 20%"
        anchors.centerIn: parent
        color: "white"
      }
    }
  }
}
