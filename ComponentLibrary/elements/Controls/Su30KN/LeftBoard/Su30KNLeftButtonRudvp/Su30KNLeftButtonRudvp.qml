import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #568. Instances: btn_rudvp, btn_spu.
MomentaryButton {
    id: root
    my_type: "Su30KNLeftButtonRudvp"
    my_subtype: "Su30KNLeftButtonRudvp"
    implicitWidth: 124.8047
    implicitHeight: 113.1042
    previewSource: "state_0.svg"

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
