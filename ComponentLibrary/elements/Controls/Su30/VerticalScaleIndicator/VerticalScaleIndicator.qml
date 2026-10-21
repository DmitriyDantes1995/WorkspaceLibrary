import QtQuick 2.15
import QtQuick.Shapes 1.15
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
    property int labelMinimum: 0
    property int labelMaximum: 3
    property int majorDivisions: 3
    property int minorDivisions: 5
    property int multiplier: 100
    property bool showMultiplier: true
    property string units: "кг/см²"
    property bool showUnits: true
    property real fontSize: 20
    property real multiplierFontSize: 20
    property real unitsFontSize: 20
    property string backgroundColor: "#303431"
    property real lineWidth: 1
    readonly property int tickCount: Math.max(1, majorDivisions) * Math.max(1, minorDivisions)
    readonly property var settingsKeys: ["value", "minimumValue", "maximumValue", "labelMinimum", "labelMaximum",
        "majorDivisions", "minorDivisions", "multiplier", "showMultiplier", "units", "showUnits", "fontSize",
        "multiplierFontSize", "unitsFontSize", "backgroundColor", "lineWidth"]
    property bool restoringSettings: false
    customProperties: settingsMap()
    function settingsMap() {
        var result = ({})
        for (var key of settingsKeys) result[key] = root[key]
        return result
    }
    function synchronizeState() {
        if (!restoringSettings)
            customProperties = settingsMap()
    }
    function setCustomProperty(name, value) {
        if (settingsKeys.indexOf(name) < 0) return
        root[name] = value
        synchronizeState()
    }
    onCustomPropertiesChanged: {
        if (restoringSettings) return
        // Old configurations used range / multiplier for numeric labels.
        var copy = customProperties
        restoringSettings = true
        var legacyMultiplier = Number(copy.multiplier === undefined ? multiplier : copy.multiplier)
        if (copy.labelMinimum === undefined)
            labelMinimum = Number(copy.minimumValue === undefined ? minimumValue : copy.minimumValue) / legacyMultiplier
        if (copy.labelMaximum === undefined)
            labelMaximum = Number(copy.maximumValue === undefined ? maximumValue : copy.maximumValue) / legacyMultiplier
        for (var key of settingsKeys) {
            if (copy[key] !== undefined) root[key] = copy[key]
        }
        // Rebuild from the actual typed properties; retired layout and decimal
        // settings must not return to the inspector or the next saved scene.
        customProperties = settingsMap()
        restoringSettings = false
    }
    // Scene hosts restore property maps synchronously after createObject().
    // Canonicalize once that restore finishes, including removed legacy keys.
    Component.onCompleted: Qt.callLater(synchronizeState)
    propertySchema: ({
        value: {displayName:"Value", type:"number", bindable:true, access:"readOnly", step:0.1},
        minimumValue: {displayName:"Working minimum", type:"number", step:1},
        maximumValue: {displayName:"Working maximum", type:"number", step:1},
        labelMinimum: {displayName:"Label minimum", type:"number", step:1},
        labelMaximum: {displayName:"Label maximum", type:"number", step:1},
        majorDivisions: {displayName:"Major divisions", type:"number", min:1, max:20, step:1},
        minorDivisions: {displayName:"Minor divisions", type:"number", min:1, max:10, step:1},
        multiplier: {displayName:"Multiplier caption", type:"number", min:1, max:1000000, step:1},
        showMultiplier: {displayName:"Show multiplier", type:"bool"},
        units: {displayName:"Units", type:"string"}, showUnits: {displayName:"Show units", type:"bool"},
        fontSize: {displayName:"Размер цифр", type:"number", min:1, max:100, step:1, unit:"px", order:10},
        multiplierFontSize: {displayName:"Размер множ.", type:"number", min:1, max:100, step:1, unit:"px", order:20},
        unitsFontSize: {displayName:"Размер единиц", type:"number", min:1, max:100, step:1, unit:"px", order:30},
        backgroundColor: {displayName:"Цвет фона", type:"color", order:40},
        lineWidth: {displayName:"Scale line width", type:"number", min:0.5, max:8, step:0.5, unit:"px"}
    })
    onValueChanged: synchronizeState()
    onMinimumValueChanged: synchronizeState()
    onMaximumValueChanged: synchronizeState()
    onLabelMinimumChanged: synchronizeState()
    onLabelMaximumChanged: synchronizeState()
    onMajorDivisionsChanged: synchronizeState()
    onMinorDivisionsChanged: synchronizeState()
    onMultiplierChanged: synchronizeState()
    onShowMultiplierChanged: synchronizeState()
    onUnitsChanged: synchronizeState()
    onShowUnitsChanged: synchronizeState()
    onFontSizeChanged: synchronizeState()
    onMultiplierFontSizeChanged: synchronizeState()
    onUnitsFontSizeChanged: synchronizeState()
    onBackgroundColorChanged: synchronizeState()
    onLineWidthChanged: synchronizeState()

    readonly property real headerHeight: showMultiplier ? multiplierFontSize * 1.25 : 0
    readonly property real footerHeight: showUnits ? unitsFontSize * 1.25 : 0
    readonly property real frameTop: headerHeight
    readonly property real frameBottom: height - footerHeight
    // Text uses its requested size; changing geometry never silently shrinks it.
    readonly property real labelHeight: fontSize * 1.25
    readonly property real axisInset: Math.min(labelHeight / 2, Math.max(0, frameBottom - frameTop) / 2)
    readonly property real axisTop: frameTop + axisInset
    readonly property real axisBottom: frameBottom - axisInset

    Rectangle {
        objectName: "scaleBackground"
        anchors.fill: parent
        color: root.backgroundColor
    }
    Rectangle {
        objectName: "scaleFrame"
        x: 0; y: root.frameTop
        width: root.width
        height: Math.max(0, root.frameBottom - root.frameTop)
        color: "transparent"
        border.color: "#79827a"
        border.width: root.lineWidth * 0.5
    }
    Text {
        objectName: "scaleMultiplier"
        visible: root.showMultiplier
        x: 0; y: 0
        width: root.width; height: root.headerHeight
        text: "×" + root.multiplier
        color: "#cdd2c6"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: root.multiplierFontSize
        font.family: "Arial"
        renderType: Text.CurveRendering
    }
    Item {
        id: scaleArea
        objectName: "scaleArea"
        x: 0; y: root.axisTop
        width: root.width
        height: Math.max(0, root.axisBottom - root.axisTop)
        Rectangle {
            objectName: "scaleAxis"
            x: parent.width * 0.92 - width / 2
            width: root.lineWidth
            height: parent.height
            color: "#cdd2c6"
        }
        Repeater {
            model: root.tickCount + 1
            Item {
                required property int index
                property bool major: index % Math.max(1, root.minorDivisions) === 0
                y: scaleArea.height * (1 - index / root.tickCount)
                width: scaleArea.width; height: 1
                Rectangle {
                    objectName: "scaleTick" + parent.index
                    x: scaleArea.width * (parent.major ? 0.46 : 0.69)
                    y: -height / 2
                    width: scaleArea.width * 0.92 - x
                    height: root.lineWidth * (parent.major ? 1 : 0.7)
                    color: parent.major ? "#cdd2c6" : "#98a195"
                }
                Text {
                    objectName: "scaleLabel" + parent.index
                    visible: parent.major
                    x: 0; y: -height / 2
                    width: scaleArea.width * 0.42; height: root.labelHeight
                    text: Math.round(root.labelMinimum + (root.labelMaximum - root.labelMinimum)
                          * parent.index / root.tickCount).toString()
                    color: "#cdd2c6"
                    font.family: "Arial"
                    font.pixelSize: root.fontSize
                    renderType: Text.CurveRendering
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
        Shape {
            id: pointer
            objectName: "scalePointer"
            x: scaleArea.width * 0.45
            y: root.mapLinearValue(root.value, root.minimumValue, root.maximumValue,
                                   scaleArea.height, 0, true) - height / 2
            width: scaleArea.width * 0.43
            height: Math.min(Math.max(3, root.fontSize * 0.7), scaleArea.height * 0.1)
            ShapePath {
                strokeWidth: -1
                fillColor: "#e0e5d6"
                startX: 0; startY: 0
                PathLine { x: pointer.width; y: pointer.height / 2 }
                PathLine { x: 0; y: pointer.height }
                PathLine { x: 0; y: 0 }
            }
        }
    }
    Text {
        objectName: "scaleUnits"
        visible: root.showUnits
        x: 0; y: root.height - root.footerHeight
        width: root.width; height: root.footerHeight
        text: root.units
        color: "#cdd2c6"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: root.unitsFontSize
        font.family: "Arial"
        renderType: Text.CurveRendering
    }
}
