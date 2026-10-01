import QtQuick 2.15
import common_qml 1.0

MomentaryButton {
    id: root
    implicitWidth: 32
    implicitHeight: 32
    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
