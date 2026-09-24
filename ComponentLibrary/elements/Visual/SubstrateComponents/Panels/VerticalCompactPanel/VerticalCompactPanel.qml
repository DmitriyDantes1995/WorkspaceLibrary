import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "VerticalCompactPanel"
    my_subtype: "VerticalCompactPanel"
    previewSource: "background.svg"

    width: 149.8
    height: 246.4

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
