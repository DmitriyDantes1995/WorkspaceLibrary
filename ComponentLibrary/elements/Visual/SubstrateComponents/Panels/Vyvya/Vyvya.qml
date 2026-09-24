import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "Vyvya"
    my_subtype: "Vyvya"
    previewSource: "panel.svg"

    width: 400
    height: 240

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("panel.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
