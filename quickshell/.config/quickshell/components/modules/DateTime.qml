// DateTime.qml
import QtQuick

import Quickshell

import "../../app"

Rectangle {
    id: dateTime

    width: 45
    height: 30

    color: AppState.defaultBackgroundColor
    
    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    HoverHandler { 
        id: hover 
    }

    Text {
        anchors.centerIn: parent

        color: AppState.defaultTextColor
        text: Qt.formatDateTime(clock.date, AppState.timeFormat)

        font {
            pixelSize:AppState.defaultFontSize
            bold: AppState.defaultFontBold
        }
    }

    PopupWindow {
        implicitWidth: 100
        implicitHeight: 60
        
        visible: hover.hovered
        anchor.item: dateTime
        
        anchor.rect {
            x: -53
            y: dateTime.height + 10
        }
        
        color: "transparent"
        
        Rectangle {
            anchors.fill: parent
            
            color: AppState.defaultPopupBackground
            radius: AppState.defaultPopupRadius

             Text {
                anchors.centerIn: parent
                color: AppState.defaultTextColor                
                text: Qt.formatDateTime(clock.date, AppState.dateFormat)
            }
        }
    }
}
