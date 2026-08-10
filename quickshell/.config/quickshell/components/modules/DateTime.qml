import QtQuick
import Quickshell
import QtQuick.Controls



Rectangle {
    id: rect

    height: 30
    width: 45

    color: "transparent"
    
    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    Text {
        anchors.centerIn: parent
        text: Qt.formatDateTime(clock.date, "hh:mm")

        color: "white"

        font.pixelSize: 12
        font.bold: true
    }

    
}