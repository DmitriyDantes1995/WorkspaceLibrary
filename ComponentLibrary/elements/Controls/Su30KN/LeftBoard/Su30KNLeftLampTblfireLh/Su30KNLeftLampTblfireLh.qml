import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #190. Instances: lmp_tblfire_lh, lmp_tblfire_rh.
Indicator {
    id: root
    my_type: "Su30KNLeftLampTblfireLh"
    my_subtype: "Su30KNLeftLampTblfireLh"
    implicitWidth: 35.08865
    implicitHeight: 35.18099
    previewSource: "state_0.svg"

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
