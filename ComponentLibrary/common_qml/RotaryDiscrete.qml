import QtQuick 2.15

ControlState {
    id: root
    property var angles: [-120, -90, -60, -30, 0]
    maximumValue: Math.max(0, angles.length - 1)
    readonly property real visualAngle: angles[currentState] || 0
    function selectAt(x, y) {
        var dx = x - width / 2, dy = y - height / 2
        if (Math.sqrt(dx * dx + dy * dy) < Math.min(width, height) * 0.1) return
        var angle = Math.atan2(dx, -dy) * 180 / Math.PI
        var best = 0, distance = Infinity
        for (var i = 0; i < angles.length; ++i) {
            var delta = Math.abs(((angle - angles[i] + 540) % 360) - 180)
            if (delta < distance) { distance = delta; best = i }
        }
        commitFromUser(best)
    }
    MouseArea {
        anchors.fill: parent
        enabled: root.acceptsInput
        preventStealing: true
        cursorShape: Qt.PointingHandCursor
        onPressed: function(mouse) { root.selectAt(mouse.x, mouse.y) }
        onPositionChanged: function(mouse) { if (pressed) root.selectAt(mouse.x, mouse.y) }
        onWheel: function(wheel) {
            if (wheel.angleDelta.y !== 0) root.commitFromUser(root.value + (wheel.angleDelta.y > 0 ? 1 : -1))
        }
    }
}
