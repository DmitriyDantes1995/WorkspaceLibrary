import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #280. Instances: tbl_ilsindic.
RotaryDiscrete {
    id: root
    my_type: "Su30KNLeftSelectorIlsindic"
    my_subtype: "Su30KNLeftSelectorIlsindic"
    implicitWidth: 66.86591
    implicitHeight: 66.86591
    previewSource: "preview.svg"
    angles: [30, 60, 90, 120, 150, 180]

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("body.svg")
        fillMode: Image.PreserveAspectFit
        rotation: root.visualAngle
    }
}
