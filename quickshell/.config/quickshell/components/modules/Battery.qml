import QtQuick
import Quickshell
import Quickshell.Io
import "../../app"

Rectangle {
    id: battery

    property var batteryIcons: ["󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"]

    width: 30
    height: 30

    color: AppState.defaultBackgroundColor

    function chooseIcon(percentage) {
        if (percentage <= 10)
            return batteryIcons[0]

        if (percentage <= 20)
            return batteryIcons[1]
        
        if (percentage <= 30)
            return batteryIcons[2]

        if (percentage <= 40)
            return batteryIcons[3]

        if (percentage <= 50)
            return batteryIcons[4]

        if (percentage <= 60)
            return batteryIcons[5]
        
        if (percentage <= 70)
            return batteryIcons[6]
        
        if (percentage <= 80)
            return batteryIcons[7]
        
        if (percentage <= 90)
            return batteryIcons[8]
        
        return batteryIcons[9]
    }
    
    // process to retrieve battery capacity.
    Process {
        id: batteryProcess
        command: ["cat", `/sys/class/power_supply/${AppState.defaultBatteryName}/capacity`]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {                
                const percentage = Number(this.text)
                
                if (Number.isNaN(percentage))
                    return
                
                batteryText.text = chooseIcon(percentage)
                popupText.text = `bat: ${percentage}%`
            }
        }
    }

    // Retrieve battery capacity by interval.
    Timer {
        interval: 10_000 // ms
        running: true
        repeat: true

        onTriggered: { 
            batteryProcess.running = true
        }
    }

    Text {
        id: batteryText        
        anchors.centerIn: parent
        color: AppState.defaultTextColor
    }

    HoverHandler {
        id: hover
    }

    // show additional information about battery.
    PopupWindow {
        implicitWidth: 80
        implicitHeight: 40

        visible: hover.hovered

        anchor.item: battery
        color: AppState.defaultBackgroundColor

        anchor.rect {
            x: -(battery.width / 2) - 10
            y: battery.height + 10
        }

        Rectangle {
            anchors.fill: parent
            color: AppState.defaultPopupBackground
            radius: AppState.defaultPopupRadius

            Text {
                id: popupText
                anchors.centerIn: parent
                color: AppState.defaultTextColor
            }
        }
    }
}
