import QtQuick
import QtQuick.Effects
import "./library"

Item {
    id: root

    required property real engineTemp

    property string colorPrimary: "#000000"
    property string colorAccent: "#0000FF"
    property string colorNeutral: "#FFFFFF"
    property string colorShadow: "#000000"
    property string colorOk: "#00FF00"
    property string colorWarning: "#FF0000"

    property real margin: 24
    property real maxEngineTempAngleRad: 270 * Math.PI / 180 - 15 * Math.PI / 180
    property real minEngineTempAngleRad: 160 * Math.PI / 180

    Guage {
        id: speedGuageBg
        width: root.width
        height: root.height
        dropShadow: true
        colorPrimary: root.colorPrimary
        colorAccent: root.colorAccent
        colorShadow: root.colorShadow
    }

    Canvas {
        id: engineTempOverlay
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            let engineTempContent = ["C", "", "H"];
            // Clear canvas
            ctx.clearRect(0, 0, width, height);

            // Set the style
            ctx.strokeStyle = colorAccent;
            ctx.shadowOffsetX = 1;
            ctx.shadowOffsetY = 1;
            ctx.shadowBlur = 10;
            ctx.shadowColor = colorShadow;

            // Draw 3 ticks COLD/NORMAL/HOT
            var centerX = parent.width / 2;
            var centerY = parent.height / 2;
            var radius = Math.min(centerX, centerY) - margin;
            ctx.lineWidth = 2;
            var divisions = 2;
            var divisionSize = Math.abs(maxEngineTempAngleRad - minEngineTempAngleRad) / divisions;
            for (var i = 0; i <= divisions; i++) {
                var angle = minEngineTempAngleRad + i * divisionSize;
                var startX = centerX + Math.cos(angle) * (radius - margin);
                var startY = centerY + Math.sin(angle) * (radius - margin);
                var endX = centerX + Math.cos(angle) * radius;
                var endY = centerY + Math.sin(angle) * radius;
                ctx.beginPath();
                ctx.moveTo(startX, startY);
                ctx.lineTo(endX, endY);
                ctx.stroke();

                // Draw cool/hot text
                var speedLabel = engineTempContent[i];
                var labelX = centerX + Math.cos(angle) * (radius - 2 * margin);
                var labelY = centerY + Math.sin(angle) * (radius - 2 * margin);
                ctx.fillStyle = colorNeutral;
                ctx.font = "24px Arial";
                ctx.fillText(speedLabel, labelX - margin + 10, labelY + margin / 2 - 10);
            }
            ctx.shadowOffsetX = 0;
            ctx.shadowOffsetY = 0;
            ctx.shadowBlur = 0;
            ctx.shadowColor = "transparent";

            // Low Engine Temperature
            ctx.beginPath();
            ctx.lineWidth = margin;
            ctx.strokeStyle = Qt.lighter(Qt.lighter(colorOk));
            ctx.arc(width / 2, height / 2, height / 2.76, minEngineTempAngleRad, minEngineTempAngleRad + Math.PI / 15);
            ctx.stroke();

            // High Engine Temperature
            ctx.beginPath();
            ctx.lineWidth = margin;
            ctx.strokeStyle = Qt.lighter(Qt.lighter(colorWarning));
            ctx.arc(width / 2, height / 2, height / 2.76, maxEngineTempAngleRad - Math.PI / 15, maxEngineTempAngleRad);
            ctx.stroke();
        }
    }

    // Draw the engine temperature needle indicator
    Needle {
        id: engineTempNeedle
        maxAngleRad: maxEngineTempAngleRad
        minAngleRad: minEngineTempAngleRad
        value: engineTemp
        width: parent.width
        height: parent.height
        shortenBy: 36
    }

    // Place engine temperature icon on guage center
    Item {
        width: parent.width / 5
        height: width
        anchors.centerIn: parent

        Image {
            id: engineTempImage
            width: parent.width
            height: parent.height
            anchors.centerIn: parent
            source: "../assets/images/engine_temp.png"
        }

        MultiEffect {
            id: engineTempImageDropShadow
            source: engineTempImage
            anchors.fill: engineTempImage
            shadowBlur: 0.8
            shadowColor: colorShadow
            shadowEnabled: true
        }
    }
}
