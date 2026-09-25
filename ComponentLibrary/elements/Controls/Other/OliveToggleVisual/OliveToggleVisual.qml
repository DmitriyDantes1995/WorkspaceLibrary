import QtQuick 2.15
import common_qml 1.0

// Approximation drawn from Su30.jpg. Static artwork; no runtime mapping.
BaseSceneComponent {
    id: root
    my_type: "OliveToggleVisual"
    my_subtype: "OliveToggleVisual"
    componentPath: "elements/Controls/Other/OliveToggleVisual/OliveToggleVisual.qml"
    previewSource: "artwork.svg"
    readonly property real designWidth: 64
    readonly property real designHeight: 72
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
