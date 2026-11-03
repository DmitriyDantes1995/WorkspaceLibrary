import QtQuick 2.15
import common_qml 1.0

// 1RightBort.swf, bezel #508 and indicator #507.
Indicator {
    id: root

    my_type: "Su27UBRightLampSpoHighSap"
    my_subtype: "Su27UBRightLampSpoHighSap"
    implicitWidth: 70.53
    implicitHeight: 31.38
    previewSource: "state_1.svg"

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
