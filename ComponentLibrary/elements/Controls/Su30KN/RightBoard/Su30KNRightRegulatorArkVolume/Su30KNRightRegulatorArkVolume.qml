import QtQuick 2.15
import common_qml 1.0

// 1RightBort.swf, rst_arkvolume (sprite #535).
RotaryAnalog {
    id: root

    my_type: "Su30KNRightRegulatorArkVolume"
    my_subtype: "Su30KNRightRegulatorArkVolume"
    implicitWidth: 59.787475
    implicitHeight: implicitWidth
    minimumValue: 0
    maximumValue: 65535
    value: minimumValue
    discrete: true
    minimumAngle: 0
    maximumAngle: 300
    wheelStep: 1
    previewSource: "preview.svg"

    AdaptiveSvgImage {
        x: root.width * 0.1464466
        y: root.height * 0.1464466
        width: root.width * 0.7071068
        height: root.height * 0.7071068
        source: Qt.resolvedUrl("../_parts/selectorArt/body_535.svg")
        fillMode: Image.Stretch
        rotation: root.visualAngle
    }
}
