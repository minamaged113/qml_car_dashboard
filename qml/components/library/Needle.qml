import QtQuick

// Draw a needles for normalized values
Item {
    id: root

    required property real maxAngleRad
    required property real minAngleRad
    required property real value

    property string colorPrimary: "#FFFFFF"
    property string colorShadow: "#000000"

    property int needleWidth: 10
    property bool dropShadow: true
    property int margin: 24
    property int shortenBy: 0
    property bool reverse: false

    Canvas {
        id: needle
        anchors.fill: root
        onPaint: {
            var ctx = getContext("2d");
            // Clear canvas
            ctx.clearRect(0, 0, width, height);

            // Set the style
            ctx.strokeStyle = colorPrimary;
            ctx.lineWidth = needleWidth;

            // Needle drop shadow
            if (dropShadow) {
                ctx.shadowOffsetX = 1;
                ctx.shadowOffsetY = 1;
                ctx.shadowBlur = 10;
                ctx.shadowColor = colorShadow;
            }

            // Draw needle from center
            var centerX = root.width / 2;
            var centerY = root.height / 2;
            var radius = Math.min(centerX, centerY);

            var needleAngle;
            if (reverse) {
                needleAngle = maxAngleRad + (1 - value) * Math.abs(maxAngleRad - minAngleRad);
            } else {
                needleAngle = minAngleRad + value * (maxAngleRad - minAngleRad);
            }
            var needleStartX = centerX + margin * Math.cos(needleAngle);
            var needleStartY = centerY + margin * Math.sin(needleAngle);
            var needleEndX = centerX + (radius - shortenBy)* Math.cos(needleAngle);
            var needleEndY = centerY + (radius - shortenBy)* Math.sin(needleAngle);
            ctx.beginPath();
            ctx.lineCap = "round";
            ctx.strokeStyle = colorPrimary;
            ctx.moveTo(needleStartX, needleStartY);
            ctx.lineTo(needleEndX, needleEndY);
            ctx.stroke();
        }
    }
    onValueChanged: needle.requestPaint()
}
