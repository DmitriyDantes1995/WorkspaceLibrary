import QtQuick 2.15
import "../../../../../common_qml/CockpitTranslations.js" as Translations

Canvas {
    id: face
    objectName: "rotaryFace"
    property var labels: []
    readonly property var displayedLabels: labels.map(function(label) {
        return typeof label === "string" ? label : Translations.forLanguage(label, Qt.uiLanguage, label.ru)
    })
    property var angles: []
    property int labelEvery: 1
    property bool taperedScale: false
    property bool scaleMarks: true
    onDisplayedLabelsChanged: requestPaint()
    onAnglesChanged: requestPaint()
    onLabelEveryChanged: requestPaint()
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
                var label = displayedLabels[i] || ""
                var labelWidth = Math.abs(Math.sin(a)) > 0.7 ? 23 : 40
                var measuredWidth = c.measureText(label).width
                c.save()
                c.translate(Math.sin(a) * 63, -Math.cos(a) * 63)
                c.scale(Math.min(1, labelWidth / Math.max(1, measuredWidth)), 1)
                c.fillText(label, 0, 0)
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
    }

}
