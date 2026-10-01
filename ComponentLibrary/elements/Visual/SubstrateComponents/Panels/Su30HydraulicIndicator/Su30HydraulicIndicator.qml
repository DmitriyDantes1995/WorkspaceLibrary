import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    my_type: "Substrate"
    my_subtype: "ContourPanel"
    sceneLayer: "content"
    previewSource: "../../../../Controls/Su30/Su30HydraulicIndicator/_parts/legacy.svg"
    width: 79
    height: 111
    customProperties: ({})
    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("../../../../Controls/Su30/Su30HydraulicIndicator/_parts/legacy.svg")
        fillMode: Image.Stretch
        smooth: true
    }
}
