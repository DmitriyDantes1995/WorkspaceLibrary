import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #437. Instances: tbl_r862ch, tbl_rs1ch.
RotaryDiscrete {
    id: root
    my_type: "Su30KNLeftSelectorR862ch"
    my_subtype: "Su30KNLeftSelectorR862ch"
    implicitWidth: 108.3199
    implicitHeight: 108.3199
    previewSource: "preview.svg"
    angles: [18.0, 36.0, 54.0, 72.0, 90.0, 108.0, 126.0, 144.0, 162.0, 180.0, 198.0, 216.0, 234.0, 252.0, 270.0, 288.0, 306.0, 324.0, 342.0, 360.0]

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("body.svg")
        fillMode: Image.PreserveAspectFit
        rotation: root.visualAngle
    }
}
