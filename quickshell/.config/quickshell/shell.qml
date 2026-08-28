// shell.qml
import Quickshell

import "./components/areas"
import "./app"
import "./components/modules/"

ShellRoot {
    PanelWindow {
        anchors {
            top: true
            left: true
            right: true
        }

        implicitHeight: 30
        color: AppState.defaultBackgroundColor
    
        LeftArea {
            anchors.left: parent.left
        }

        RightArea {
            anchors.right: parent.right
        }
    }

    MyNotification { }
}

