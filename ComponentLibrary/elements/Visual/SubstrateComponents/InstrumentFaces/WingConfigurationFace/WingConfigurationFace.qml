import QtQuick 2.15
import common_qml 1.0

// Original supplied artwork. RUNTIME SEMANTICS UNKNOWN.
BaseSceneComponent {
    id: root
    my_type: "WingConfigurationFace"
    my_subtype: "WingConfigurationFace"
    componentPath: "elements/Visual/SubstrateComponents/InstrumentFaces/WingConfigurationFace/WingConfigurationFace.qml"
    previewSource: "7.svg"
    readonly property real designWidth: 97.7
    readonly property real designHeight: 98
    width: designWidth
    height: designHeight
    preserveAspectRatio: true

    customProperties: ({})
    propertySchema: ({})
    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("7.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
