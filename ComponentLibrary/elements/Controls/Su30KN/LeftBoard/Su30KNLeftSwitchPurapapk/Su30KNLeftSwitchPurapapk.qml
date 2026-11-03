import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #462. Instances: tbl_purapapk, tbl_purind, tbl_purradiate, tbl_pursnp.
RotaryDiscrete {
    id: root
    my_type: "Su30KNLeftSwitchPurapapk"
    my_subtype: "Su30KNLeftSwitchPurapapk"
    implicitWidth: 64.76891
    implicitHeight: 32.03027
    previewSource: "state_0.svg"
    angles: [-64.216, 40.269, -31.444]

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
