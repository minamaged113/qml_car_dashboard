import QtQuick
import QtQuick.Effects

Item {
    id: root

    property string colorPrimary: "#FFFFFF"
    property string colorSecondary: "#000000"
    property string colorAccent: "#00AA00"
    property bool dropShadow: true

    Rectangle {
        id: footerRectangle
        color: colorPrimary
        width: root.width
        height: root.height
        anchors {
            bottom: root.bottom
            horizontalCenter: root.horizontalCenter
        }
    }

    MultiEffect {
        id: footerRectangleDropShadow
        source: footerRectangle
        anchors.fill: footerRectangle
        shadowBlur: 0.8
        shadowColor: colorSecondary
        shadowEnabled: true
        visible: dropShadow
    }
}
