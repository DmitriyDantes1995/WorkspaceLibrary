import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #427. Instances: tbl_saulink, tbl_sdudampgam, tbl_sdudampyaw.
Toggle2Position {
    id: root
    my_type: "Su30KNLeftSwitchSdudampyaw"
    my_subtype: "Su30KNLeftSwitchSdudampyaw"
    implicitWidth: 44.36819
    implicitHeight: 29.00882
    previewSource: "state_0.svg"

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
