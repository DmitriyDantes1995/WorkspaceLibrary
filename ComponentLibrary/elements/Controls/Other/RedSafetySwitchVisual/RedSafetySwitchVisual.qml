import QtQuick 2.15
import common_qml 1.0

// Original supplied artwork. RUNTIME SEMANTICS UNKNOWN.
BaseSceneComponent {
    id: root
    my_type: "RedSafetySwitchVisual"
    my_subtype: "RedSafetySwitchVisual"
    componentPath: "elements/Controls/Other/RedSafetySwitchVisual/RedSafetySwitchVisual.qml"
    previewSource: "Red_Tubler_Middle.svg"
    readonly property real designWidth: 156.8
    readonly property real designHeight: 187.4
    width: designWidth
    height: designHeight
    preserveAspectRatio: true
    // Visual asset selection only. RUNTIME SEMANTICS UNKNOWN.
    property int visualVariant: 0
    readonly property var variantSources: ["Red_Tubler_Middle.svg", "Red_Tubler_Up.svg"]

    customProperties: ({ "visualVariant": visualVariant })
    propertySchema: ({ "visualVariant": { displayName: "Visual variant (no runtime mapping)", type: "enum", bindable: false, values: [{ label: "Red_Tubler_Middle.svg", value: 0 }, { label: "Red_Tubler_Up.svg", value: 1 }] } })
    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl(root.variantSources[root.visualVariant])
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
