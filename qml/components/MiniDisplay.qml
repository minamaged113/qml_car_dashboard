import QtQuick
import QtQuick.Effects

Item {
    id: root

    required property real speedValue
    required property real odometerReading

    property int margin: 24
    property string colorPrimary: "#000000"
    property string colorSecondary: "#FFFFFF"
    property string colorShadow: "#FFFFFF"
    property bool dropShadow: true

    // Draw mini display background
    Rectangle {
        id: miniDisplay
        color: Qt.darker(colorPrimary)
        anchors {
            bottom: root.bottom
            horizontalCenter: root.horizontalCenter
        }
        width: root.width
        height: root.height
        radius: margin
    }

    MultiEffect {
        id: miniDisplayDropShadow
        source: miniDisplay
        anchors.fill: miniDisplay
        shadowBlur: 0.8
        shadowColor: colorSecondary
        shadowEnabled: true
        visible: dropShadow
    }

    // Display current speed as text
    Text {
        id: currentSpeed
        text: Math.round(speedValue) + " kmph"
        font.pixelSize: 32
        color: colorSecondary
        anchors {
            top: miniDisplay.top
            horizontalCenter: parent.horizontalCenter
            topMargin: margin
        }
    }

    MultiEffect {
        id: currentSpeedDropShadow
        source: currentSpeed
        anchors.fill: currentSpeed
        shadowBlur: 0.8
        shadowColor: colorShadow
        shadowEnabled: true
        visible: dropShadow
    }

    // Display current odometer reading as text
    Text {
        id: currentOdometerReading
        text: Math.round(odometerReading) + " km"
        font.pixelSize: 24
        color: colorWhite
        anchors.centerIn: parent
    }
    MultiEffect {
        id: currentOdometerReadingDropShadow
        source: currentOdometerReading
        anchors.fill: currentOdometerReading
        shadowBlur: 0.8
        shadowColor: colorShadow
        shadowEnabled: true
        visible: dropShadow
    }
}
