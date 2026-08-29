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
}
