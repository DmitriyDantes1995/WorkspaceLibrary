import QtQuick 2.15

ControlState {
    id: root
    property var angles: [-120, -90, -60, -30, 0]
    property real inputCenterX: width / 2
    property real inputCenterY: height / 2
    maximumValue: minimumValue + Math.max(0, angles.length - 1)
    readonly property real visualAngle: root.angles[Math.max(0, Math.min(root.angles.length - 1, root.value - root.minimumValue))] || 0
    function selectAt(x, y) {
        var dx = x - inputCenterX, dy = y - inputCenterY
        if (Math.sqrt(dx * dx + dy * dy) < Math.min(width, height) * 0.1) return
        var angle = Math.atan2(dx, -dy) * 180 / Math.PI
        var best = 0, distance = Infinity
        for (var i = 0; i < angles.length; ++i) {
            var delta = Math.abs(((angle - angles[i] + 540) % 360) - 180)
            if (delta < distance) { distance = delta; best = i }
        }
        commitFromUser(minimumValue + best)
    }
    function stepFromUser(direction) {
        // Hardware codes need not follow the physical clockwise detent order.
        var order = []
        for (var i = 0; i < angles.length; ++i) order.push(i)
        order.sort(function(a, b) { return root.angles[a] - root.angles[b] })
        var position = order.indexOf(value - minimumValue)
        var next = Math.max(0, Math.min(order.length - 1, position + direction))
        if (order.length > 0) commitFromUser(minimumValue + order[next])
    }
    MouseArea {
        anchors.fill: parent
        enabled: root.acceptsInput
        preventStealing: true
        cursorShape: Qt.PointingHandCursor
        onPressed: function(mouse) { root.selectAt(mouse.x, mouse.y) }
        onPositionChanged: function(mouse) { if (pressed) root.selectAt(mouse.x, mouse.y) }
        onWheel: function(wheel) {
            if (wheel.angleDelta.y !== 0) root.stepFromUser(wheel.angleDelta.y > 0 ? 1 : -1)
        }
    }
}
