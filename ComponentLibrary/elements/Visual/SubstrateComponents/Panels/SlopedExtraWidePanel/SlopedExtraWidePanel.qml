import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "SlopedExtraWidePanel"
    my_subtype: "SlopedExtraWidePanel"
    previewSource: "background.svg"

    width: 719.8
    height: 421.8

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
