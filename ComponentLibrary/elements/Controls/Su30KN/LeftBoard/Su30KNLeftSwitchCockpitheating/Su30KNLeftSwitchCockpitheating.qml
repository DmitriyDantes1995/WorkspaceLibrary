import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #256. Instances: tbl_cockpitheating.
RotaryDiscrete {
    id: root
    my_type: "Su30KNLeftSwitchCockpitheating"
    my_subtype: "Su30KNLeftSwitchCockpitheating"
    implicitWidth: 74.45603
    implicitHeight: 57.49056
    previewSource: "state_0.svg"
    angles: [-41.95, -91.166, 59.681, -44.86]

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
