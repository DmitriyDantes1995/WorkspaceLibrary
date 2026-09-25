import QtQuick 2.15

ControlState {
    id: root
    discrete: false
    property real minimumAngle: 0
    property real maximumAngle: 360
    property real wheelStep: 0.05
    readonly property real visualAngle: minimumAngle + (value - minimumValue) / (maximumValue - minimumValue) * (maximumAngle - minimumAngle)
    MouseArea {
        anchors.fill: parent
        enabled: root.acceptsInput
        preventStealing: true
        cursorShape: Qt.SizeAllCursor
        property real previousAngle: 0
        function pointerAngle(x, y) { return Math.atan2(x - width / 2, height / 2 - y) * 180 / Math.PI }
        onPressed: function(mouse) { previousAngle = pointerAngle(mouse.x, mouse.y) }
        onPositionChanged: function(mouse) {
            if (!pressed) return
            var next = pointerAngle(mouse.x, mouse.y)
            var delta = ((next - previousAngle + 540) % 360) - 180
            previousAngle = next
            root.commitFromUser(root.value + delta / (root.maximumAngle - root.minimumAngle) * (root.maximumValue - root.minimumValue))
        }
        onWheel: function(wheel) {
            if (wheel.angleDelta.y !== 0) root.commitFromUser(root.value + (wheel.angleDelta.y > 0 ? root.wheelStep : -root.wheelStep))
        }
    }
}
