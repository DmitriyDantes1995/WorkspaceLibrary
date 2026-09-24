import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "RoundedPanelWithStep"
    my_subtype: "RoundedPanelWithStep"
    previewSource: "background.svg"

    width: 170.4
    height: 388.8

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
