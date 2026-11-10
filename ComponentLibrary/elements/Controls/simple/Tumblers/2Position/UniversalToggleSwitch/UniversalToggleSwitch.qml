import QtQuick 2.15
import common_qml 1.0
import "PanelLooks.js" as PanelLooks

Toggle2Position {
    id: root
    my_type: "UniversalToggleSwitch"
    my_subtype: "UniversalToggleSwitch"
    implicitWidth: dimensions[0]
    implicitHeight: dimensions[1]
    previewSource: previewName(effectiveAppearance, tipColor)

    property alias oN: root.value
    property string appearance: "classic"
    readonly property var catalogVariantProperties: ["appearance", "tipColor"]
    readonly property string catalogSection: "open"
    readonly property int catalogPositions: stateCount
    property string tipColor: "default"

    readonly property var appearances: Object.assign({
        classic: { label: qsTr("Classic vertical"), width: 79.51283, height: 80.5768, colors: ["yellow", "blue"] },
        classicSide: { label: qsTr("Classic horizontal"), width: 81.59589, height: 80.51872, colors: ["yellow", "blue"] },
        shortLever: { label: qsTr("Short lever"), width: 73, height: 143, colors: ["yellow", "blue"], raster: true,
            originalFrames: ["../Yellow_Tumb/Yellow_tumbler_down.png", "../Yellow_Tumb/Yellow_tumbler_up.png"] },
        longLever: { label: qsTr("Long lever"), width: 73, height: 211, colors: ["blue", "yellow"], raster: true,
            originalFrames: ["../Blue_Tumb/Blue_tumbler_down.png", "../Blue_Tumb/Blue_tumbler_up.png"] },
        system: { label: qsTr("Recessed lever"), width: 76.892871, height: 78.359376, colors: ["amber", "blue"], stretch: true },
        ring: { label: qsTr("Lever with ring"), width: 64.76891, height: 32.03027, colors: ["yellow", "blue"] },
        dark: { label: qsTr("Dark lever"), width: 92.35987, height: 33.34678, colors: ["amber", "blue"] },
        metal: { label: qsTr("Silver lever"), width: 79.2, height: 140.9, stretch: true }
    }, PanelLooks.entries)
    readonly property string effectiveAppearance: appearances[appearance] ? appearance : "classic"
    readonly property var look: appearances[effectiveAppearance]
    readonly property bool hasTipColor: look.colors !== undefined
    readonly property string effectiveTipColor: colorForLook(look, tipColor)
    readonly property var dimensions: look.sizes ? look.sizes[colorForLook(look, tipColor)] : [look.width, look.height]
    readonly property var tipLabels: ({
        yellow: qsTr("Yellow"), blue: qsTr("Blue"), amber: qsTr("Amber"), gray: qsTr("Gray")
    })

    onLookChanged: {
        if (tipColor !== "default" && (!look.colors || !look.colors.includes(tipColor)))
            tipColor = "default"
    }

    positionRegions: {
        if (look.regions)
            return look.regions[effectiveTipColor] || []
        if (appearance !== "system") return []
        const x = effectiveTipColor === "blue" ? 0.2743614 : 0.2704599
        return [[x, 0.5104686, 0.452599, 0.4895314], [x, 0, 0.452599, 0.4895314]]
    }

    customProperties: ({
        [root.valuePropertyName]: root.value,
        valuePropertyName: root.valuePropertyName,
        appearance: root.appearance,
        tipColor: root.tipColor
    })
    propertySchema: ({
        [root.valuePropertyName]: {
            displayName: qsTr("Position"), type: "enum", bindable: true, access: "readWrite", order: 2,
            values: [{ label: qsTr("Position 0"), value: 0 }, { label: qsTr("Position 1"), value: 1 }]
        },
        valuePropertyName: { hidden: true, bindable: false },
        appearance: { displayName: qsTr("Appearance"), type: "enum", bindable: false, order: 0,
            values: Object.keys(root.appearances).map(function(name) {
                return {
                    label: root.appearances[name].label,
                    value: name,
                    previewSource: Qt.resolvedUrl(root.previewName(name, root.tipColor))
                }
            }) },
        tipColor: { displayName: qsTr("Tip color"), type: "enum", bindable: false, order: 1,
            visibleWhen: { property: "hasTipColor", equals: true },
            values: ["default"].concat(root.look.colors || []).map(function(color) {
                return {
                    label: color === "default" ? qsTr("Default") : root.tipLabels[color],
                    value: color,
                    catalogHidden: color === "default",
                    previewSource: Qt.resolvedUrl(root.previewName(root.effectiveAppearance, color))
                }
            }) }
    })

    function colorForLook(style, requestedColor) {
        const colors = style.colors || []
        return colors.includes(requestedColor) ? requestedColor : colors[0] || ""
    }

    function frameName(position, appearanceName, requestedColor) {
        const style = appearances[appearanceName]
        const color = colorForLook(style, requestedColor)
        if (style.frames)
            return style.frames[color][position]
        if (style.originalFrames && color === style.colors[0])
            return style.originalFrames[position]
        return appearanceName + (color ? "-" + color : "") + "_" + position
                + (style.raster ? ".png" : ".svg")
    }

    function previewName(appearanceName, requestedColor) {
        const style = appearances[appearanceName]
        return style.raster
            ? "_art/" + appearanceName + "/" + colorForLook(style, requestedColor) + ".svg"
            : frameName(0, appearanceName, requestedColor)
    }

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl(root.frameName(root.currentState, root.effectiveAppearance, root.tipColor))
        fillMode: root.look.stretch || root.look.raster ? Image.Stretch : Image.PreserveAspectFit
    }
}
