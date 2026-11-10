pragma ComponentBehavior: Bound
import QtQuick 2.15
import common_qml 1.0
import "PanelLayouts.js" as Layouts

RotaryDiscrete {
    id: root
    my_type: "RotarySelector"
    my_subtype: "RotarySelector"
    implicitWidth: placement ? placement.width : (effectiveAppearance === "dial" ? 103.351 : 66.86591)
    implicitHeight: placement ? placement.height : implicitWidth
    previewSource: placement && effectiveAppearance === placement.appearance
                   ? placement.preview : artworkFor(effectiveAppearance)

    property string appearance: "auto"
    readonly property var catalogVariantProperties: ["layout", "appearance"]
    readonly property string catalogSection: "bare"
    property string layout: "custom"
    readonly property var placement: Layouts.entries[layout]
    readonly property bool hasCustomDetents: !placement
    readonly property string effectiveAppearance: appearance === "auto"
        ? (placement ? placement.appearance : "pointer") : appearance
    readonly property var bodyRect: placement ? placement.bodyRect : [0, 0, 1, 1]
    property int positionCount: 6
    property real firstAngle: 30
    property real angleStep: 30

    angles: {
        if (placement)
            return placement.angles
        const result = []
        const count = Math.max(2, Math.min(36, root.positionCount))
        for (let i = 0; i < count; ++i)
            result.push(root.firstAngle + root.angleStep * i)
        return result
    }

    inputCenterX: width * (bodyRect[0] + bodyRect[2] / 2)
    inputCenterY: height * (bodyRect[1] + bodyRect[3] / 2)

    customProperties: ({ appearance: root.appearance, layout: root.layout, positionCount: root.positionCount,
                         firstAngle: root.firstAngle, angleStep: root.angleStep, value: root.value })
    propertySchema: ({
        appearance: { displayName: qsTr("Appearance"), type: "enum", bindable: false, order: 0,
            visibleWhen: { property: "hasCustomDetents", equals: true },
            values: [{ label: qsTr("Pointer"), value: "pointer", previewSource: Qt.resolvedUrl("pointer.svg") },
                     { label: qsTr("Round dial"), value: "dial", previewSource: Qt.resolvedUrl("dial.svg") },
                     { label: qsTr("Default for layout"), value: "auto", catalogHidden: true,
                       previewSource: Qt.resolvedUrl(root.artworkFor(root.placement ? root.placement.appearance : "pointer")) }]
                .concat(Object.keys(Layouts.artwork).map(function(key) {
                    return { label: Layouts.artwork[key].label, value: key,
                             previewSource: Qt.resolvedUrl(Layouts.artwork[key].source) }
                })) },
        layout: { displayName: qsTr("Detent layout"), type: "enum", bindable: false, order: 1,
            values: [{ label: qsTr("Custom"), value: "custom" }]
                .concat(Object.keys(Layouts.entries).map(function(key) {
                    return { label: Layouts.entries[key].label, value: key,
                             previewSource: Qt.resolvedUrl(Layouts.entries[key].preview) }
                })) },
        positionCount: { displayName: qsTr("Positions"), type: "number", bindable: false, min: 2, max: 36, step: 1, order: 2,
            visibleWhen: { property: "hasCustomDetents", equals: true } },
        firstAngle: { displayName: qsTr("First angle"), type: "number", bindable: false, min: -360, max: 360, step: 1, order: 3,
            visibleWhen: { property: "hasCustomDetents", equals: true } },
        angleStep: { displayName: qsTr("Angle step"), type: "number", bindable: false, min: -360, max: 360, step: 1, order: 4,
            visibleWhen: { property: "hasCustomDetents", equals: true } },
        value: { displayName: qsTr("Position"), type: "number", bindable: true, access: "readWrite",
            min: root.minimumValue, max: root.maximumValue, step: 1, order: 5 }
    })

    function artworkFor(style) {
        if (Layouts.artwork[style])
            return Layouts.artwork[style].source
        return style === "dial" ? "dial.svg" : "pointer.svg"
    }

    AdaptiveSvgImage {
        x: root.width * root.bodyRect[0]
        y: root.height * root.bodyRect[1]
        width: root.width * root.bodyRect[2]
        height: root.height * root.bodyRect[3]
        source: Qt.resolvedUrl(root.artworkFor(root.effectiveAppearance))
        rotation: root.visualAngle
        fillMode: root.placement && root.placement.stretch ? Image.Stretch : Image.PreserveAspectFit
    }

    Repeater {
        model: root.placement ? root.placement.regions : []
        MouseArea {
            required property int index
            required property var modelData
            x: modelData[0] * root.width
            y: modelData[1] * root.height
            width: modelData[2] * root.width
            height: modelData[3] * root.height
            enabled: root.acceptsInput
            cursorShape: Qt.PointingHandCursor
            onPressed: root.commitFromUser(root.minimumValue + index)
            onWheel: function(wheel) {
                if (wheel.angleDelta.y !== 0)
                    root.stepFromUser(wheel.angleDelta.y > 0 ? 1 : -1)
            }
        }
    }
}
