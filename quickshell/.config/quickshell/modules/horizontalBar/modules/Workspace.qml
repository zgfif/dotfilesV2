// Workspace.qml

import QtQuick

import Quickshell.Hyprland

import "../../../app"

Row {
    spacing: 0

    function workspaceBottomLineColor(modelData, mouseArea) {
        if (modelData.urgent)
            return AppState.urgentWorkspaceColor

        if (modelData.active || mouseArea.containsMouse)
            return AppState.defaultTextColor

        return AppState.defaultBackgroundColor        
    }

    Repeater {
        // Exclude special workspaces (for example, -98).
        model: Hyprland.workspaces.values.filter(
            workspace => workspace.id > 0
        )
          
        Rectangle {            
            // modelData - is current model item.

            width: 24
            height: 30

            color: AppState.defaultBackgroundColor

            // Bottom indicator for active/hovered workspace.
            Rectangle {
                anchors.bottom: parent.bottom

                width: parent.width
                height: 2

                color: workspaceBottomLineColor(modelData, mouseArea)
            }
      
            MouseArea {
                id: mouseArea

                anchors.fill: parent
                hoverEnabled: true
                
                onClicked: modelData.activate()
            }

            Text {
                anchors.centerIn: parent

                color: (modelData.urgent) 
                    ? AppState.urgentWorkspaceColor
                    : AppState.defaultTextColor

                text: modelData.id

                font {
                    pixelSize: AppState.defaultFontSize
                    bold: AppState.defaultFontBold
                }
            }
        }
    }
}
