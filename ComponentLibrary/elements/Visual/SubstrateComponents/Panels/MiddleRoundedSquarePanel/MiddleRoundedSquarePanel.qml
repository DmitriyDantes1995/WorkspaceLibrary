import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "MiddleRoundedSquarePanel"
    my_subtype: "MiddleRoundedSquarePanel"
    previewSource: "background.svg"

    width: 119
    height: 121

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
