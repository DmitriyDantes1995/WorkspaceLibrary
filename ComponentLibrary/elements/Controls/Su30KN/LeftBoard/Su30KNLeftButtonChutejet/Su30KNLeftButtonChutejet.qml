import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #510. Instances: btn_chutejet.
MomentaryButton {
    id: root
    my_type: "Su30KNLeftButtonChutejet"
    my_subtype: "Su30KNLeftButtonChutejet"
    implicitWidth: 36.56372
    implicitHeight: 36.56372
    previewSource: "state_0.svg"

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
