import QtQuick 2.15
import common_qml 1.0

MomentaryButton {
    id: root
    my_type: "Su30ResetButton"
    my_subtype: "Su30ResetButton"
    implicitWidth: 64
    implicitHeight: 60
    previewSource: "state_0.svg"

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
