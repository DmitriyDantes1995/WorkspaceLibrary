import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #181. Instances: tbl_netintakeopen.
Toggle2Position {
    id: root
    my_type: "Su30KNLeftSwitchNetintakeopen"
    my_subtype: "Su30KNLeftSwitchNetintakeopen"
    implicitWidth: 92.35987
    implicitHeight: 33.34678
    previewSource: "state_0.svg"

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
