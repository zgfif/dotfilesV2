import QtQuick

import "../modules"

Rectangle {
  height: 30
  width: 200

  anchors {
    left: parent.left
    leftMargin: 8
  }

  color: "transparent"
  
  Workspace {
    anchors.left: parent.left
  }
}
