import QtQuick 2.15
import common_qml 1.0

// Original supplied artwork. RUNTIME SEMANTICS UNKNOWN.
BaseSceneComponent {
    id: root
    my_type: "TpGainKnobVisual"
    my_subtype: "TpGainKnobVisual"
    componentPath: "elements/Controls/Other/TpGainKnobVisual/TpGainKnobVisual.qml"
    previewSource: "Krytilka_001.svg"
    readonly property real designWidth: 43.2
    readonly property real designHeight: 43.1
    width: designWidth
    height: designHeight
    preserveAspectRatio: true

    customProperties: ({})
    propertySchema: ({})
    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("Krytilka_001.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
