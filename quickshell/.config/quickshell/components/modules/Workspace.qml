import QtQuick
import Quickshell.Hyprland



Row {
  spacing: 0

  Repeater {
    model: Hyprland.workspaces
  
    Rectangle { 
      height: 30  
      width: 24

      color: "transparent"

      
      Rectangle {
        height: 2
        width: parent.width

        color: modelData.active || mouseArea.containsMouse ? "white" : "transparent"

        anchors {
          bottom: parent.bottom
        }
      }
      

      MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true
        
        onClicked: {
          modelData.activate()
        }
      }

      Text {
        text: modelData.id
        anchors.centerIn: parent

        color: "white"

        font.pixelSize: 12
        font.bold: true
      }
    }
  }
}