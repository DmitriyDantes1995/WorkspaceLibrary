import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "RpmScaleLocalImage"
    my_subtype: "RpmScaleLocalImage"
    previewSource: "background.svg"

    width: 512
    height: 512

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
