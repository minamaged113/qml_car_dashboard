import QtQuick
import QtQuick.Effects

Item {
    id: root

    property alias dropShadow: root.allDropShadowVisible
    property string colorPrimary
    property string colorAccent
    property string colorNeutral
    property string colorShadow

    property bool allDropShadowVisible: true
    property real margin: 24

    Rectangle {
        id: speedometerOuterCircle
        color: colorPrimary
        width: parent.width
        height: parent.height
        radius: parent.width
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
        width: parent.width - margin
        height: parent.width - margin
        radius: parent.width - margin
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
        width: parent.width - 2 * margin
        height: parent.width - 2 * margin
        radius: parent.width - 2 * margin
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
