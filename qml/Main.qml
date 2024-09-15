import QtQuick

Window {
    id: root
    // Assuming the user is using iPad 12.9" as a car infotainment system
    width: 1366
    height: 1024

    // Window unresizeable
    maximumHeight: height
    maximumWidth: width
    minimumHeight: height
    minimumWidth: width

    // Main window properties
    visible: true
    color: "black"
    title: qsTr("Car Infotainment Simulator")

    // Application section
    property string colorWhite: "#FFFFFF"
    property string colorBlack: "#000000"
    property string colorLemon: "#DBEB00"
    property string colorMoss: "#373F26"
    property string colorNeon: "#7ff185"
    property string colorMidnight: "#231485"
    property string colorBurgundy: "#560c2d"

    property real margin: 24
    property real minSpeed: 0
    property real maxSpeed: 220
    property real fuel: 0.67 // Current vehicle fuel
    property real engineTemperature: 0.44 // Current engine temperature
    property real currentOdometerReadingValue: 110394 // Current odometer reading
}
