import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "RightConsoleMainPanel"
    my_subtype: "RightConsoleMainPanel"
    previewSource: "background.svg"

    width: 514.5
    height: 331.7

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
