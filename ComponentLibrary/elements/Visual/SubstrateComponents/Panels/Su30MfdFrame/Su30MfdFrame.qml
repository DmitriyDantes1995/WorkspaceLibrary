import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    my_type: "Substrate"
    my_subtype: "ContourPanel"
    sceneLayer: "content"
    previewSource: "../../../../Controls/Su30/Su30Mfd/_parts/frame.svg"
    width: 467
    height: 562
    customProperties: ({})
    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("../../../../Controls/Su30/Su30Mfd/_parts/frame.svg")
        fillMode: Image.Stretch
        smooth: true
    }
}
