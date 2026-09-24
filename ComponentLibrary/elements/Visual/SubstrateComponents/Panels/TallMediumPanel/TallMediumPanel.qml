import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "TallMediumPanel"
    my_subtype: "TallMediumPanel"
    previewSource: "background.svg"

    width: 174.7
    height: 515.6

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
