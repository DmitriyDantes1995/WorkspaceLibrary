import QtQuick 2.15
import common_qml 1.0

// 1RightBort.swf, btn_cntrwork (sprite #365).
MomentaryButton {
    id: root

    my_type: "Su27UBRightButtonPnkMode"
    my_subtype: "Su27UBRightButtonPnkMode"
    implicitWidth: 51.65
    implicitHeight: 51.49
    previewSource: "state_0.svg"

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
