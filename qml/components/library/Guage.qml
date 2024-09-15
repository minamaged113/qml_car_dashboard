import QtQuick
import QtQuick.Effects

Item {
    id: root

    property alias dropShadow: root.allDropShadowVisible
    property string colorPrimary: "#000000"
    property string colorAccent: "#FFFFFF"
    property string colorShadow: "#000000"

    property bool allDropShadowVisible: true
    property real margin: 24

    Rectangle {
        id: speedometerOuterCircle
        color: colorPrimary
        width: root.width
        height: root.height
        radius: root.width
    }

    MultiEffect {
        id: speedometerOuterCircleDropShadow
        source: speedometerOuterCircle
        anchors.fill: speedometerOuterCircle
        shadowBlur: 0.8
        shadowColor: colorShadow
        shadowEnabled: true
        visible: allDropShadowVisible
    }

    Rectangle {
        id: speedometerAccent
        color: colorAccent
        anchors.centerIn: parent
        width: root.width - margin
        height: root.width - margin
        radius: root.width - margin
    }

    MultiEffect {
        id: speedometerAccentDropShadow
        source: speedometerAccent
        anchors.fill: speedometerAccent
        shadowBlur: 0.8
        shadowColor: colorShadow
        shadowEnabled: true
        visible: allDropShadowVisible
    }

    Rectangle {
        id: speedometerInner
        color: colorPrimary
        anchors.centerIn: parent
        width: root.width - 2 * margin
        height: root.width - 2 * margin
        radius: root.width - 2 * margin
    }

    MultiEffect {
        id: speedometerInnerDropShadow
        source: speedometerInner
        anchors.fill: speedometerInner
        shadowBlur: 0.8
        shadowColor: colorShadow
        shadowEnabled: true
        visible: allDropShadowVisible
    }
}
