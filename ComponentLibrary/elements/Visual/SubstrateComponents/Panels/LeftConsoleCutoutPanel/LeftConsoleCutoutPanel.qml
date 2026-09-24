import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "LeftConsoleCutoutPanel"
    my_subtype: "LeftConsoleCutoutPanel"
    previewSource: "background.svg"

    width: 87.2
    height: 398.5

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
