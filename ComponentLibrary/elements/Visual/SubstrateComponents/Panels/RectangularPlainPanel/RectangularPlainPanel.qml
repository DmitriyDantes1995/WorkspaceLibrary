import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "RectangularPlainPanel"
    my_subtype: "RectangularPlainPanel"
    previewSource: "background.svg"

    width: 253.9
    height: 450.7

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
