import QtQuick 2.15
import common_qml 1.0
import "../TpGain/_parts"

// Hidden legacy scene entry point. TpGain does not depend on this wrapper.
BaseSceneComponent {
    id: root
    my_type: "TpGainKnobVisual"
    my_subtype: "TpGainKnobVisual"
    componentPath: "elements/Controls/Other/TpGainKnobVisual/TpGainKnobVisual.qml"
    previewSource: "../TpGain/_parts/knob.svg"
    readonly property real designWidth: 43.2
    readonly property real designHeight: 43.1
    readonly property real pointerAngle: artwork.pointerAngle
    width: designWidth
    height: designHeight
    preserveAspectRatio: true

    customProperties: ({})
    propertySchema: ({})
    GainKnobVisual {
        id: artwork
        anchors.fill: parent
    }
}
