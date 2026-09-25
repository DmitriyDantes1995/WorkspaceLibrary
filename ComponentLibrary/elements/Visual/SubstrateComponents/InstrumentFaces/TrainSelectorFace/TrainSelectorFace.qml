import QtQuick 2.15
import common_qml 1.0

// Approximation drawn from Su30.jpg. Static artwork; no runtime mapping.
BaseSceneComponent {
    id: root
    my_type: "TrainSelectorFace"
    my_subtype: "TrainSelectorFace"
    componentPath: "elements/Visual/SubstrateComponents/InstrumentFaces/TrainSelectorFace/TrainSelectorFace.qml"
    previewSource: "artwork.svg"
    readonly property real designWidth: 106
    readonly property real designHeight: 138
    width: designWidth
    height: designHeight
    preserveAspectRatio: true
    customProperties: ({})
    propertySchema: ({})
    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("artwork.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
