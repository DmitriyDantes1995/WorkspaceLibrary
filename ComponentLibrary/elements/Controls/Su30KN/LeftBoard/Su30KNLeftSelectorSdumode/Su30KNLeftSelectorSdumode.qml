import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #280. Instances: tbl_sdumode.
RotaryDiscrete {
    id: root
    my_type: "Su30KNLeftSelectorSdumode"
    my_subtype: "Su30KNLeftSelectorSdumode"
    implicitWidth: 64.88095
    implicitHeight: 64.88095
    previewSource: "preview.svg"
    angles: [60, 90, 120]

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("body.svg")
        fillMode: Image.PreserveAspectFit
        rotation: root.visualAngle
    }
}
