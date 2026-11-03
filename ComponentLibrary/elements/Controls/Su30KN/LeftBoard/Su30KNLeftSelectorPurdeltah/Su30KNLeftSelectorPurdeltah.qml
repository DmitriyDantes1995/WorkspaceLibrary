import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #466. Instances: tbl_purdeltah.
RotaryDiscrete {
    id: root
    my_type: "Su30KNLeftSelectorPurdeltah"
    my_subtype: "Su30KNLeftSelectorPurdeltah"
    implicitWidth: 103.351
    implicitHeight: 103.351
    previewSource: "preview.svg"
    angles: [-30, -60, -90, -120, -150, -180, -210, -240, -270, -300, -330]

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("body.svg")
        fillMode: Image.PreserveAspectFit
        rotation: root.visualAngle
    }
}
