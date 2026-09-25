import QtQuick 2.15
import common_qml 1.0

Toggle2Position {
    id: root
    my_type: "Su30RingToggle"
    my_subtype: "Su30RingToggle"
    implicitWidth: 72
    implicitHeight: 98
    previewSource: "state_0.svg"

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
