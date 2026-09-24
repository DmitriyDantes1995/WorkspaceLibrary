import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "TallNarrowPanel"
    my_subtype: "TallNarrowPanel"
    previewSource: "background.svg"

    width: 98.8
    height: 514.6

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
