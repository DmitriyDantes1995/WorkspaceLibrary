import QtQuick 2.15
import common_qml 1.0

// Original supplied artwork. RUNTIME SEMANTICS UNKNOWN.
BaseSceneComponent {
    id: root
    my_type: "LandingGearLeverVisual"
    my_subtype: "LandingGearLeverVisual"
    componentPath: "elements/Controls/Other/LandingGearLeverVisual/LandingGearLeverVisual.qml"
    previewSource: "Shassi_tbl_down.svg"
    readonly property real designWidth: 187
    readonly property real designHeight: 1085
    width: designWidth
    height: designHeight
    preserveAspectRatio: true
    // Visual asset selection only. RUNTIME SEMANTICS UNKNOWN.
    property int visualVariant: 0
    readonly property var variantSources: ["Shassi_tbl_down.svg", "Shassi_tbl_up.svg"]

    customProperties: ({ "visualVariant": visualVariant })
    propertySchema: ({ "visualVariant": { displayName: "Visual variant (no runtime mapping)", type: "enum", bindable: false, values: [{ label: "Shassi_tbl_down.svg", value: 0 }, { label: "Shassi_tbl_up.svg", value: 1 }] } })
    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl(root.variantSources[root.visualVariant])
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
