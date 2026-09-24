import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "Su27CockpitBackground"
    my_subtype: "Su27CockpitBackground"
    previewSource: "background.svg"

    width: 1443.05
    height: 1095.4

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
