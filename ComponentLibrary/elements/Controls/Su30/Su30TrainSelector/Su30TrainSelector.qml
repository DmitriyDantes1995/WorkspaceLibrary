import QtQuick 2.15
import common_qml 1.0

RotaryDiscrete {
    id: root
    my_type: "Su30TrainSelector"
    my_subtype: "Su30TrainSelector"
    implicitWidth: 90
    implicitHeight: 90
    previewSource: "body.svg"
    angles: [-120, -90, -60, -30, 0]
    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("body.svg")
        rotation: root.visualAngle
        fillMode: Image.PreserveAspectFit
    }
}
