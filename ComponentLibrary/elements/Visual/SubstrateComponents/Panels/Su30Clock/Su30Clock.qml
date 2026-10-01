import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    my_type: "Substrate"
    my_subtype: "ContourPanel"
    sceneLayer: "content"
    previewSource: "../../../../Controls/Su30/Su30Clock/_parts/legacy.svg"
    width: 179
    height: 179
    customProperties: ({})
    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("../../../../Controls/Su30/Su30Clock/_parts/legacy.svg")
        fillMode: Image.Stretch
        smooth: true
    }
}
