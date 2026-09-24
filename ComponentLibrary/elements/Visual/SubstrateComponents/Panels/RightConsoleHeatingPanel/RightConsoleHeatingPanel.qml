import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "RightConsoleHeatingPanel"
    my_subtype: "RightConsoleHeatingPanel"
    previewSource: "background.svg"

    width: 305
    height: 74

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
