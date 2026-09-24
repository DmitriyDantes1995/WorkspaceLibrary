import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "RedControlHandle"
    my_subtype: "RedControlHandle"
    previewSource: "background.svg"

    width: 99.6
    height: 153.2

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
