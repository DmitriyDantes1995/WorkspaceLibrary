import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #398. Instances: rst_vol_spu.
RotaryAnalog {
    id: root
    my_type: "Su30KNLeftRegulatorVolSpu"
    my_subtype: "Su30KNLeftRegulatorVolSpu"
    implicitWidth: 57.47716
    implicitHeight: 57.47716
    previewSource: "preview.svg"
    minimumValue: 0
    maximumValue: 65535
    minimumAngle: -90
    maximumAngle: 90
    wheelStep: 1

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("body.svg")
        fillMode: Image.PreserveAspectFit
        rotation: root.visualAngle
    }
}
