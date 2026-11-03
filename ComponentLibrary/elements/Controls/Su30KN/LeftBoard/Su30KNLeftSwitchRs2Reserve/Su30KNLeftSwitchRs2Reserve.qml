import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #457. Instances: tbl_rs2_reserve, tbl_rs_tx, tbl_spu_ark_rsbn, tbl_spu_emerg_rx, tbl_spu_res_rs, tbl_spu_res_spu.
Toggle2Position {
    id: root
    my_type: "Su30KNLeftSwitchRs2Reserve"
    my_subtype: "Su30KNLeftSwitchRs2Reserve"
    implicitWidth: 72.90924
    implicitHeight: 35.129
    previewSource: "state_0.svg"

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
