import QtQuick 2.15
import common_qml 1.0

RotaryAnalog {
    id: root
    my_type: "Su30RotaryKnob"
    my_subtype: "Su30RotaryKnob"
    implicitWidth: 64
    implicitHeight: 64
    previewSource: "body.png"

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("body.png")
        rotation: root.visualAngle
        fillMode: Image.PreserveAspectFit
    }
}
