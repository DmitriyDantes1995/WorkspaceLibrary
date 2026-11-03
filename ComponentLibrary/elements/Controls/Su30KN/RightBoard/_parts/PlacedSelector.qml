pragma ComponentBehavior: Bound

import QtQuick 2.15
import common_qml 1.0

RotaryDiscrete {
    id: root

    required property url bodySource
    required property var bodyPlacement
    required property var regions

    inputCenterX: width * (bodyPlacement[0] + bodyPlacement[2] / 2)
    inputCenterY: height * (bodyPlacement[1] + bodyPlacement[3] / 2)

    AdaptiveSvgImage {
        x: root.width * root.bodyPlacement[0]
        y: root.height * root.bodyPlacement[1]
        width: root.width * root.bodyPlacement[2]
        height: root.height * root.bodyPlacement[3]
        source: root.bodySource
        fillMode: Image.Stretch
        rotation: root.visualAngle
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
            onWheel: function(wheel) {
                if (wheel.angleDelta.y !== 0)
                    root.stepFromUser(wheel.angleDelta.y > 0 ? 1 : -1)
            }
        }
    }
}
