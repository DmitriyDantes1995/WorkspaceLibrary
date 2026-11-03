import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #326. Instances: btn_rs_test.
MomentaryButton {
    id: root
    my_type: "Su30KNLeftButtonRsTest"
    my_subtype: "Su30KNLeftButtonRsTest"
    implicitWidth: 17.15
    implicitHeight: 17.15
    previewSource: "state_0.svg"

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
