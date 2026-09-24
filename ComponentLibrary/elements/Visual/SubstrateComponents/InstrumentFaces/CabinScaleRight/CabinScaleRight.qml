import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "CabinScaleRight"
    my_subtype: "CabinScaleRight"
    previewSource: "background.svg"

    width: 30.9
    height: 82.05

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
