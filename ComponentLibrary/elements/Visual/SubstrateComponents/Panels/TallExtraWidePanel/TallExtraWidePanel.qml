import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "TallExtraWidePanel"
    my_subtype: "TallExtraWidePanel"
    previewSource: "background.svg"

    width: 454.5
    height: 515.3

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
