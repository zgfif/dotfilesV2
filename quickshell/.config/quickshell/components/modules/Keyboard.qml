import QtQuick
import Quickshell.Io



Rectangle {
  height: 30
  width: 30

  color: "transparent"

  Socket {
    path: "/run/user/1000/hypr/5c9377c15f85c50648f35ca5a213754f95b93ca0_1785955851_1355026210/.socket2.sock"
    connected: true
        
    parser: SplitParser {
      onRead: message => {
        keyboardText.text = (/Russian/.test(message)) ? "ru" : "en"
      }
    }
  }


  Text {
    id: keyboardText

    text: "en"
    anchors.centerIn: parent

    color: "white"
    font.pixelSize: 12
    font.bold: true
  }
}
