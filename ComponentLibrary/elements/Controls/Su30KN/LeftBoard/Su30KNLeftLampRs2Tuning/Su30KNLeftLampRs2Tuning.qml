import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #440. Instances: lmp_rs2_tuning.
Indicator {
    id: root
    my_type: "Su30KNLeftLampRs2Tuning"
    my_subtype: "Su30KNLeftLampRs2Tuning"
    implicitWidth: 23.17944
    implicitHeight: 23.24044
    previewSource: "state_0.svg"

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
