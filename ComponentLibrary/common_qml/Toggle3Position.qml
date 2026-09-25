import QtQuick 2.15
import QtQuick.Window 2.15

ControlState {
    id: root
    maximumValue: 2
    property bool horizontal: false
    property bool returnToCenter: false
    property bool held: false
    function selectAt(x, y) {
        var fraction = horizontal ? x / width : 1 - y / height
        commitFromUser(Math.max(0, Math.min(2, Math.floor(fraction * 3))))
    }
    function releaseFromUser() {
        if (!held) return
        held = false
        if (returnToCenter) commitFromUser(1)
    }
    onAcceptsInputChanged: if (!acceptsInput) releaseFromUser()
    onVisibleChanged: if (!visible) releaseFromUser()
    Connections {
        target: root.Window.window
        function onActiveChanged() { if (!root.Window.window.active) root.releaseFromUser() }
    }
    MouseArea {
        anchors.fill: parent
        enabled: root.acceptsInput
        preventStealing: true
        cursorShape: Qt.PointingHandCursor
        onPressed: function(mouse) { root.held = true; root.selectAt(mouse.x, mouse.y) }
        onPositionChanged: function(mouse) { if (pressed && root.held) root.selectAt(mouse.x, mouse.y) }
        onReleased: root.releaseFromUser()
        onCanceled: root.releaseFromUser()
    }
}
