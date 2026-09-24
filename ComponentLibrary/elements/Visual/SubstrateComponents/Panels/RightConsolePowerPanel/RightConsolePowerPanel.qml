import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "RightConsolePowerPanel"
    my_subtype: "RightConsolePowerPanel"
    previewSource: "background.svg"

    width: 465
    height: 201.5

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
