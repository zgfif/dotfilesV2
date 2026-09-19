// ApplicationLauncher.qml

import QtQuick
import QtQuick.Controls

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Widgets

import "../../app"
import "./application_launcher.js" as LauncherUtils

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

                        const appsFileText = jsonFile.text()

                        const appsData = appsFileText.length > 0 ? JSON.parse(appsFileText) : { apps: [] }
                        
                        const newData = LauncherUtils.updateAppsData(
                            appsData, 
                            currentItem.name
                        )

                        jsonFile.setData(JSON.stringify(newData))

                        desktopsProcess.running = true
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

    // React on keyboard shortcut defined in hyprland configuration.
    GlobalShortcut {
        name: "appLauncher"
        
        onPressed: {
            appLauncher.visible = !appLauncher.visible // toggle visibility of the App launcher.
        }
    }

    Component.onCompleted: {
        // performs after start up the whole quickshell.
        appsModel.clear()
        desktopsProcess.running = true
        lauchedAppsFileProcess.running = true
    }

    // модель для хранения данных приложений.
    ListModel { id: appsModel }

    // component used to show one app in app launcher.
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
        
        // readonly property var appsCounts: JSON.parse(jsonFile.text())

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

    FileView {
        id: jsonFile

        path: lauchedAppsFileProcess.filePath

        blockLoading: true
    }
 
    // Process to retrieve desktops details from OS.
    Process {
        id: desktopsProcess

        command: [
            "sh", 
            "-c", 
            "~/.config/quickshell/modules/applicationLauncher/scripts/desktops.sh"
        ]

         stdout: StdioCollector {
            onStreamFinished: {
                appsModel.clear()
                
                const launchedArray = jsonFile.text().length > 0 ? JSON.parse(jsonFile.text()) : { apps: [] }

                const modifiedArray = LauncherUtils.buildDesktopsArray(this.text, launchedArray)

                for (const desktop of modifiedArray) {
                    appsModel.append(desktop)
                }
            }
        }
    }

    // create/validate existing file to store recently launched apps.
    Process {
        id: lauchedAppsFileProcess

        readonly property string filePath: "/home/pasha/.config/quickshell/modules/applicationLauncher/data/launched_apps.json"
        
        command: ["touch", filePath]
        
        stdout: StdioCollector {
            onStreamFinished: {
                console.log(`validate ${lauchedAppsFileProcess.filePath}`)
            }
        }
    }
}
