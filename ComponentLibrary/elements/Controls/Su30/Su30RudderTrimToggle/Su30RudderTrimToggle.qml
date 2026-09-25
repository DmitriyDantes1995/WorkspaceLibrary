import QtQuick 2.15
import common_qml 1.0

Toggle3Position {
    id: root
    my_type: "Su30RudderTrimToggle"
    my_subtype: "Su30RudderTrimToggle"
    implicitWidth: 104
    implicitHeight: 64
    previewSource: "state_1.svg"
    horizontal: true
    returnToCenter: true
    value: 1
    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
