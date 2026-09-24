import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "ControlBlockPanel"
    my_subtype: "ControlBlockPanel"
    previewSource: "background.svg"

    width: 325.5
    height: 211.5

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
