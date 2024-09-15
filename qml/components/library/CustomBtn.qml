import QtQuick
import QtQuick.Effects

// Custom button to unify style and ease maintainability
Item {
    id: root

    property string colorPrimary: "#FFFFFF"
    property string colorSecondary: "#000000"
    property string colorShadow: "#000000"
    property bool dropShadow: true
    property int radius: 5
    property string text: "Button"

    signal clicked

    Rectangle {
        id: openFileBtn
        color: colorPrimary
        width: root.width
        height: root.height
        radius: root.radius

        Text {
            id: buttonText
            anchors.centerIn: parent
            text: root.text
            color: colorSecondary
            font.bold: true
        }

        MouseArea {
            id: customBtnClickableArea
            anchors.fill: openFileBtn
            onClicked: {
                root.clicked();
            }
        }
    }

    // Drop shadow
    MultiEffect {
        id: openFileBtnDropShadow
        source: openFileBtn
        anchors.fill: openFileBtn
        shadowBlur: 0.8
        shadowColor: colorShadow
        shadowEnabled: true
        visible: dropShadow
    }
}
