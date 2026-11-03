import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #251. Instances: tbl_eng_ub, tbl_vhf1.
Toggle2Position {
    id: root
    my_type: "Su30KNLeftSwitchEngUb"
    my_subtype: "Su30KNLeftSwitchEngUb"
    implicitWidth: 79.51283
    implicitHeight: 80.5768
    previewSource: "state_0.svg"

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
