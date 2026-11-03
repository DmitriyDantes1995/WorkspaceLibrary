import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #484. Instances: btn_saureset.
MomentaryButton {
    id: root
    my_type: "Su30KNLeftButtonSaureset"
    my_subtype: "Su30KNLeftButtonSaureset"
    implicitWidth: 46.19211
    implicitHeight: 52.14792
    previewSource: "state_0.svg"

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
