import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "RazRaz"
    my_subtype: "RazRaz"
    previewSource: "text.svg"

    width: image.implicitWidth
    height: image.implicitHeight

    customProperties: ({})

    AdaptiveSvgImage {
        id: image

        anchors.fill: parent
        source: Qt.resolvedUrl("text.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
