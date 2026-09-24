import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root
    preserveAspectRatio: true

    property real largeNeedle_rotation: 0
    property real smallNeedle_rotation: 0
    property alias largeNeedleValue: root.largeNeedle_rotation
    property alias smallNeedleValue: root.smallNeedle_rotation
    property string largeNeedleMappingMode: "Linear"
    property real largeNeedleInputMin: 0
    property real largeNeedleInputMax: 360
    property real largeNeedleOutputMinAngle: 0
    property real largeNeedleOutputMaxAngle: 360
    property var largeNeedleMappingPoints: [
        { input: 0, output: 0 }, { input: 360, output: 360 }
    ]
    property string smallNeedleMappingMode: "Linear"
    property real smallNeedleInputMin: 0
    property real smallNeedleInputMax: 360
    property real smallNeedleOutputMinAngle: 0
    property real smallNeedleOutputMaxAngle: 360
    property var smallNeedleMappingPoints: [
        { input: 0, output: 0 }, { input: 360, output: 360 }
    ]

    readonly property real designWidth: 260.4
    readonly property real designHeight: 260.5
    readonly property real needleCenterX: designWidth / 2
    readonly property real needleCenterY: designHeight / 2

    supportsGaugeCalibration: true
    gaugeCalibrationChannels: [
        {
            id: "large", title: "Large needle",
            valueProperty: "largeNeedleValue",
            mappingModeProperty: "largeNeedleMappingMode",
            inputMinProperty: "largeNeedleInputMin",
            inputMaxProperty: "largeNeedleInputMax",
            outputMinProperty: "largeNeedleOutputMinAngle",
            outputMaxProperty: "largeNeedleOutputMaxAngle",
            pointsProperty: "largeNeedleMappingPoints",
            centerX: needleCenterX * width / designWidth,
            centerY: needleCenterY * height / designHeight,
            angleOffset: 90
        },
        {
            id: "small", title: "Small needle",
            valueProperty: "smallNeedleValue",
            mappingModeProperty: "smallNeedleMappingMode",
            inputMinProperty: "smallNeedleInputMin",
            inputMaxProperty: "smallNeedleInputMax",
            outputMinProperty: "smallNeedleOutputMinAngle",
            outputMaxProperty: "smallNeedleOutputMaxAngle",
            pointsProperty: "smallNeedleMappingPoints",
            centerX: needleCenterX * width / designWidth,
            centerY: needleCenterY * height / designHeight,
            angleOffset: 90
        }
    ]

    my_type: "AltimeterIndicator"
    my_subtype: "AltimeterIndicator"
    previewSource: "background.svg"

    width: designWidth
    height: designHeight

    customProperties: ({
        "largeNeedle_rotation": largeNeedle_rotation,
        "smallNeedle_rotation": smallNeedle_rotation,
        "largeNeedleValue": largeNeedleValue,
        "largeNeedleMappingMode": largeNeedleMappingMode,
        "largeNeedleInputMin": largeNeedleInputMin,
        "largeNeedleInputMax": largeNeedleInputMax,
        "largeNeedleOutputMinAngle": largeNeedleOutputMinAngle,
        "largeNeedleOutputMaxAngle": largeNeedleOutputMaxAngle,
        "largeNeedleMappingPoints": largeNeedleMappingPoints,
        "smallNeedleValue": smallNeedleValue,
        "smallNeedleMappingMode": smallNeedleMappingMode,
        "smallNeedleInputMin": smallNeedleInputMin,
        "smallNeedleInputMax": smallNeedleInputMax,
        "smallNeedleOutputMinAngle": smallNeedleOutputMinAngle,
        "smallNeedleOutputMaxAngle": smallNeedleOutputMaxAngle,
        "smallNeedleMappingPoints": smallNeedleMappingPoints
    })
    propertySchema: ({
        "largeNeedle_rotation": {
            displayName: "Large needle",
            type: "number", bindable: false,
            min: 0, max: 360, step: 1, unit: "°", hidden: true
        },
        "smallNeedle_rotation": {
            displayName: "Small needle",
            type: "number", bindable: false,
            min: 0, max: 360, step: 1, unit: "°", hidden: true
        },
        "largeNeedleValue": { displayName: "Value", type: "number", bindable: true, step: 0.1, order: 10, gaugeChannel: "large" },
        "largeNeedleMappingMode": { displayName: "Mode", type: "enum", order: 11, gaugeChannel: "large", values: [{label:"Linear",value:"Linear"},{label:"By points",value:"ByPoints"}] },
        "largeNeedleInputMin": { displayName: "Input Min", type: "number", order: 12, gaugeChannel: "large", visibleWhen: {property:"largeNeedleMappingMode",equals:"Linear"} },
        "largeNeedleInputMax": { displayName: "Input Max", type: "number", order: 13, gaugeChannel: "large", visibleWhen: {property:"largeNeedleMappingMode",equals:"Linear"} },
        "largeNeedleOutputMinAngle": { displayName: "Angle Min", type: "number", unit: "°", order: 14, gaugeChannel: "large", visibleWhen: {property:"largeNeedleMappingMode",equals:"Linear"} },
        "largeNeedleOutputMaxAngle": { displayName: "Angle Max", type: "number", unit: "°", order: 15, gaugeChannel: "large", visibleWhen: {property:"largeNeedleMappingMode",equals:"Linear"} },
        "largeNeedleMappingPoints": { displayName: "Calibration Points", type: "calibrationPoints", order: 16, gaugeChannel: "large", visibleWhen: {property:"largeNeedleMappingMode",equals:"ByPoints"} },
        "smallNeedleValue": { displayName: "Value", type: "number", bindable: true, step: 0.1, order: 10, gaugeChannel: "small" },
        "smallNeedleMappingMode": { displayName: "Mode", type: "enum", order: 11, gaugeChannel: "small", values: [{label:"Linear",value:"Linear"},{label:"By points",value:"ByPoints"}] },
        "smallNeedleInputMin": { displayName: "Input Min", type: "number", order: 12, gaugeChannel: "small", visibleWhen: {property:"smallNeedleMappingMode",equals:"Linear"} },
        "smallNeedleInputMax": { displayName: "Input Max", type: "number", order: 13, gaugeChannel: "small", visibleWhen: {property:"smallNeedleMappingMode",equals:"Linear"} },
        "smallNeedleOutputMinAngle": { displayName: "Angle Min", type: "number", unit: "°", order: 14, gaugeChannel: "small", visibleWhen: {property:"smallNeedleMappingMode",equals:"Linear"} },
        "smallNeedleOutputMaxAngle": { displayName: "Angle Max", type: "number", unit: "°", order: 15, gaugeChannel: "small", visibleWhen: {property:"smallNeedleMappingMode",equals:"Linear"} },
        "smallNeedleMappingPoints": { displayName: "Calibration Points", type: "calibrationPoints", order: 16, gaugeChannel: "small", visibleWhen: {property:"smallNeedleMappingMode",equals:"ByPoints"} }
    })

    Item {
        width: root.designWidth
        height: root.designHeight
        transform: Scale {
            origin.x: 0
            origin.y: 0
            xScale: root.width / root.designWidth
            yScale: root.height / root.designHeight
        }

        AdaptiveSvgImage {
            anchors.fill: parent
            source: Qt.resolvedUrl("background.svg")
            fillMode: Image.PreserveAspectFit
            smooth: true
        }

        Item {
            objectName: "altimeterLargeNeedle"
            x: root.needleCenterX
            y: root.needleCenterY
            width: 0
            height: 0
            rotation: root.gaugeNeedleVisualAngle("large")

            AdaptiveSvgImage {
                anchors.centerIn: parent
                source: Qt.resolvedUrl("large_needle.svg")
                fillMode: Image.PreserveAspectFit
                smooth: true
                antialiasing: true
            }
        }

        Item {
            objectName: "altimeterSmallNeedle"
            x: root.needleCenterX
            y: root.needleCenterY
            width: 0
            height: 0
            rotation: root.gaugeNeedleVisualAngle("small")

            AdaptiveSvgImage {
                anchors.centerIn: parent
                source: Qt.resolvedUrl("small_needle.svg")
                fillMode: Image.PreserveAspectFit
                smooth: true
                antialiasing: true
            }
        }
    }
}
