import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "RightConsoleAuxiliaryPanel"
    my_subtype: "RightConsoleAuxiliaryPanel"
    previewSource: "background.svg"

    width: 459.5
    height: 419.3

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
