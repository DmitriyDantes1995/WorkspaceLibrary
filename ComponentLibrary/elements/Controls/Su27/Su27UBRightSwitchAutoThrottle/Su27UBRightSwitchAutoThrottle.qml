import QtQuick 2.15
import common_qml 1.0

// 1RightBortR.swf, tbl_auto_dross_ab (sprite #87).
Toggle2Position {
    id: root

    my_type: "Su27UBRightSwitchAutoThrottle"
    my_subtype: "Su27UBRightSwitchAutoThrottle"
    implicitWidth: 99.6
    implicitHeight: 29.06
    previewSource: "state_0.svg"

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
