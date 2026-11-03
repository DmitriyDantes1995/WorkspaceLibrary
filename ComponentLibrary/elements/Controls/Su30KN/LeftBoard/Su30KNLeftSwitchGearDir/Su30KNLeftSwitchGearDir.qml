import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #247. Instances: tbl_gear_dir.
Toggle2Position {
    id: root
    my_type: "Su30KNLeftSwitchGearDir"
    my_subtype: "Su30KNLeftSwitchGearDir"
    implicitWidth: 81.59589
    implicitHeight: 80.51872
    previewSource: "state_0.svg"

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
