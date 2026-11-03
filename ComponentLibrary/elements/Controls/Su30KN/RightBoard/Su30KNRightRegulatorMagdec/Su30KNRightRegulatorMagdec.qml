import QtQuick 2.15
import common_qml 1.0

// 1RightBort.swf, rst_magdec #690.
RotaryAnalog {
    id: root
    my_type: "Su30KNRightRegulatorMagdec"
    my_subtype: "Su30KNRightRegulatorMagdec"
    implicitWidth: 48.276489
    implicitHeight: implicitWidth
    minimumValue: 0
    maximumValue: 3600
    minimumAngle: 0
    maximumAngle: 300
    wheelStep: 1
    previewSource: "dial.svg"

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("dial.svg")
        rotation: root.visualAngle
    }
}
