import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #290. Instances: rst_sdukshenter.
RotaryAnalog {
    id: root
    my_type: "Su30KNLeftRegulatorSdukshenter"
    my_subtype: "Su30KNLeftRegulatorSdukshenter"
    implicitWidth: 82.99612
    implicitHeight: 82.99612
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
