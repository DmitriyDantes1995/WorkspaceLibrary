import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "DoubleRoundedPanel"
    my_subtype: "DoubleRoundedPanel"
    previewSource: "background.svg"

    width: 317.3
    height: 126.7

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
