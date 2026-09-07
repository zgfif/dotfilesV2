// AppState.qml

pragma Singleton

import QtQuick

import "Colors.qml"

QtObject {
    // Common parameters:
    property string defaultTextColor: "white"
    property string defaultBackgroundColor: "transparent"
    
    // PopupWindow parameters:
    property string defaultPopupBackground: "black"
    property int defaultPopupRadius: 10

    // Datetime parameters:
    property string timeFormat: "hh:mm"
    property string dateFormat: "dddd dd \nMMM yyyy"

    // Font parameters:
    property int defaultFontSize: 12
    property bool defaultFontBold: true
    property string defaultFontFamily: "Arial"

    // Notifications
    property string notificationBorderColor: Colors.md3.primary
    property string notificationBackground: "#1E1F25"
    property string notificationFontColor: "white"
    property int notificationFontSize: 15

    // Application launcher
    property int launcherFontSize: 16
    property int launcherWidth: 300
    property int launcherHeight: 400
    
    property string launcherBorderColor: Colors.md3.primary
    property int launcherBorderRadius: 10
    
    property int launcherSearchWidth: 280
    property int launcherSearchHeight: 40

    property int launcherItemsWidth: 280
    property int launcherItemsHeight: 300

    property int launcherItemWidth: 280
    property int launcherItemHeight: 50

    property string selectedApp: "#242424"
}
