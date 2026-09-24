import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "RoundedCircularPlateB"
    my_subtype: "RoundedCircularPlateB"
    previewSource: "background.svg"

    width: 64.6
    height: 37.3

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
