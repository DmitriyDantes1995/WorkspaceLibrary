import QtQuick 2.15

Canvas {
    objectName: "rotaryHandle"
    property string handle: "arrow"
    onHandleChanged: requestPaint()
    onWidthChanged: requestPaint()
    onHeightChanged: requestPaint()

    onPaint: {
        var c = getContext("2d")
        c.reset()
        c.clearRect(0, 0, width, height)
        c.translate(width / 2, height / 2)
        var scale = Math.min(width, height) / 148
        c.scale(scale, scale)
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
