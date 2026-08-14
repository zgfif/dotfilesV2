import QtQuick
import Quickshell.Io

Rectangle {
  id: keyboard

  height: 30
  width: 30

  color: "transparent"


  Process {    
    running: true

    command: ["sh", "-c", "echo $HYPRLAND_INSTANCE_SIGNATURE"]

    stdout: StdioCollector {
      onStreamFinished: { 
        kbSocket.hisName = this.text.replace("\n", "")
        kbSocket.connected = true
        }
    }
  }

  Socket {
    id: kbSocket
    
    property string hisName

    path: "/run/user/1000/hypr/" + kbSocket.hisName + "/.socket2.sock"
    
    connected: false
        
    parser: SplitParser {
      onRead: message => {
        keyboardText.text = (/Russian/.test(message)) ? "ru" : "en"
      }
    }
  }

  Text {
    id: keyboardText

    anchors.centerIn: parent

    text: "en"

    color: "white"

    font {
      pixelSize: 12
      bold: true
    }
  }
}
