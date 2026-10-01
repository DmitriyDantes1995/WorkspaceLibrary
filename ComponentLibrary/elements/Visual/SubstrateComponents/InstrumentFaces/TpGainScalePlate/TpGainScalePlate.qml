import QtQuick 2.15
import common_qml 1.0

// Hidden legacy scene entry point. TpGain does not depend on this wrapper.
BaseSceneComponent {
    my_type: "TpGainScalePlate"
    my_subtype: "TpGainScalePlate"
    componentPath: "elements/Visual/SubstrateComponents/InstrumentFaces/TpGainScalePlate/TpGainScalePlate.qml"
    previewSource: "../../../../Controls/Other/TpGain/_parts/scale.svg"
    readonly property real designWidth: 92.7
    readonly property real designHeight: 92.9
    width: designWidth
    height: designHeight
    preserveAspectRatio: true
    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("../../../../Controls/Other/TpGain/_parts/scale.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
