import QtQuick 2.15
import common_qml 1.0

// Artwork only. The containing instrument owns its scale, detents and state.
Item {
    id: root
    implicitWidth: 43.2
    implicitHeight: 43.1
    readonly property real pointerAngle: Math.atan2(30.15 - implicitWidth / 2,
                                                 implicitHeight / 2 - 33.8) * 180 / Math.PI
    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("knob.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
