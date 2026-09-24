import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "RightConsoleDistributionPanel"
    my_subtype: "RightConsoleDistributionPanel"
    previewSource: "background.svg"

    width: 424.02
    height: 311.93

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
