import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "RightConsoleVoltagePanel"
    my_subtype: "RightConsoleVoltagePanel"
    previewSource: "background.svg"

    width: 372.71
    height: 232.47

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
