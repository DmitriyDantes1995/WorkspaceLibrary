import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "OvalMountingPlate"
    my_subtype: "OvalMountingPlate"
    previewSource: "background.svg"

    width: 48.7
    height: 48.4

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
