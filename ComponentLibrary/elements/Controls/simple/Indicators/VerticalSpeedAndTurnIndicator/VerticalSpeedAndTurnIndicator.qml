import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root
    preserveAspectRatio: true

    property real value: 0
    property string valueMappingMode: "Linear"
    // Scene loaders use this only when opening a pre-mapping scene, preserving
    // the component's former hard-coded nonlinear scale.
    readonly property string legacyValueMappingMode: "ByPoints"
    property real inputMin: -200
    property real inputMax: 200
    property real outputMinAngle: 135
    property real outputMaxAngle: 405
    property var valueMappingPoints: [
        { input: -200, output: 135 },
        { input: -100, output: 170 },
        { input: -50, output: 195 },
        { input: -20, output: 225 },
        { input: 0, output: 270 },
        { input: 20, output: 315 },
        { input: 50, output: 345 },
        { input: 100, output: 370 },
        { input: 200, output: 405 }
    ]
    readonly property real needleVisual:
        mapGaugeValue(value, valueMappingMode, valueMappingPoints,
                      inputMin, inputMax, outputMinAngle, outputMaxAngle, true)

    supportsGaugeCalibration: true
    gaugeCalibrationCenterX: width / 2
    gaugeCalibrationCenterY: height / 2
    gaugeCalibrationAngleOffset: 90

    readonly property real designWidth: 607.1
    readonly property real designHeight: 733
    readonly property real needleCenterX: designWidth / 2
    readonly property real needleCenterY: designHeight / 2

    my_type: "VerticalSpeedAndTurnIndicator"
    my_subtype: "VerticalSpeedAndTurnIndicator"
    previewSource: "background.svg"

    width: designWidth
    height: designHeight

    customProperties: ({
        "value": value,
        "valueMappingMode": valueMappingMode,
        "inputMin": inputMin,
        "inputMax": inputMax,
        "outputMinAngle": outputMinAngle,
        "outputMaxAngle": outputMaxAngle,
        "valueMappingPoints": valueMappingPoints
    })
    propertySchema: ({
        "value": {
            displayName: "Vertical speed",
            type: "number",
            bindable: true,
            min: -200,
            max: 200,
            step: 1,
            unit: "m/s"
        },
        "valueMappingMode": {
            displayName: "Scale mapping", type: "enum", bindable: false,
            order: 20,
            values: [
                { label: "Linear", value: "Linear" },
                { label: "By points", value: "ByPoints" }
            ]
        },
        "inputMin": {
            displayName: "Input Min", type: "number", bindable: false,
            order: 21, visibleWhen: { property: "valueMappingMode", equals: "Linear" }
        },
        "inputMax": {
            displayName: "Input Max", type: "number", bindable: false,
            order: 22, visibleWhen: { property: "valueMappingMode", equals: "Linear" }
        },
        "outputMinAngle": {
            displayName: "Angle Min", type: "number", unit: "°", bindable: false,
            order: 23, visibleWhen: { property: "valueMappingMode", equals: "Linear" }
        },
        "outputMaxAngle": {
            displayName: "Angle Max", type: "number", unit: "°", bindable: false,
            order: 24, visibleWhen: { property: "valueMappingMode", equals: "Linear" }
        },
        "valueMappingPoints": {
            displayName: "Calibration Points", type: "calibrationPoints",
            bindable: false, order: 25,
            visibleWhen: { property: "valueMappingMode", equals: "ByPoints" }
        }
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
            objectName: "verticalSpeedNeedle"
            x: root.needleCenterX
            y: root.needleCenterY
            width: 0
            height: 0
            rotation: root.editorCalibrationActive
                      ? root.editorCalibrationAngle : root.needleVisual

            AdaptiveSvgImage {
                anchors.centerIn: parent
                source: Qt.resolvedUrl("needle.svg")
                fillMode: Image.PreserveAspectFit
                smooth: true
                antialiasing: true
            }
        }
    }
}
