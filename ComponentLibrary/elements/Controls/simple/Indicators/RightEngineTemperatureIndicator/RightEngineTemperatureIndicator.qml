import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root
    preserveAspectRatio: true
    previewSource: "Pribor_002_background.svg"

    property real bolshaya_rotation: 0
    property real malaya_rotation: 0
    property alias largeNeedleValue: root.bolshaya_rotation
    property alias smallNeedleValue: root.malaya_rotation
    property string largeNeedleMappingMode: "Linear"
    property real largeNeedleInputMin: 0
    property real largeNeedleInputMax: 360
    property real largeNeedleOutputMinAngle: 0
    property real largeNeedleOutputMaxAngle: 360
    property var largeNeedleMappingPoints: [{input:0,output:0},{input:360,output:360}]
    property string smallNeedleMappingMode: "Linear"
    property real smallNeedleInputMin: 0
    property real smallNeedleInputMax: 360
    property real smallNeedleOutputMinAngle: 0
    property real smallNeedleOutputMaxAngle: 360
    property var smallNeedleMappingPoints: [{input:0,output:0},{input:360,output:360}]

    readonly property real designWidth: 400
    readonly property real designHeight: 415

    readonly property real backgroundSourceWidth: 211.3
    readonly property real backgroundSourceHeight: 211.7
    readonly property real backgroundScale: Math.min(
        designWidth / backgroundSourceWidth,
        designHeight / backgroundSourceHeight)
    readonly property real backgroundOffsetX:
        (designWidth - backgroundSourceWidth * backgroundScale) / 2
    readonly property real backgroundOffsetY:
        (designHeight - backgroundSourceHeight * backgroundScale) / 2

    readonly property real bigCenterX:
        backgroundOffsetX + 105.1 * backgroundScale
    readonly property real bigCenterY:
        backgroundOffsetY + 106.6 * backgroundScale
    readonly property real smallCenterX:
        backgroundOffsetX + 106.1 * backgroundScale
    readonly property real smallCenterY:
        backgroundOffsetY + 165.3 * backgroundScale

    supportsGaugeCalibration: true
    gaugeCalibrationChannels: [
        {id:"large",title:"Large needle",valueProperty:"largeNeedleValue",mappingModeProperty:"largeNeedleMappingMode",inputMinProperty:"largeNeedleInputMin",inputMaxProperty:"largeNeedleInputMax",outputMinProperty:"largeNeedleOutputMinAngle",outputMaxProperty:"largeNeedleOutputMaxAngle",pointsProperty:"largeNeedleMappingPoints",centerX:bigCenterX*width/designWidth,centerY:bigCenterY*height/designHeight,angleOffset:-135},
        {id:"small",title:"Small needle",valueProperty:"smallNeedleValue",mappingModeProperty:"smallNeedleMappingMode",inputMinProperty:"smallNeedleInputMin",inputMaxProperty:"smallNeedleInputMax",outputMinProperty:"smallNeedleOutputMinAngle",outputMaxProperty:"smallNeedleOutputMaxAngle",pointsProperty:"smallNeedleMappingPoints",centerX:smallCenterX*width/designWidth,centerY:smallCenterY*height/designHeight,angleOffset:90}
    ]

    width: designWidth
    height: designHeight

    customProperties: ({
        "bolshaya_rotation": bolshaya_rotation,
        "malaya_rotation": malaya_rotation,
        "largeNeedleValue":largeNeedleValue,"largeNeedleMappingMode":largeNeedleMappingMode,"largeNeedleInputMin":largeNeedleInputMin,"largeNeedleInputMax":largeNeedleInputMax,"largeNeedleOutputMinAngle":largeNeedleOutputMinAngle,"largeNeedleOutputMaxAngle":largeNeedleOutputMaxAngle,"largeNeedleMappingPoints":largeNeedleMappingPoints,
        "smallNeedleValue":smallNeedleValue,"smallNeedleMappingMode":smallNeedleMappingMode,"smallNeedleInputMin":smallNeedleInputMin,"smallNeedleInputMax":smallNeedleInputMax,"smallNeedleOutputMinAngle":smallNeedleOutputMinAngle,"smallNeedleOutputMaxAngle":smallNeedleOutputMaxAngle,"smallNeedleMappingPoints":smallNeedleMappingPoints
    })
    propertySchema: ({
        "bolshaya_rotation": {
            displayName: "Large needle",
            type: "number", bindable: false,
            min: 0, max: 360, step: 1, unit: "°", hidden: true
        },
        "malaya_rotation": {
            displayName: "Small needle",
            type: "number", bindable: false,
            min: 0, max: 360, step: 1, unit: "°", hidden: true
        },
        "largeNeedleValue":{displayName:"Value",type:"number",bindable:true,step:0.1,order:10,gaugeChannel:"large"},"largeNeedleMappingMode":{displayName:"Mode",type:"enum",order:11,gaugeChannel:"large",values:[{label:"Linear",value:"Linear"},{label:"By points",value:"ByPoints"}]},"largeNeedleInputMin":{displayName:"Input Min",type:"number",order:12,gaugeChannel:"large",visibleWhen:{property:"largeNeedleMappingMode",equals:"Linear"}},"largeNeedleInputMax":{displayName:"Input Max",type:"number",order:13,gaugeChannel:"large",visibleWhen:{property:"largeNeedleMappingMode",equals:"Linear"}},"largeNeedleOutputMinAngle":{displayName:"Angle Min",type:"number",unit:"°",order:14,gaugeChannel:"large",visibleWhen:{property:"largeNeedleMappingMode",equals:"Linear"}},"largeNeedleOutputMaxAngle":{displayName:"Angle Max",type:"number",unit:"°",order:15,gaugeChannel:"large",visibleWhen:{property:"largeNeedleMappingMode",equals:"Linear"}},"largeNeedleMappingPoints":{displayName:"Calibration Points",type:"calibrationPoints",order:16,gaugeChannel:"large",visibleWhen:{property:"largeNeedleMappingMode",equals:"ByPoints"}},
        "smallNeedleValue":{displayName:"Value",type:"number",bindable:true,step:0.1,order:10,gaugeChannel:"small"},"smallNeedleMappingMode":{displayName:"Mode",type:"enum",order:11,gaugeChannel:"small",values:[{label:"Linear",value:"Linear"},{label:"By points",value:"ByPoints"}]},"smallNeedleInputMin":{displayName:"Input Min",type:"number",order:12,gaugeChannel:"small",visibleWhen:{property:"smallNeedleMappingMode",equals:"Linear"}},"smallNeedleInputMax":{displayName:"Input Max",type:"number",order:13,gaugeChannel:"small",visibleWhen:{property:"smallNeedleMappingMode",equals:"Linear"}},"smallNeedleOutputMinAngle":{displayName:"Angle Min",type:"number",unit:"°",order:14,gaugeChannel:"small",visibleWhen:{property:"smallNeedleMappingMode",equals:"Linear"}},"smallNeedleOutputMaxAngle":{displayName:"Angle Max",type:"number",unit:"°",order:15,gaugeChannel:"small",visibleWhen:{property:"smallNeedleMappingMode",equals:"Linear"}},"smallNeedleMappingPoints":{displayName:"Calibration Points",type:"calibrationPoints",order:16,gaugeChannel:"small",visibleWhen:{property:"smallNeedleMappingMode",equals:"ByPoints"}}
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
            source: Qt.resolvedUrl("Pribor_002_background.svg")
            fillMode: Image.PreserveAspectFit
            smooth: true
        }

        // Большая стрелка
        Item {
            id: bigNeedlePivot
            objectName: "rightTemperatureLargeNeedle"

            x: root.bigCenterX
            y: root.bigCenterY

            width: 0
            height: 0

            rotation: root.gaugeNeedleVisualAngle("large")
            transformOrigin: Item.TopLeft

            AdaptiveSvgImage {
                id: bigNeedleImage
                objectName: "rightTemperatureLargeNeedleImage"
                source: Qt.resolvedUrl("Strelka_bloshaya_pribor_002.svg")
                width: 211.9
                height: 220.1
                x: -104.9
                y: -105.8
                smooth: true
                fillMode: Image.PreserveAspectFit

                Item {
                    objectName: "rightTemperatureLargeNeedleAxis"
                    x: 104.9
                    y: 105.8
                    width: 0
                    height: 0
                }
            }
        }

        // Маленькая стрелка
        Item {
            id: smallNeedlePivot
            objectName: "rightTemperatureSmallNeedle"
            x: root.smallCenterX
            y: root.smallCenterY

            width: 0
            height: 0

            rotation: root.gaugeNeedleVisualAngle("small")
            transformOrigin: Item.TopLeft

            AdaptiveSvgImage {
                id: smallNeedleImage
                objectName: "rightTemperatureSmallNeedleImage"

                source: Qt.resolvedUrl("Strelka_malaya_pribor_002.svg")
                width: 10.8
                height: 57.8
                x: -5.4
                y: -28.9

                smooth: true
                antialiasing: true
                fillMode: Image.PreserveAspectFit

                Item {
                    objectName: "rightTemperatureSmallNeedleAxis"
                    x: 5.4
                    y: 28.9
                    width: 0
                    height: 0
                }
            }
        }
    }
}
