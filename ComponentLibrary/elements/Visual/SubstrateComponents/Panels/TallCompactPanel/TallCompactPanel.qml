import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "TallCompactPanel"
    my_subtype: "TallCompactPanel"
    previewSource: "background.svg"

    width: 209.2
    height: 514.4

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
