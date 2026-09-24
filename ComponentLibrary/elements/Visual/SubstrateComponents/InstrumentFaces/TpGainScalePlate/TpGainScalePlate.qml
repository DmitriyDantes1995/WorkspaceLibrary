import QtQuick 2.15
import common_qml 1.0

// Original supplied artwork. RUNTIME SEMANTICS UNKNOWN.
BaseSceneComponent {
    id: root
    my_type: "TpGainScalePlate"
    my_subtype: "TpGainScalePlate"
    componentPath: "elements/Visual/SubstrateComponents/InstrumentFaces/TpGainScalePlate/TpGainScalePlate.qml"
    previewSource: "Podlogka_pod_Krytilky_001.svg"
    readonly property real designWidth: 92.7
    readonly property real designHeight: 92.9
    width: designWidth
    height: designHeight
    preserveAspectRatio: true

    customProperties: ({})
    propertySchema: ({})
    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("Podlogka_pod_Krytilky_001.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
