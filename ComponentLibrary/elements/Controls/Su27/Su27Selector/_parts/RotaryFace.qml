import QtQuick 2.15

Canvas {
    id: face
    objectName: "rotaryFace"
    property var labels: []
    property var angles: []
    property int labelEvery: 1
    property string handle: "arrow"
    property real visualAngle: 0
    property bool taperedScale: false
    property bool scaleMarks: true
    onLabelsChanged: requestPaint()
    onAnglesChanged: requestPaint()
    onLabelEveryChanged: requestPaint()
    onHandleChanged: requestPaint()
    onVisualAngleChanged: requestPaint()
    onTaperedScaleChanged: requestPaint()
    onScaleMarksChanged: requestPaint()
    onWidthChanged: requestPaint()
    onHeightChanged: requestPaint()
    onPaint: {
        var c = getContext("2d")
        c.reset()
        c.clearRect(0, 0, width, height)
        var s = Math.min(width, height) / 148
        c.translate(width / 2, height / 2)
        c.scale(s, s)
        c.strokeStyle = "#edece3"; c.fillStyle = "#edece3"; c.lineWidth = 1.6
        c.font = "bold 9px Arial"; c.textAlign = "center"; c.textBaseline = "middle"
        for (var i = 0; scaleMarks && i < angles.length; ++i) {
            var a = angles[i] * Math.PI / 180
            c.beginPath(); c.moveTo(Math.sin(a) * 46, -Math.cos(a) * 46)
            c.lineTo(Math.sin(a) * 52, -Math.cos(a) * 52); c.stroke()
            if (i % labelEvery === 0 || i === angles.length - 1) {
                var labelWidth = Math.abs(Math.sin(a)) > 0.7 ? 23 : 40
                var measuredWidth = c.measureText(labels[i]).width
                c.save()
                c.translate(Math.sin(a) * 63, -Math.cos(a) * 63)
                c.scale(Math.min(1, labelWidth / Math.max(1, measuredWidth)), 1)
                c.fillText(labels[i], 0, 0)
                c.restore()
            }
        }
        if (scaleMarks && taperedScale && angles.length > 1) {
            c.beginPath()
            for (var t = 0; t < 90; ++t) {
                var ta = (angles[0] + (angles[angles.length - 1] - angles[0]) * t / 89) * Math.PI / 180
                var outer = 49 + t / 18
                if (t === 0) c.moveTo(Math.sin(ta) * outer, -Math.cos(ta) * outer)
                else c.lineTo(Math.sin(ta) * outer, -Math.cos(ta) * outer)
            }
            for (var u = 89; u >= 0; --u) {
                var ua = (angles[0] + (angles[angles.length - 1] - angles[0]) * u / 89) * Math.PI / 180
                c.lineTo(Math.sin(ua) * 48, -Math.cos(ua) * 48)
            }
            c.closePath(); c.fill()
        }
        c.rotate(visualAngle * Math.PI / 180)
        if (handle === "screw") {
            var metal = c.createLinearGradient(-45, -45, 45, 45)
            metal.addColorStop(0, "#e0dfd4"); metal.addColorStop(0.45, "#a4aaa6"); metal.addColorStop(1, "#656f6e")
            c.beginPath(); c.arc(0, 0, 58, 0, Math.PI * 2)
            c.fillStyle = "#4b5655"; c.fill()
            c.lineWidth = 3; c.strokeStyle = "#aab4ad"; c.stroke()
            c.beginPath(); c.arc(0, 0, 51, 0, Math.PI * 2)
            c.fillStyle = metal; c.fill()
            c.lineWidth = 2; c.strokeStyle = "#d3d6ca"; c.stroke()
            c.fillStyle = "#26312f"; c.fillRect(-41, -5, 82, 10)
            c.strokeStyle = "#e1e2d7"; c.lineWidth = 1.5
            c.beginPath(); c.moveTo(-41, 6); c.lineTo(41, 6); c.stroke()
            return
        }
        c.lineWidth = 1.5; c.strokeStyle = "#888b88"
        var g = c.createLinearGradient(-27, -20, 28, 24)
        g.addColorStop(0, "#515650"); g.addColorStop(0.45, "#252925"); g.addColorStop(1, "#101310")
        c.fillStyle = g
        c.beginPath()
        if (handle === "bar") {
            c.arc(0, 0, 31, 0, Math.PI * 2); c.fill(); c.stroke()
            c.beginPath(); c.moveTo(-9, -35); c.lineTo(8, -35); c.lineTo(11, 33); c.lineTo(-11, 33); c.closePath()
        } else if (handle === "paddle") {
            c.moveTo(-13, 30); c.lineTo(-18, 2); c.lineTo(-12, -34); c.quadraticCurveTo(0, -42, 12, -34)
            c.lineTo(18, 2); c.lineTo(13, 30); c.closePath()
        } else if (handle === "diamond") {
            c.moveTo(0, -36); c.lineTo(19, 0); c.lineTo(0, 27); c.lineTo(-19, 0); c.closePath()
        } else if (handle === "fluted") {
            for (var j = 0; j < 48; ++j) {
                var f = j * Math.PI / 24, r = j % 2 ? 30 : 34
                if (j === 0) c.moveTo(Math.sin(f) * r, -Math.cos(f) * r)
                else c.lineTo(Math.sin(f) * r, -Math.cos(f) * r)
            }
            c.closePath()
        } else {
            c.moveTo(0, -39); c.quadraticCurveTo(8, -30, 13, -5); c.lineTo(12, 22)
            c.quadraticCurveTo(0, 29, -12, 22); c.lineTo(-13, -5); c.quadraticCurveTo(-8, -30, 0, -39); c.closePath()
        }
        c.fill(); c.stroke()
        c.strokeStyle = "#eeeee4"; c.lineWidth = 3.2; c.lineCap = "round"
        c.beginPath(); c.moveTo(0, 15); c.lineTo(0, -30); c.stroke()
    }
}
