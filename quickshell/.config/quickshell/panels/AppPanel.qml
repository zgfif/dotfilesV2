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

        TextField {
            id: searchInput

            implicitWidth: AppState.launcherSearchWidth
            implicitHeight: AppState.launcherSearchHeight

            anchors { 
                top: parent.top
                topMargin: 10
                horizontalCenter: parent.horizontalCenter
            }

            focus: true

            font.pixelSize: AppState.launcherFontSize

            // the color of entered text.
            color: "white"

            // TextField's background property can't accept color 
            // as value so I use Rectanlge with color.
            background: Rectangle { color: "black" }
            
            Keys.onPressed: (event) => {
                if (event.key === Qt.Key_Return) {
                    var currentItem = appListView.currentItem
                    
                    if (currentItem) {
                        Quickshell.execDetached({
                            command: [currentItem.exec]
                        })
                        searchInput.text = ""
                        appLauncher.visible = false
                        appListView.currentIndex = 0
                    }
                } else if (event.key === Qt.Key_Up) {
                    if (appListView.currentIndex > 0) {
                        appListView.currentIndex-- 
                    }

                } else if (event.key === Qt.Key_Down) {
                    if (appListView.count > 0 && 
                        appListView.currentIndex < appListView.count - 1) {
                        appListView.currentIndex++
                    }

                }            
            }
        }

        // apps list area
        Rectangle {
            id: itemsArea

            width: AppState.launcherItemsWidth
            height: AppState.launcherItemsHeight

            color: "black"

            anchors { 
                top: parent.top
                topMargin: 60
                horizontalCenter: parent.horizontalCenter
            }

            // display apps list
            ListView {
                id: appListView

                anchors.fill: parent

                model: proxyModel

                currentIndex: 0

                spacing: 10
                clip: true

                delegate: appDelegate
            }
        }
    }

    // Process to retrieve apps details
    Process {
        id: desktopsProcess

        command: ["sh", "-c", "~/.config/quickshell/utils/apps_details.sh"]

         stdout: StdioCollector {
            onStreamFinished: {
                appsModel.clear()

                const output = this.text.trim()

                if (!output)
                    return

                const lines = output.split("\n")

                for (const line of lines) {
                    let values = line.split(" ___ ")

                    if (values.length < 3)
                        continue
                    
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
    ListModel { id: appsModel }

    Component {
        id: appDelegate
        
        Rectangle {
            required property string name
            required property string icon
            required property string exec

            property bool isCurrent: ListView.isCurrentItem

            width: AppState.launcherItemWidth
            height: AppState.launcherItemHeight

            color: isCurrent ? "grey" : "black"

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
                    pixelSize: 16
                    family: AppState.defaultFontFamily
                }

                color: "white"
                text: name
            }
        }
    }

    SortFilterProxyModel {
        id: proxyModel

        model: appsModel
        filters: [
             FunctionFilter {
                readonly property string searchText: searchInput.text.toLowerCase()

                component RoleData: QtObject { property string name }
                
                function filter(data: RoleData) : bool {
                    return (data.name.toLowerCase().includes(searchText))
                }

                onSearchTextChanged: {
                    invalidate()
                    appListView.currentIndex = 0
                }
            }
        ]
    }
}
