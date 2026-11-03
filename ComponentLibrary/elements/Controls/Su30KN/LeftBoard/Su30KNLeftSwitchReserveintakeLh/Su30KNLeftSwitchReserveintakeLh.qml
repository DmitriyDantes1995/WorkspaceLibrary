import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #181. Instances: tbl_reserveintake_lh, tbl_reserveintake_rh.
RotaryDiscrete {
    id: root
    my_type: "Su30KNLeftSwitchReserveintakeLh"
    my_subtype: "Su30KNLeftSwitchReserveintakeLh"
    implicitWidth: 92.36866
    implicitHeight: 33.36357
    previewSource: "state_0.svg"
    angles: [-73.044, 42.744, -49.528]

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
