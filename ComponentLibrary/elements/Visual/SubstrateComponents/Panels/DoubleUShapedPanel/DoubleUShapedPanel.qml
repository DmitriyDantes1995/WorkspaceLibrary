import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "DoubleUShapedPanel"
    my_subtype: "DoubleUShapedPanel"
    previewSource: "background.svg"

    width: 222.5
    height: 361.5

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
