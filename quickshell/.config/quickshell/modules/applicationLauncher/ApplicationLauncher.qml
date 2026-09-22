// ApplicationLauncher.qml

import QtQuick
import QtQuick.Controls

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Wayland

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


    function launchCurrentApp() {
        const currentItem = appListView.currentItem
        
        if (!currentItem) {
            return
        }
        
        Quickshell.execDetached({
            command: currentItem.exec.split(" ")
        })

        searchInput.text = ""
        appLauncher.visible = false
        appListView.currentIndex = 0

        LauncherUtils.updateLaunchedAppsFile(
            jsonFile, 
            currentItem.name
        )

        desktopsProcess.running = true
    }


    function moveSelectionUp() {
        if (appListView.currentIndex > 0) {
            appListView.currentIndex-- 
        }
    }


    function moveSelectionDown() {
        if (appListView.currentIndex < appListView.count - 1) {
            appListView.currentIndex++
        }
    }


    Component.onCompleted: {
        appsModel.clear()
        launchedAppsFileProcess.running = true
    }

    // Application Launcher UI.
    Rectangle {
        anchors.centerIn: parent

        implicitWidth: AppState.launcherWidth
        implicitHeight: AppState.launcherHeight

        radius: AppState.launcherBorderRadius

        border.color: AppState.launcherBorderColor

        color: AppState.launcherBgColor

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
            color: AppState.launcherFontColor

            // TextField's background property can't accept color 
            // as value so I use Rectanlge with color.
            background: Rectangle { color: AppState.launcherBgColor }
            
            Keys.onPressed: (event) => {
                if (event.key === Qt.Key_Return) {
                    launchCurrentApp()
                } else if (event.key === Qt.Key_Up) {
                    moveSelectionUp()
                } else if (event.key === Qt.Key_Down) {
                    moveSelectionDown()
                }            
            }
        }

        // apps list area
        Rectangle {
            width: AppState.launcherItemsWidth
            height: AppState.launcherItemsHeight
            color: AppState.launcherBgColor

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
                delegate: ApplicationDelegate {}
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

    // модель для хранения данных приложений.
    ListModel { 
        id: appsModel    
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

    FileView {
        id: jsonFile

        path: launchedAppsFileProcess.filePath
        preload: false
        blockLoading: true
    }
 
    // Process to retrieve desktops details from OS.
    Process {
        id: desktopsProcess

        command: [Qt.resolvedUrl("./scripts/desktops.sh")]

        stdout: StdioCollector {
            onStreamFinished: {
                appsModel.clear()

                const appsArray = LauncherUtils.buildAppsArray(
                    this.text,
                    jsonFile
                )

                for (const app of appsArray) {
                    appsModel.append(app)
                }

            }
        }
    }

    // create/validate existing file to store recently launched apps.
    Process {
        id: launchedAppsFileProcess
        
        readonly property string filePath: LauncherUtils.convertToLocal(
            Qt.resolvedUrl("./data/launched_apps.json").toString()
        )
        
        command: ["touch", filePath]
        
        stdout: StdioCollector {
            onStreamFinished: {
                desktopsProcess.running = true
                console.log(`validate ${launchedAppsFileProcess.filePath}`)
            }
        }
    }
}
