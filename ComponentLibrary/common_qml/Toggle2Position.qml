pragma ComponentBehavior: Bound
import QtQuick 2.15

ControlState {
    id: root
    property var positionRegions: []

    function toggleFromUser() {
        if (acceptsInput) commitFromUser(currentState === 0 ? 1 : 0)
    }
    MouseArea {
        anchors.fill: parent
        enabled: root.acceptsInput && root.positionRegions.length === 0
        cursorShape: Qt.PointingHandCursor
        onClicked: root.toggleFromUser()
    }

    Repeater {
        model: root.positionRegions
        MouseArea {
            required property int index
            required property var modelData

            x: modelData[0] * root.width
            y: modelData[1] * root.height
            width: modelData[2] * root.width
            height: modelData[3] * root.height
            enabled: root.acceptsInput
            cursorShape: Qt.PointingHandCursor
            onPressed: root.commitFromUser(index)
        }
    }
}
