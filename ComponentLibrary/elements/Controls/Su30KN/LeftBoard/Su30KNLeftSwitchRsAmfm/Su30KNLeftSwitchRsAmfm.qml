import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #322. Instances: tbl_rs_amfm, tbl_rs_gu, tbl_rs_ns.
Toggle2Position {
    id: root
    my_type: "Su30KNLeftSwitchRsAmfm"
    my_subtype: "Su30KNLeftSwitchRsAmfm"
    implicitWidth: 19.725
    implicitHeight: 35.3
    previewSource: "state_0.svg"

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
