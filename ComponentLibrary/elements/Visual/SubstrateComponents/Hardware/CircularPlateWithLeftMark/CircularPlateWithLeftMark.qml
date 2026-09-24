import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "CircularPlateWithLeftMark"
    my_subtype: "CircularPlateWithLeftMark"
    previewSource: "background.svg"

    width: 97.9
    height: 83.5

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
