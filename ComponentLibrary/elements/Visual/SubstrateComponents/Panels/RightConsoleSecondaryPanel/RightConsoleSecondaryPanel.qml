import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "RightConsoleSecondaryPanel"
    my_subtype: "RightConsoleSecondaryPanel"
    previewSource: "background.svg"

    width: 207.8
    height: 253.6

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
