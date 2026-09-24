import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "WidePlainBackground"
    my_subtype: "WidePlainBackground"
    previewSource: "background.svg"

    width: 1443
    height: 547.7

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
