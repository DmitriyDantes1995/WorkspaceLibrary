import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "RoundedInsetPanel"
    my_subtype: "RoundedInsetPanel"
    previewSource: "background.svg"

    width: 175.7
    height: 123.8

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
