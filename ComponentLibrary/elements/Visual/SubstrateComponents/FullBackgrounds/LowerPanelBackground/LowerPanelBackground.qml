import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "LowerPanelBackground"
    my_subtype: "LowerPanelBackground"
    previewSource: "background.svg"

    width: 1443
    height: 547.8

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
