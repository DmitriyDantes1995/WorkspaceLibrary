import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "BoltHead"
    my_subtype: "BoltHead"
    previewSource: "background.svg"

    width: 19
    height: 19

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
