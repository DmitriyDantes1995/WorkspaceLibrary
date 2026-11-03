import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #578. Instances: btn_rudmrk.
MomentaryButton {
    id: root
    my_type: "Su30KNLeftButtonRudmrk"
    my_subtype: "Su30KNLeftButtonRudmrk"
    implicitWidth: 159.646
    implicitHeight: 159.646
    previewSource: "state_0.svg"

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
