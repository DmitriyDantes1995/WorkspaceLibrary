import QtQuick 2.15
import common_qml 1.0

// Approximation drawn from Su30.jpg. Static artwork; no runtime mapping.
BaseSceneComponent {
    id: root
    my_type: "MetalPushButtonVisual"
    my_subtype: "MetalPushButtonVisual"
    componentPath: "elements/Controls/Other/MetalPushButtonVisual/MetalPushButtonVisual.qml"
    previewSource: "artwork.svg"
    readonly property real designWidth: 64
    readonly property real designHeight: 64
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
