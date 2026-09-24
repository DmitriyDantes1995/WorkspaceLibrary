import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "HorizontalWidePanel"
    my_subtype: "HorizontalWidePanel"
    previewSource: "background.svg"

    width: 407.2
    height: 101.1

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
