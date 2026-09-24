import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "Substrate"
    my_subtype: "ContourPanel"
    sceneLayer: "background"
    previewSource: "panel.svg"

    width: 288
    height: 415

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("panel.svg")
        fillMode: Image.Stretch
        smooth: true
    }
}
