import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #505. Instances: tbl_flaps.
Toggle2Position {
    id: root
    my_type: "Su30KNLeftSwitchFlaps"
    my_subtype: "Su30KNLeftSwitchFlaps"
    implicitWidth: 111.8187
    implicitHeight: 43.19996
    previewSource: "state_0.svg"

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
