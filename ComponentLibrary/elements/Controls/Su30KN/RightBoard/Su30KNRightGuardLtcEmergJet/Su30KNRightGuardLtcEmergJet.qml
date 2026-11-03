import QtQuick 2.15
import common_qml 1.0
import "../../LeftBoard/_parts" as Parts

// 1RightBort.swf, tbl_ltc_emerg_jet (sprite #623).
Parts.GuardedSwitch {
    id: root

    my_type: "Su30KNRightGuardLtcEmergJet"
    my_subtype: "Su30KNRightGuardLtcEmergJet"
    implicitWidth: 38.788555
    implicitHeight: 112.64542
    previewSource: "closed_0.svg"
    assetDirectory: Qt.resolvedUrl("./")
    clickRegions: [{"x": 0.121426, "y": 0.3040401, "width": 0.7114938, "height": 0.6959146, "action": "open", "state": 0}, {"x": 0.121426, "y": 0.1285277, "width": 0.7113569, "height": 0.1632231, "action": "close", "state": 0}]

    MomentaryButton {
        x: root.width * 0.0
        y: root.height * 0.4687762
        width: root.width * 0.9543732
        height: root.height * 0.3287592
        runtimeMode: root.acceptsInput && root.cover === 1
        onUserPropertyChanged: function(name, value) {
            root.commitFromUser(value)
        }
    }
}
