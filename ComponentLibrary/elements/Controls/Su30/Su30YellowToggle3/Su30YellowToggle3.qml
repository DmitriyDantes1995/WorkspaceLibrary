import QtQuick 2.15
import common_qml 1.0

Toggle3Position {
    id: root
    my_type: "Su30YellowToggle3"
    my_subtype: "Su30YellowToggle3"
    implicitWidth: 56
    implicitHeight: 104
    previewSource: "state_1.svg"
    value: 1
    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
