import QtQuick 2.15

ControlState {
    id: root
    function toggleFromUser() {
        if (acceptsInput) commitFromUser(currentState === 0 ? 1 : 0)
    }
    MouseArea {
        anchors.fill: parent
        enabled: root.acceptsInput
        cursorShape: Qt.PointingHandCursor
        onClicked: root.toggleFromUser()
    }
}
