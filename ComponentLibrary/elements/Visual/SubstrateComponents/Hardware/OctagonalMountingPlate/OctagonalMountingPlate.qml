import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "OctagonalMountingPlate"
    my_subtype: "OctagonalMountingPlate"
    previewSource: "background.svg"

    width: 129.5
    height: 129

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
