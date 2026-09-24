import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root
    preserveAspectRatio: true
    previewSource: "Pribor_004_background.svg"

    property real bolshaya_rotation: 0
    // Compatibility alias: existing scenes/bindings may keep writing the old
    // angle property. With the default identity mapping the visual is exact;
    // new scenes can bind a physical value here and configure its scale.
    property alias value: root.bolshaya_rotation
    property string valueMappingMode: "Linear"
    property real inputMin: 0
    property real inputMax: 360
    property real outputMinAngle: 0
    property real outputMaxAngle: 360
    property var valueMappingPoints: [
        { input: 0, output: 0 },
        { input: 360, output: 360 }
    ]
    readonly property real needleVisual: mapGaugeValue(
        value, valueMappingMode, valueMappingPoints,
        inputMin, inputMax, outputMinAngle, outputMaxAngle, true)

    readonly property real designWidth: 400
    readonly property real designHeight: 415

    // Координаты центров в исходном макете
    readonly property real bigCenterX: 200
    readonly property real bigCenterY: 205

    readonly property real smallCenterX: 203
    readonly property real smallCenterY: 322

    supportsGaugeCalibration: true
    gaugeCalibrationCenterX: bigCenterX * width / designWidth
    gaugeCalibrationCenterY: bigCenterY * height / designHeight
    gaugeCalibrationAngleOffset: 90

    width: designWidth
    height: designHeight

    customProperties: ({
        "bolshaya_rotation": bolshaya_rotation,
        "value": value,
        "valueMappingMode": valueMappingMode,
        "inputMin": inputMin,
        "inputMax": inputMax,
        "outputMinAngle": outputMinAngle,
        "outputMaxAngle": outputMaxAngle,
        "valueMappingPoints": valueMappingPoints
    })
    propertySchema: ({
        "bolshaya_rotation": {
            displayName: "Needle",
            type: "number", bindable: false,
            min: 0, max: 360, step: 1, unit: "°", hidden: true
        },
        "value": {
            displayName: "Value", type: "number", bindable: true,
            step: 0.1, order: 10
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
            displayName: "Input Min", type: "number", order: 21,
            visibleWhen: { property: "valueMappingMode", equals: "Linear" }
        },
        "inputMax": {
            displayName: "Input Max", type: "number", order: 22,
            visibleWhen: { property: "valueMappingMode", equals: "Linear" }
        },
        "outputMinAngle": {
            displayName: "Angle Min", type: "number", unit: "°", order: 23,
            visibleWhen: { property: "valueMappingMode", equals: "Linear" }
        },
        "outputMaxAngle": {
            displayName: "Angle Max", type: "number", unit: "°", order: 24,
            visibleWhen: { property: "valueMappingMode", equals: "Linear" }
        },
        "valueMappingPoints": {
            displayName: "Calibration Points", type: "calibrationPoints",
            order: 25,
            visibleWhen: { property: "valueMappingMode", equals: "ByPoints" }
        }
    })

    Item {
        id: scaledContent

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
            source: Qt.resolvedUrl("Pribor_004_background.svg")
            fillMode: Image.PreserveAspectFit
            smooth: true
        }

        // Большая стрелка
        Item {
            id: bigNeedlePivot
            objectName: "airspeedNeedle"

            x: root.bigCenterX
            y: root.bigCenterY

            width: 1
            height: 1

            rotation: root.editorCalibrationActive
                      ? root.editorCalibrationAngle : root.needleVisual
            transformOrigin: Item.Center

            AdaptiveSvgImage {
                source: Qt.resolvedUrl("Strelka_Pribor_004.svg")
                // Основание стрелки находится в pivot
                anchors.centerIn: parent
                smooth: true
                fillMode: Image.PreserveAspectFit
            }
        }
    }
}
