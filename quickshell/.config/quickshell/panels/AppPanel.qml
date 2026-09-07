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

        // search input.
        Rectangle {
            implicitWidth: AppState.launcherSearchWidth
            implicitHeight: AppState.launcherSearchHeight

            anchors.top: parent.top
            anchors.topMargin: 10

            anchors.horizontalCenter: parent.horizontalCenter

            color: "white"

            TextField {
                id: searchInput
                focus: true
                placeholderText: "Search..."
            }
        }

        // items area
        Rectangle {
            id: itemsArea

            implicitWidth: AppState.launcherItemsWidth
            implicitHeight: AppState.launcherItemsHeight

            color: "blue"

            anchors.top: parent.top
            anchors.topMargin: 60
            anchors.horizontalCenter: parent.horizontalCenter

            ListModel {
                id: appsModel

                ListElement { name: "Firefox"; exec: "firefox" }
                ListElement { name: "Neovim"; exec: "nvim" }
                ListElement { name: "Obsidian"; exec: "obsidian" }
                ListElement { name: "Telegram"; exec: "Telegram" }
            }

            // display apps list
            ListView {
                anchors.fill: parent
                model: nameFilterModel
                delegate: appItem
                spacing: 10
            }
        }
    }
    
    // app in apps list
    Component {
        id: appItem
        
        Rectangle {
            width: AppState.launcherItemWidth
            height: AppState.launcherItemHeight

            color: "red"

            Text {
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                text: name 

                font.pixelSize: 16
                leftPadding: 10
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

                onSearchTextChanged: {
                    invalidate()
                }
            }
        ]
    }
    
    // React on keyboard shortcut.
    GlobalShortcut {
        name: "appLauncher"
        
        onPressed: {
            appLauncher.visible = !appLauncher.visible // toggle visibility of the App launcher.
        }
    }
}
