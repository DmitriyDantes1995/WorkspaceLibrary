import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #251. Instances: tbl_light.
RotaryDiscrete {
    id: root
    my_type: "Su30KNLeftSwitchLight"
    my_subtype: "Su30KNLeftSwitchLight"
    implicitWidth: 80.59919
    implicitHeight: 79.53544
    previewSource: "state_0.svg"
    angles: [-68.535, 46.693, -36.543]

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
