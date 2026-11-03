import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #462. Instances: tbl_purld, tbl_purlockon, tbl_purnaved.
Toggle2Position {
    id: root
    my_type: "Su30KNLeftSwitchPurnaved"
    my_subtype: "Su30KNLeftSwitchPurnaved"
    implicitWidth: 64.76891
    implicitHeight: 32.03027
    previewSource: "state_0.svg"

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
