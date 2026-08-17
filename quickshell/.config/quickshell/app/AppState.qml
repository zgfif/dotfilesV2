pragma Singleton

import QtQuick

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

    // hardware parameters:
    property string defaultBatteryName: "BAT1"
}
