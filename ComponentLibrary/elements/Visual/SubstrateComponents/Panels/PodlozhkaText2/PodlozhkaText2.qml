import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "Substrate"
    my_subtype: "ContourPanel"
    previewSource: "panel.svg"

    width: 490
    height: 300

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("panel.svg")
        fillMode: Image.Stretch
        smooth: true
    }
}
