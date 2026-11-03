import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #187. Instances: tbl_flapper_rudder, tbl_limalphany.
Toggle2Position {
    id: root
    my_type: "Su30KNLeftSwitchFlapperRudder"
    my_subtype: "Su30KNLeftSwitchFlapperRudder"
    implicitWidth: 92.37243
    implicitHeight: 51.90344
    previewSource: "state_0.svg"

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
