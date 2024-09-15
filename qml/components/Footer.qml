import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Dialogs

// Custom library items
import "./library"

// Backend items
import CsvHandler 1.0

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

    RowLayout{
        anchors.centerIn: footerRectangle
        FileDialog {
            id: fileDialog
            title: "Select a File"
            currentFolder: "Documents"
            nameFilters: ["Comma-Separated Values (*.csv)"]
            onAccepted: {
                console.log("Selected file:", selectedFile)
                CsvHandler.openFile(selectedFile)
            }
            options: {
                FileDialog.ReadOnly
            }
        }

        CustomBtn {
            id: openFileBtn
            width: 150
            height: 60
            radius: 5
            colorPrimary: root.colorAccent
            colorSecondary: root.colorSecondary
            text: "Open File"
            onClicked: {
                fileDialog.open()
            }
        }

        CustomBtn {
            id: startBtn
            width: 150
            height: 60
            radius: 5
            colorPrimary: (CsvHandler.goodFile) ? root.colorAccent : "#D3D3D3"
            colorSecondary: (CsvHandler.goodFile) ? root.colorSecondary : "#000000"
            text: "Start"
            onClicked: (CsvHandler.goodFile) ? CsvHandler.getSpeed() : console.log("Cannot start. No file available.")
        }

    }
}
