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
                        var firstElement = appListView.itemAtIndex(0)
                        
                        if (firstElement) {                            
                            Quickshell.execDetached({
                                command: [firstElement.execc]
                            })

                            // cleaning input
                            searchInput.text = ""

                            // hide pannel
                            appLauncher.visible = false
                        }
                    }
                }                
            }
        }

        // items area
        Rectangle {
            id: itemsArea

            implicitWidth: AppState.launcherItemsWidth
            implicitHeight: AppState.launcherItemsHeight

            color: "black"

            anchors.top: parent.top
            anchors.topMargin: 60
            anchors.horizontalCenter: parent.horizontalCenter

            ListModel {
                id: appsModel
            }

            // display apps list
            ListView {
                id: appListView

                anchors.fill: parent
                model: nameFilterModel
                // model: appsModel
                delegate: appItem
                spacing: 10
                clip: true
            }
        }
    }

    // app in apps list
    Component {
        id: appItem
        
        Rectangle {
            property string namee: name
            property string execc: exec

            width: AppState.launcherItemWidth
            height: AppState.launcherItemHeight

            color: "black"

            Text {
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                text: name

                font.pixelSize: 16
                font.family: AppState.defaultFontFamily
                leftPadding: 10

                color: "white"
            }

            // make the first element of the app list grey.
            Component.onCompleted: {
                if (index === 0) {
                    color = "grey"
                }
            }
        }
    }

    // вводим в searchInput и фильтруем appsModel
    SortFilterProxyModel {
        id: nameFilterModel

        model: appsModel

        filters: [
            FunctionFilter {
                property string searchText: searchInput.text
      
                component RoleData: QtObject { 
                    property string name 
                }

                function filter(data: RoleData) : bool {
                    return data.name.toLowerCase().includes(searchText.toLowerCase())

                }

                onSearchTextChanged: invalidate()
            }
        ]
    }

    // Process to retrieve
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
                        { name: values[0], exec: values[1].split(" ")[0], icon: values[2] }
                    )
                }
            }
        }
    }

    // React on keyboard shortcut.
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
}
