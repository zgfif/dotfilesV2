import QtQuick
import Quickshell.Hyprland
import "../../app"

Row {
    spacing: 0

    Repeater {
        model: Hyprland.workspaces
  
        // each rectangle corresponds one existing workspace:
        Rectangle { 
            width: 24
            height: 30  

            color: AppState.defaultBackgroundColor

            // this inner rectangle visible when pointer is over parent rectangle:
            Rectangle {
                height: 2
                width: parent.width

                color: modelData.active || mouseArea.containsMouse 
                    ? AppState.defaultTextColor 
                    : AppState.defaultBackgroundColor

                anchors.bottom: parent.bottom
            }
      
            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                
                onClicked: modelData.activate()
            }

            // text for each workspace:
            Text {
                text: modelData.id
                
                anchors.centerIn: parent

                color: AppState.defaultTextColor

                font {
                    pixelSize: 12
                    bold: true
                }
            }
        }
    }
}
