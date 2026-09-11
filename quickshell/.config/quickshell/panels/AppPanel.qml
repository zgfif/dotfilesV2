// AppPanel.qml

import QtQuick
import QtQuick.Controls

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Widgets

import "../app"

PanelWindow {
    id: appLauncher
    
    // make the panel full screen to prevent from loosing focus.
    anchors {
        top: true
        right: true
        bottom: true
        left: true
    }

    color: "transparent"

    visible: false
    focusable: true

    // visible Application Launcher window.
    Rectangle {
        anchors.centerIn: parent

        implicitWidth: AppState.launcherWidth
        implicitHeight: AppState.launcherHeight

        radius: AppState.launcherBorderRadius

        border.color: AppState.launcherBorderColor

        color: "black"

        // search input.
        Rectangle {
            implicitWidth: AppState.launcherSearchWidth
            implicitHeight: AppState.launcherSearchHeight

            anchors.top: parent.top
            anchors.topMargin: 10

            anchors.horizontalCenter: parent.horizontalCenter

            color: "black"

            TextField {
                id: searchInput
                anchors.fill: parent
                focus: true

                font.pixelSize: AppState.launcherFontSize

                // the color of entered text.
                color: "white"

                // background of the text field we use rectangle with color.
                background: Rectangle {
                    color: "black"
                }
                
                placeholderText: "Search..."
                
                Keys.onPressed: (event) => {
                    if (event.key === Qt.Key_Return) {
                        var currentItem = appListView.currentItem
                        
                        if (currentItem) {
                            Quickshell.execDetached({
                                command: [currentItem.exec]
                            })

                            // cleaning search input
                            searchInput.text = ""

                            // hide pannel
                            appLauncher.visible = false
                            
                            // reset index
                            appListView.currentIndex = 0
                        }
                    }

                    if (event.key === Qt.Key_Up) {
                        if (appListView.currentIndex > 0) {
                            appListView.currentIndex-- 
                        }
                    }

                    if (event.key === Qt.Key_Down) {
                        if ((appListView.count > 0) && (appListView.currentIndex < appListView.count - 1)) {
                            appListView.currentIndex++
                        }
                    }
                }                
            }
        }

        // apps list area
        Rectangle {
            id: itemsArea

            implicitWidth: AppState.launcherItemsWidth
            implicitHeight: AppState.launcherItemsHeight

            color: "black"

            anchors.top: parent.top
            anchors.topMargin: 60
            anchors.horizontalCenter: parent.horizontalCenter

            // display apps list
            ListView {
                id: appListView

                anchors.fill: parent

                model: proxyModel

                currentIndex: 0

                spacing: 10
                clip: true

                delegate: appRectangle
            }
        }
    }

    // Process to retrieve apps details
    Process {
        id: desktopsProcess

        running: false

        command: ["sh", "-c", "~/.config/quickshell/utils/apps_details.sh"]

         stdout: StdioCollector {
            onStreamFinished: {
                appsModel.clear()

                const lines = this.text.trim().split("\n")
                for (let line of lines) {
                    let values = line.split(" ___ ")
                    
                    appsModel.append(
                        { 
                            name: values[0], 
                            exec: values[1].split(" ")[0], 
                            icon: values[2]
                        }
                    )
                }
            }
        }
    }
    
    // React on keyboard shortcut defined in hyprland configuration.
    GlobalShortcut {
        name: "appLauncher"
        
        onPressed: {
            appLauncher.visible = !appLauncher.visible // toggle visibility of the App launcher.
        }
    }

    Component.onCompleted: {
        // load the apps details after start up the quickshell
        appsModel.clear()
        desktopsProcess.running = true
    }

    // модель для хранения данных приложений.
    ListModel {
        id: appsModel
    }

    Component {
        id: appRectangle
        
        Rectangle {
            required property string name
            required property string icon
            required property string exec

            property bool isCurrent: ListView.isCurrentItem

            width: AppState.launcherItemWidth
            height: AppState.launcherItemHeight

            color: isCurrent ? "grey" : "black"

            // Rectangle for app icon
            Rectangle {
                implicitWidth: 50
                implicitHeight: parent.height

                color: isCurrent ? "grey" : "black"

                IconImage {
                    anchors.centerIn: parent
                    
                    width: 30
                    height: 30
                    
                    source: Quickshell.iconPath(icon)
                }
            }

                // Text for app name
            Text {
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                text: name

                font.pixelSize: 16
                font.family: AppState.defaultFontFamily
                leftPadding: 60

                color: "white"
            }
        }
    }

    SortFilterProxyModel {
        id: proxyModel

        model: appsModel
        filters: [
             FunctionFilter {
                readonly property string text: searchInput.text.toLowerCase()

                component RoleData: QtObject { property string name }
                
                function filter(data: RoleData) : bool {
                    return (data.name.toLowerCase().includes(text))
                }

                onTextChanged: {
                    invalidate()
                    appListView.currentIndex = 0
                }
            }
        ]
    }
}
