import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #332. Instances: tbl_rs_1, tbl_rs_2.
Toggle2Position {
    id: root
    my_type: "Su30KNLeftSwitchRs2"
    my_subtype: "Su30KNLeftSwitchRs2"
    implicitWidth: 11.3
    implicitHeight: 35.3
    previewSource: "state_0.svg"

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
