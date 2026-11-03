import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #396. Instances: tbl_canopy.
RotaryDiscrete {
    id: root
    my_type: "Su30KNLeftSwitchCanopy"
    my_subtype: "Su30KNLeftSwitchCanopy"
    implicitWidth: 177.2729
    implicitHeight: 116.6588
    previewSource: "state_0.svg"
    angles: [-60.405, -28.883, 33.177]

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
