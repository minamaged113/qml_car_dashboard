import QtQuick
import QtQuick.Effects
import "./library"

Item {
    id: root
    required property real speedValue

    property string colorPrimary: "#000000"
    property string colorAccent: "#00FF00"
    property string colorNeutral: "#FFFFFF"
    property string colorShadow: "#000000"

    property real minSpeed: 0
    property real maxSpeed: 220
    property real speedIncrements: 20
    property real margin: 24
    // Start from angle 160 with speed minSpeed
    // End at agnle 380 with speed maxSpeed
    property real maxSpeedAngleRad: 380 * Math.PI / 180
    property real minSpeedAngleRad: 160 * Math.PI / 180

    // Draw guage background
    Guage {
        id: speedGuageBg
        width: root.width
        height: root.height
        dropShadow: true
        colorPrimary: root.colorPrimary
        colorAccent: root.colorAccent
        colorShadow: root.colorShadow
    }

    // Draw the speed numbers and dashes over
    // the previous guage
    Canvas {
        id: speedNumbersOverlay
        anchors.fill: root
        onPaint: {
            var ctx = getContext("2d");
            // Clear canvas
            ctx.clearRect(0, 0, width, height);

            // Set the style for the half circle
            ctx.strokeStyle = colorAccent;
            ctx.lineWidth = 10;

            // Dashes' shadows
            ctx.shadowOffsetX = 1;
            ctx.shadowOffsetY = 1;
            ctx.shadowBlur = 10;
            ctx.shadowColor = colorShadow;

            // Draw ticks for every 20 km/h
            var centerX = root.width / 2;
            var centerY = root.height / 2;
            var radius = Math.min(centerX, centerY) - margin;
            ctx.lineWidth = 2;
            var divisions = Math.abs(maxSpeed - minSpeed) / speedIncrements;
            var divisionSize = Math.abs(maxSpeedAngleRad - minSpeedAngleRad) / divisions;
            for (var i = 0; i <= divisions; i++) {
                var angle = minSpeedAngleRad + i * divisionSize;
                var startX = centerX + Math.cos(angle) * (radius - margin);
                var startY = centerY + Math.sin(angle) * (radius - margin);
                var endX = centerX + Math.cos(angle) * radius;
                var endY = centerY + Math.sin(angle) * radius;
                ctx.beginPath();
                ctx.moveTo(startX, startY);
                ctx.lineTo(endX, endY);
                ctx.stroke();

                // Draw speed label
                var speedLabel = i * 20;
                var labelX = centerX + Math.cos(angle) * (radius - 2 * margin);
                var labelY = centerY + Math.sin(angle) * (radius - 2 * margin);
                ctx.fillStyle = colorNeutral;
                ctx.font = "24px Arial";
                ctx.fillText(speedLabel, labelX - margin + 5, labelY + margin / 2 - 10);
            }
        }
        Needle {
            id: speedometerNeedle
            maxAngleRad: maxSpeedAngleRad
            minAngleRad: minSpeedAngleRad
            value: (speedValue - minSpeed) / (maxSpeed - minSpeed)
            width: root.width
            height: root.height
            shortenBy: 36
        }
    }
}
