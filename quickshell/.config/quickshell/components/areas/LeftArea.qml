import QtQuick
import "../modules"
import "../../app"

Rectangle {
  implicitHeight: parent.height
  implicitWidth: 200

  anchors {
    left: parent.left
    leftMargin: 8
  }

  color: AppState.defaultBackgroundColor
  
  Workspace {
    height: parent.height
    anchors.left: parent.left
  }
}
