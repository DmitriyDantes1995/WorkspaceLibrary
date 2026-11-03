import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #558. Instances: btn_rudreset, btn_stores.
MomentaryButton {
    id: root
    my_type: "Su30KNLeftButtonStores"
    my_subtype: "Su30KNLeftButtonStores"
    implicitWidth: 82.49464
    implicitHeight: 55.36976
    previewSource: "state_0.svg"

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
