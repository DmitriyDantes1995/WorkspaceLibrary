import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "VoltmeterFaceWithoutText"
    my_subtype: "VoltmeterFaceWithoutText"
    previewSource: "background.svg"

    width: 60.5
    height: 60.5

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
