import QtQuick 2.15
import common_qml 1.0
import "../../LeftBoard/_parts" as Existing

// 1RightBort.swf, sprite #671. Instances: btn_pnk_off.
Existing.GuardedSwitch {
    id: root

    my_type: "Su30KNRightButtonPnkOff"
    my_subtype: "Su30KNRightButtonPnkOff"
    implicitWidth: 76.876482
    implicitHeight: 77.604381
    previewSource: "closed_0.svg"
    assetDirectory: Qt.resolvedUrl("./")

    clickRegions: [
        {"x": 0.31132187206734185, "y": 0.09183610585623345, "width": 0.687725927406999, "height": 0.8375006958867091, "action": "open"},
        {"x": 0.03332335364119536, "y": 0.09190034358022826, "width": 0.25376196580296906, "height": 0.8375892645455639, "action": "close"}
    ]

    MomentaryButton {
        x: root.width * 0.4745431
        y: root.height * 0.43303639
        width: root.width * 0.39235458
        height: root.height * 0.38867444
        runtimeMode: root.acceptsInput && root.cover === 1
        onUserPropertyChanged: function(propertyName, value) { root.commitFromUser(value) }
    }
}
