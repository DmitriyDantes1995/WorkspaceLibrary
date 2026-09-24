import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root
    preserveAspectRatio: true
    previewSource: "Pribor_003_background.svg"

    property real bolshaya_rotation: 0
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

    readonly property real backgroundSourceWidth: 339.1
    readonly property real backgroundSourceHeight: 389.7
    readonly property real backgroundScale: Math.min(
        designWidth / backgroundSourceWidth,
        designHeight / backgroundSourceHeight)
    readonly property real backgroundOffsetX:
        (designWidth - backgroundSourceWidth * backgroundScale) / 2
    readonly property real backgroundOffsetY:
        (designHeight - backgroundSourceHeight * backgroundScale) / 2

    // Main dial center measured in Pribor_003_background.svg.
    readonly property real bigCenterX:
        backgroundOffsetX + 170.2 * backgroundScale
    readonly property real bigCenterY:
        backgroundOffsetY + 169.4 * backgroundScale

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
            source: Qt.resolvedUrl("Pribor_003_background.svg")
            fillMode: Image.PreserveAspectFit
            smooth: true
        }

        // Большая стрелка
        Item {
            id: bigNeedlePivot
            objectName: "radarAltimeterNeedle"

            x: root.bigCenterX
            y: root.bigCenterY

            width: 0
            height: 0

            rotation: root.editorCalibrationActive
                      ? root.editorCalibrationAngle : root.needleVisual
            transformOrigin: Item.TopLeft

            AdaptiveSvgImage {
                id: bigNeedleImage
                objectName: "radarAltimeterNeedleImage"
                source: Qt.resolvedUrl("Strelka_Pribor_003.svg")
                width: 14
                height: 255.5
                x: -6.35
                y: -128
                smooth: true
                fillMode: Image.PreserveAspectFit

                // Mechanical base measured in the SVG canvas.
                Item {
                    objectName: "radarAltimeterNeedleAxis"
                    x: 6.35
                    y: 128
                    width: 0
                    height: 0
                }
            }
        }
    }
}
