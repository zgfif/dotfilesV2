import Quickshell

import "./components/areas"



PanelWindow {
  anchors {
    top: true
    left: true
    right: true
  }

  color: "transparent"

  implicitHeight: 30
  
  LeftArea {
    anchors.left: parent.left
  }

  RightArea {
    anchors.right: parent.right
  }
}
