import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #430. Instances: rst_r862_volume, rst_rs1_nb, rst_rs2_volume.
RotaryAnalog {
    id: root
    my_type: "Su30KNLeftRegulatorR862Volume"
    my_subtype: "Su30KNLeftRegulatorR862Volume"
    implicitWidth: 51.74256
    implicitHeight: 51.74256
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
