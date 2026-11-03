import QtQuick 2.15
import common_qml 1.0

// 1RightBort.swf, btn_control (sprite #396).
MomentaryButton {
    id: root

    my_type: "Su27UBRightButtonSpoReceiveTest"
    my_subtype: "Su27UBRightButtonSpoReceiveTest"
    implicitWidth: 40.02
    implicitHeight: 40.02
    previewSource: "state_0.svg"

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
