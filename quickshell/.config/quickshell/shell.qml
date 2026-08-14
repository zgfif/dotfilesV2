import Quickshell
import "./components/areas"
import "./app"

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
