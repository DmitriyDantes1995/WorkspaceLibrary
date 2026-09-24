import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "OvalSwitchBase"
    my_subtype: "OvalSwitchBase"
    previewSource: "background.svg"

    width: 46.2
    height: 49.5

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
