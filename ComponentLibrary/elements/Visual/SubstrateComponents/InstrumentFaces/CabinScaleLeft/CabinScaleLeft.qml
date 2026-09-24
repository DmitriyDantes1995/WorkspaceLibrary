import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "CabinScaleLeft"
    my_subtype: "CabinScaleLeft"
    previewSource: "background.svg"

    width: 29.4
    height: 82.05

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
