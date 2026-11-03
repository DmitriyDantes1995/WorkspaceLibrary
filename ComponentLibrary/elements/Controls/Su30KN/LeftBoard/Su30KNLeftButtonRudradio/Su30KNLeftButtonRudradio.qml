import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #581. Instances: btn_rudradio.
MomentaryButton {
    id: root
    my_type: "Su30KNLeftButtonRudradio"
    my_subtype: "Su30KNLeftButtonRudradio"
    implicitWidth: 125.8188
    implicitHeight: 147.429
    previewSource: "state_0.svg"

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
