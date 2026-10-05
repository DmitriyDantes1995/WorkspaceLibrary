import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root
    my_type: "VerticalScaleIndicator"
    my_subtype: "VerticalScaleIndicator"
    componentPath: "elements/Controls/Su30/VerticalScaleIndicator/VerticalScaleIndicator.qml"
    previewSource: "preview.png"
    width: 60
    height: 220
    preserveAspectRatio: false

    property real value: 0
    property real minimumValue: 0
    property real maximumValue: 300
    property real labelMinimum: 0
    property real labelMaximum: 3
    property int labelDecimals: 3
    property int majorDivisions: 3
    property int minorDivisions: 5
    property real multiplier: 100
    property bool showMultiplier: true
    property string units: "кгс/см²"
    property bool showUnits: true
    property real fontSize: 12
    property real horizontalPadding: 4
    property real verticalPadding: 4
    property real textGap: 4
    readonly property int tickCount: Math.max(1, majorDivisions) * Math.max(1, minorDivisions)
    readonly property var settingsKeys: ["value", "minimumValue", "maximumValue", "labelMinimum", "labelMaximum",
        "labelDecimals", "majorDivisions", "minorDivisions", "multiplier", "showMultiplier", "units", "showUnits",
        "fontSize", "horizontalPadding", "verticalPadding", "textGap"]
    property bool restoringSettings: false
    customProperties: settingsMap()
    function settingsMap() {
        var result = ({})
        for (var key of settingsKeys) result[key] = root[key]
        return result
    }
    function synchronizeState(name, v) {
        if (!restoringSettings && customProperties[name] !== v) {
            customProperties[name] = v
            customPropertiesChanged()
        }
    }
    onCustomPropertiesChanged: {
        if (restoringSettings) return
        // Old configurations used range / multiplier for numeric labels.
        var copy = JSON.parse(JSON.stringify(customProperties)), missing = false
        restoringSettings = true
        var legacyMultiplier = Number(copy.multiplier === undefined ? multiplier : copy.multiplier)
        if (copy.labelMinimum === undefined)
            labelMinimum = Number(copy.minimumValue === undefined ? minimumValue : copy.minimumValue) / legacyMultiplier
        if (copy.labelMaximum === undefined)
            labelMaximum = Number(copy.maximumValue === undefined ? maximumValue : copy.maximumValue) / legacyMultiplier
        for (var key of settingsKeys) {
            if (copy[key] === undefined) { copy[key] = root[key]; missing = true }
        }
        if (missing) customProperties = copy
        restoringSettings = false
    }
    propertySchema: ({
        value: {displayName:"Value", type:"number", bindable:true, access:"readOnly", step:0.1},
        minimumValue: {displayName:"Working minimum", type:"number", step:1},
        maximumValue: {displayName:"Working maximum", type:"number", step:1},
        labelMinimum: {displayName:"Label minimum", type:"number", step:0.1},
        labelMaximum: {displayName:"Label maximum", type:"number", step:0.1},
        labelDecimals: {displayName:"Label decimals", type:"number", min:0, max:6, step:1},
        majorDivisions: {displayName:"Major divisions", type:"number", min:1, max:20, step:1},
        minorDivisions: {displayName:"Minor divisions", type:"number", min:1, max:10, step:1},
        multiplier: {displayName:"Multiplier caption", type:"number", min:0.001, max:1000000, step:1},
        showMultiplier: {displayName:"Show multiplier", type:"bool"},
        units: {displayName:"Units", type:"string"}, showUnits: {displayName:"Show units", type:"bool"},
        fontSize: {displayName:"Font size", type:"number", min:1, max:100, step:1, unit:"px"},
        horizontalPadding: {displayName:"Horizontal padding", type:"number", min:0, max:100, step:1, unit:"px"},
        verticalPadding: {displayName:"Vertical padding", type:"number", min:0, max:100, step:1, unit:"px"},
        textGap: {displayName:"Text gap", type:"number", min:0, max:100, step:1, unit:"px"}
    })
    onValueChanged: synchronizeState("value", value)
    onMinimumValueChanged: synchronizeState("minimumValue", minimumValue)
    onMaximumValueChanged: synchronizeState("maximumValue", maximumValue)
    onLabelMinimumChanged: synchronizeState("labelMinimum", labelMinimum)
    onLabelMaximumChanged: synchronizeState("labelMaximum", labelMaximum)
    onLabelDecimalsChanged: synchronizeState("labelDecimals", labelDecimals)
    onMajorDivisionsChanged: synchronizeState("majorDivisions", majorDivisions)
    onMinorDivisionsChanged: synchronizeState("minorDivisions", minorDivisions)
    onMultiplierChanged: synchronizeState("multiplier", multiplier)
    onShowMultiplierChanged: synchronizeState("showMultiplier", showMultiplier)
    onUnitsChanged: synchronizeState("units", units)
    onShowUnitsChanged: synchronizeState("showUnits", showUnits)
    onFontSizeChanged: synchronizeState("fontSize", fontSize)
    onHorizontalPaddingChanged: synchronizeState("horizontalPadding", horizontalPadding)
    onVerticalPaddingChanged: synchronizeState("verticalPadding", verticalPadding)
    onTextGapChanged: synchronizeState("textGap", textGap)

    readonly property real padX: Math.min(horizontalPadding, width / 4)
    readonly property real padY: Math.min(verticalPadding, height / 6)
    readonly property real captionHeight: Math.min(fontSize * 1.5, height / 6)
    readonly property real headerHeight: showMultiplier ? captionHeight : 0
    readonly property real footerHeight: showUnits ? captionHeight : 0
    readonly property real gap: Math.min(textGap, height / 10)
    readonly property real labelHeight: Math.max(1, Math.min(fontSize * 1.5,
        (height - 2 * padY - headerHeight - footerHeight - 2 * gap) / (Math.max(1, majorDivisions) + 1)))
    readonly property real axisTop: padY + headerHeight + gap + labelHeight / 2
    readonly property real axisBottom: height - padY - footerHeight - gap - labelHeight / 2

    Rectangle {
        anchors.fill: parent
        color: "#30474a"
        border.color: "#8da6a1"
        border.width: 1
    }
    Text {
        objectName: "scaleMultiplier"
        visible: root.showMultiplier
        x: root.padX; y: root.padY
        width: Math.max(0, root.width - 2 * root.padX); height: root.headerHeight
        text: "×" + root.multiplier
        color: "#c1d3ca"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: root.fontSize
        fontSizeMode: Text.Fit; minimumPixelSize: 1
    }
    Item {
        id: scaleArea
        objectName: "scaleArea"
        x: root.padX; y: root.axisTop
        width: Math.max(0, root.width - 2 * root.padX)
        height: Math.max(0, root.axisBottom - root.axisTop)
        Rectangle { x: parent.width * 0.92; width: 1; height: parent.height; color: "#c1d3ca" }
        Repeater {
            model: root.tickCount + 1
            Item {
                required property int index
                property bool major: index % Math.max(1, root.minorDivisions) === 0
                y: scaleArea.height * (1 - index / root.tickCount)
                width: scaleArea.width; height: 1
                Rectangle {
                    x: scaleArea.width * (parent.major ? 0.48 : 0.65)
                    width: scaleArea.width * 0.92 - x; height: 1; color: "#c1d3ca"
                }
                Text {
                    objectName: "scaleLabel" + parent.index
                    visible: parent.major
                    x: 0; y: -height / 2
                    width: scaleArea.width * 0.42; height: root.labelHeight
                    text: Number((root.labelMinimum + (root.labelMaximum - root.labelMinimum)
                          * parent.index / root.tickCount).toFixed(root.labelDecimals)).toString()
                    color: "#c1d3ca"
                    font.pixelSize: root.fontSize
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    fontSizeMode: Text.Fit; minimumPixelSize: 1
                }
            }
        }
        Canvas {
            objectName: "scalePointer"
            x: scaleArea.width * 0.45
            y: root.mapLinearValue(root.value, root.minimumValue, root.maximumValue,
                                   scaleArea.height, 0, true) - height / 2
            width: scaleArea.width * 0.43
            height: Math.min(Math.max(3, root.fontSize * 0.7), scaleArea.height * 0.1)
            onPaint: {
                var c = getContext("2d")
                c.clearRect(0, 0, width, height)
                c.beginPath(); c.moveTo(0, 0); c.lineTo(width, height / 2); c.lineTo(0, height); c.closePath()
                c.fillStyle = "#e0f0df"; c.fill()
            }
            onWidthChanged: requestPaint()
            onHeightChanged: requestPaint()
        }
    }
    Text {
        objectName: "scaleUnits"
        visible: root.showUnits
        x: root.padX; y: root.height - root.padY - root.footerHeight
        width: Math.max(0, root.width - 2 * root.padX); height: root.footerHeight
        text: root.units
        color: "#c1d3ca"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: root.fontSize
        fontSizeMode: Text.Fit; minimumPixelSize: 1
    }
}
