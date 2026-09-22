// ApplicationDelegate.qml

// import QtQml
import QtQuick

import Quickshell
import Quickshell.Widgets

import "../../app"

// Displays an application in the launcher.   
Rectangle {
    required property string name
    required property string icon
    required property string exec
    required property string terminal

    readonly property bool isCurrent: ListView.isCurrentItem

    width: AppState.launcherItemWidth
    height: AppState.launcherItemHeight

    color: isCurrent
        ? AppState.launcherSelectedBgColor 
        : AppState.launcherBgColor

    IconImage {
        anchors {
            left: parent.left
            leftMargin: 10
            verticalCenter: parent.verticalCenter
        }

        width: 30
        height: 30
        
        source: Quickshell.iconPath(icon)
    }

    Text {
        anchors.fill: parent

        leftPadding: 60
        verticalAlignment: Text.AlignVCenter

        font { 
            pixelSize: AppState.launcherFontSize
            family: AppState.defaultFontFamily
        }

        color: AppState.launcherFontColor
        text: name
    }
}
