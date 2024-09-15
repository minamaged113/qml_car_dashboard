import QtQuick
import QtQuick.Effects
import "./library"

Item {
    id: root

    // A value between 0 and 1
    // 1 being full
    // 0 being empty
    required property real fuelValue

    property string colorPrimary: "#000000"
    property string colorAccent: "#0000FF"
    property string colorNeutral: "#FFFFFF"
    property string colorShadow: "#000000"
    property string colorOk: "#00FF00"
    property string colorWarning: "#FF0000"

    property bool dropShadow: true
    property real margin: 24
    property real maxFuelAngleRad: 270 * Math.PI / 180 + 15 * Math.PI / 180
    property real minFuelAngleRad: 2 * Math.PI + 45 * Math.PI / 180 - 15 * Math.PI / 180

    Guage {
        id: fuelGuageBg
        width: parent.width
        height: parent.height
        dropShadow: true
        colorPrimary: root.colorPrimary
        colorAccent: root.colorAccent
        colorShadow: root.colorShadow
    }

    Canvas {
        id: fuelGuageOverlay
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            let engineTempContent = ["1", "", "0"];
            var fuel = fuelValue;
            // Clear canvas
            ctx.clearRect(0, 0, width, height);

            // Set the style
            ctx.strokeStyle = colorAccent;

            // add shadow
            ctx.shadowOffsetX = 1;
            ctx.shadowOffsetY = 1;
            ctx.shadowBlur = 10;
            ctx.shadowColor = colorShadow;

            // Draw 3 ticks EMPTY/HALF/FULL
            var centerX = parent.width / 2;
            var centerY = parent.height / 2;
            var radius = Math.min(centerX, centerY) - margin;
            ctx.lineWidth = 2;
            var divisions = 2;
            var divisionSize = Math.abs(maxFuelAngleRad - minFuelAngleRad) / divisions;
            for (var i = 0; i <= divisions; i++) {
                var angle = maxFuelAngleRad + i * divisionSize;
                var startX = centerX + Math.cos(angle) * (radius - margin);
                var startY = centerY + Math.sin(angle) * (radius - margin);
                var endX = centerX + Math.cos(angle) * radius;
                var endY = centerY + Math.sin(angle) * radius;
                ctx.beginPath();
                ctx.moveTo(startX, startY);
                ctx.lineTo(endX, endY);
                ctx.stroke();

                // Draw fuel label
                var speedLabel = engineTempContent[i];
                var labelX = centerX + Math.cos(angle) * (radius - 2 * margin);
                var labelY = centerY + Math.sin(angle) * (radius - 2 * margin);
                ctx.fillStyle = colorNeutral;
                ctx.font = "24px Arial";
                ctx.fillText(speedLabel, labelX - margin + 25, labelY + margin / 2 - 8);
            }

            // Remove shadow
            ctx.shadowOffsetX = 0;
            ctx.shadowOffsetY = 0;
            ctx.shadowBlur = 0;
            ctx.shadowColor = "transparent";

            // Low fuel indicator
            ctx.beginPath();
            ctx.lineWidth = margin;
            ctx.strokeStyle = Qt.lighter(Qt.lighter(colorWarning));
            ctx.arc(width / 2, height / 2, height / 2.76, minFuelAngleRad - Math.PI / 15, minFuelAngleRad);
            ctx.stroke();

            // High fuel indicator
            ctx.beginPath();
            ctx.lineWidth = margin;
            ctx.strokeStyle = Qt.lighter(Qt.lighter(colorOk));
            ctx.arc(width / 2, height / 2, height / 2.76, maxFuelAngleRad, maxFuelAngleRad + Math.PI / 15);
            ctx.stroke();
        }
    }

    // Draw needle indicator
    Needle {
        id: fuelGuageNeedle
        maxAngleRad: maxFuelAngleRad
        minAngleRad: minFuelAngleRad
        value: fuelValue
        reverse: true
        width: root.width
        height: root.height
        shortenBy: 36
    }

    // Add fuel icon over guage
    Item {
        width: root.width / 5
        height: width
        anchors.centerIn: parent

        Image {
            id: fuelGuageImage
            width: parent.width
            height: parent.height
            anchors.centerIn: parent
            source: "../assets/images/fuel_icon.png"
        }

        MultiEffect {
            id: fuelGuageImageDropShadow
            source: fuelGuageImage
            anchors.fill: fuelGuageImage
            shadowBlur: 0.8
            shadowColor: colorShadow
            shadowEnabled: true
            visible: dropShadow
        }
    }
}
