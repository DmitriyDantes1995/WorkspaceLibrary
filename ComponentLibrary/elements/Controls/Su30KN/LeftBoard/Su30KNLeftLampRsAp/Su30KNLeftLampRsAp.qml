import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #320. Instances: lmp_rs_ap.
Indicator {
    id: root
    my_type: "Su30KNLeftLampRsAp"
    my_subtype: "Su30KNLeftLampRsAp"
    implicitWidth: 26.67104
    implicitHeight: 26.60105
    previewSource: "state_0.svg"

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
