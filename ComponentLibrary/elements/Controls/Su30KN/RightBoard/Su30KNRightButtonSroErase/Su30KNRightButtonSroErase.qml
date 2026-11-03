import QtQuick 2.15
import common_qml 1.0
import "../../LeftBoard/_parts" as Existing

// 1RightBort.swf, sprite #602. Instances: btn_sroerase.
Existing.GuardedSwitch {
    id: root

    my_type: "Su30KNRightButtonSroErase"
    my_subtype: "Su30KNRightButtonSroErase"
    implicitWidth: 45.612061
    implicitHeight: 83.669995
    previewSource: "closed_0.svg"
    assetDirectory: Qt.resolvedUrl("./")

    clickRegions: [
        {"x": 0.01710526315789475, "y": 0.33142944191965085, "width": 0.9274573280736843, "height": 0.6685086020141793, "action": "open"},
        {"x": 0.017434210526315806, "y": 0.09184570078167606, "width": 0.927284654394737, "height": 0.2228332354344301, "action": "close"}
    ]

    MomentaryButton {
        x: root.width * 0.1309172
        y: root.height * 0.42446615
        width: root.width * 0.66579718
        height: root.height * 0.36793736
        runtimeMode: root.acceptsInput && root.cover === 1
        onUserPropertyChanged: function(propertyName, value) { root.commitFromUser(value) }
    }
}
