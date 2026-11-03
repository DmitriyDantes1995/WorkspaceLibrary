import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #466. Instances: tbl_purmode.
RotaryDiscrete {
    id: root
    my_type: "Su30KNLeftSelectorPurmode"
    my_subtype: "Su30KNLeftSelectorPurmode"
    implicitWidth: 103.351
    implicitHeight: 103.351
    previewSource: "preview.svg"
    angles: [-60, -30, 0, 30, 60, 90, 120]

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("body.svg")
        fillMode: Image.PreserveAspectFit
        rotation: root.visualAngle
    }
}
