import QtQuick 2.15
import QtQuick.Window 2.15

ControlState {
    id: root
    property bool held: false
    property rect hitRegion: Qt.rect(0, 0, 1, 1)
    function releaseFromUser() {
        if (!held) return
        held = false
        commitFromUser(0)
    }
    onAcceptsInputChanged: if (!acceptsInput) releaseFromUser()
    onVisibleChanged: if (!visible) releaseFromUser()
    Connections {
        target: root.Window.window
        function onActiveChanged() { if (!root.Window.window.active) root.releaseFromUser() }
    }
    MouseArea {
        x: root.width * root.hitRegion.x
        y: root.height * root.hitRegion.y
        width: root.width * root.hitRegion.width
        height: root.height * root.hitRegion.height
        enabled: root.acceptsInput
        preventStealing: true
        cursorShape: Qt.PointingHandCursor
        onPressed: { root.held = true; root.commitFromUser(1) }
        onReleased: root.releaseFromUser()
        onCanceled: root.releaseFromUser()
    }
}
