import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "CircularPlateWithLowerMark"
    my_subtype: "CircularPlateWithLowerMark"
    previewSource: "background.svg"

    width: 133.8
    height: 129.3

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
