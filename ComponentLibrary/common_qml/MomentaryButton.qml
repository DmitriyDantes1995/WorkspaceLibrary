import QtQuick 2.15
import QtQuick.Window 2.15

ControlState {
    id: root
    property bool held: false
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
        anchors.fill: parent
        enabled: root.acceptsInput
        preventStealing: true
        cursorShape: Qt.PointingHandCursor
        onPressed: { root.held = true; root.commitFromUser(1) }
        onReleased: root.releaseFromUser()
        onCanceled: root.releaseFromUser()
    }
}
