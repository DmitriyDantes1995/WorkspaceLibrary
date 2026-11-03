import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, lrud.rst_rudd #554.
RotaryAnalog {
    id: root
    my_type: "Su30KNLeftRegulatorRudd"
    my_subtype: "Su30KNLeftRegulatorRudd"
    implicitWidth: 69.331502
    implicitHeight: implicitWidth
    minimumValue: 0
    maximumValue: 65535
    discrete: true
    minimumAngle: 0
    maximumAngle: 180
    wheelStep: 364
    previewSource: "knob.svg"

    AdaptiveSvgImage {
        objectName: "rudArtwork"
        anchors.fill: parent
        source: Qt.resolvedUrl("knob.svg")
        rotation: root.visualAngle
    }
}
