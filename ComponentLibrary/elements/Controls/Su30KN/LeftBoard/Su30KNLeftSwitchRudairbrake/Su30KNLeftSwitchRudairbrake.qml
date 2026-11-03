import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #586. Instances: btn_rudairbrake.
Toggle2Position {
    id: root
    my_type: "Su30KNLeftSwitchRudairbrake"
    my_subtype: "Su30KNLeftSwitchRudairbrake"
    implicitWidth: 102.0066
    implicitHeight: 61.78262
    previewSource: "state_0.svg"

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
