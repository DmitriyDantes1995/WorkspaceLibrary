pragma ComponentBehavior: Bound

import QtQuick 2.15
import common_qml 1.0

ControlState {
    id: root

    required property url assetDirectory
    required property var regions
    previewSource: Qt.resolvedUrl(assetDirectory + "state_0.svg")

    AdaptiveSvgImage {
        anchors.fill: parent
        source: root.assetDirectory + "state_" + root.currentState + ".svg"
        fillMode: Image.Stretch
    }

    Repeater {
        model: root.regions

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
