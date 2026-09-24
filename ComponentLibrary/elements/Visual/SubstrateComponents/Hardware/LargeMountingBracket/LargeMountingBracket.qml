import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "LargeMountingBracket"
    my_subtype: "LargeMountingBracket"
    previewSource: "background.svg"

    width: 396.35
    height: 411.45

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
