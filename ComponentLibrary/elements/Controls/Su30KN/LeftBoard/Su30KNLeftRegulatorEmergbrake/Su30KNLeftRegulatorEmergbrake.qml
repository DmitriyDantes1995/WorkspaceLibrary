import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #390. Instances: rst_emergbrake.
RotaryAnalog {
    id: root
    my_type: "Su30KNLeftRegulatorEmergbrake"
    my_subtype: "Su30KNLeftRegulatorEmergbrake"
    implicitWidth: 371.9938
    implicitHeight: 371.9938
    previewSource: "preview.svg"
    minimumValue: 0
    maximumValue: 65535
    minimumAngle: 140
    maximumAngle: 0
    wheelStep: 1

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("body.svg")
        fillMode: Image.PreserveAspectFit
        rotation: root.visualAngle
    }
}
