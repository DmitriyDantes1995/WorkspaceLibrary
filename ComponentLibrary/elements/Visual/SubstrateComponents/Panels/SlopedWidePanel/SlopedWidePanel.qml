import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "SlopedWidePanel"
    my_subtype: "SlopedWidePanel"
    previewSource: "background.svg"

    width: 414.6
    height: 317.2

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
