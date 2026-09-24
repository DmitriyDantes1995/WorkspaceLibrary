import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root
    preserveAspectRatio: true
    previewSource: "Podlogka_Pribor_005.svg"

    property real strelka_Alpha_Pribor_rotation: 0
    property real strelka_NY_Pribor_rotation: 0
    property alias strelka_Alpha_Pribor: root.strelka_Alpha_Pribor_rotation
    property alias strelka_NY_Pribor: root.strelka_NY_Pribor_rotation
    property alias alphaValue: root.strelka_Alpha_Pribor_rotation
    property alias loadFactorValue: root.strelka_NY_Pribor_rotation
    property string alphaMappingMode: "Linear"
    property real alphaInputMin: 0
    property real alphaInputMax: 360
    property real alphaOutputMinAngle: 0
    property real alphaOutputMaxAngle: 360
    property var alphaMappingPoints: [{input:0,output:0},{input:360,output:360}]
    property string loadFactorMappingMode: "Linear"
    property real loadFactorInputMin: 0
    property real loadFactorInputMax: 360
    property real loadFactorOutputMinAngle: 0
    property real loadFactorOutputMaxAngle: 360
    property var loadFactorMappingPoints: [{input:0,output:0},{input:360,output:360}]

    readonly property real designWidth: 400
    readonly property real designHeight: 415

    // Координаты центров в исходном макете
    readonly property real strelka_Alpha_PriborX: 200
    readonly property real strelka_Alpha_PriborY: 205

    readonly property real strelka_NY_PriborX: 203
    readonly property real strelka_NY_PriborY: 322

    supportsGaugeCalibration: true
    gaugeCalibrationChannels: [
        { id:"alpha", title:"Angle of attack", valueProperty:"alphaValue", mappingModeProperty:"alphaMappingMode", inputMinProperty:"alphaInputMin", inputMaxProperty:"alphaInputMax", outputMinProperty:"alphaOutputMinAngle", outputMaxProperty:"alphaOutputMaxAngle", pointsProperty:"alphaMappingPoints", centerX:strelka_Alpha_PriborX*width/designWidth, centerY:strelka_Alpha_PriborY*height/designHeight, angleOffset:90 },
        { id:"loadFactor", title:"Load factor", valueProperty:"loadFactorValue", mappingModeProperty:"loadFactorMappingMode", inputMinProperty:"loadFactorInputMin", inputMaxProperty:"loadFactorInputMax", outputMinProperty:"loadFactorOutputMinAngle", outputMaxProperty:"loadFactorOutputMaxAngle", pointsProperty:"loadFactorMappingPoints", centerX:strelka_NY_PriborX*width/designWidth, centerY:strelka_NY_PriborY*height/designHeight, angleOffset:90 }
    ]

    width: designWidth
    height: designHeight

    customProperties: ({
        "strelka_Alpha_Pribor": strelka_Alpha_Pribor_rotation,
        "strelka_NY_Pribor": strelka_NY_Pribor_rotation,
        "alphaValue": alphaValue, "alphaMappingMode": alphaMappingMode,
        "alphaInputMin": alphaInputMin, "alphaInputMax": alphaInputMax,
        "alphaOutputMinAngle": alphaOutputMinAngle, "alphaOutputMaxAngle": alphaOutputMaxAngle,
        "alphaMappingPoints": alphaMappingPoints,
        "loadFactorValue": loadFactorValue, "loadFactorMappingMode": loadFactorMappingMode,
        "loadFactorInputMin": loadFactorInputMin, "loadFactorInputMax": loadFactorInputMax,
        "loadFactorOutputMinAngle": loadFactorOutputMinAngle, "loadFactorOutputMaxAngle": loadFactorOutputMaxAngle,
        "loadFactorMappingPoints": loadFactorMappingPoints
    })
    propertySchema: ({
        "strelka_Alpha_Pribor": {
            displayName: "Alpha needle",
            type: "number", bindable: false,
            min: 0, max: 360, step: 1, unit: "°", hidden: true
        },
        "strelka_NY_Pribor": {
            displayName: "Load factor needle",
            type: "number", bindable: false,
            min: 0, max: 360, step: 1, unit: "°", hidden: true
        },
        "alphaValue": {displayName:"Value",type:"number",bindable:true,step:0.1,order:10,gaugeChannel:"alpha"},
        "alphaMappingMode": {displayName:"Mode",type:"enum",order:11,gaugeChannel:"alpha",values:[{label:"Linear",value:"Linear"},{label:"By points",value:"ByPoints"}]},
        "alphaInputMin": {displayName:"Input Min",type:"number",order:12,gaugeChannel:"alpha",visibleWhen:{property:"alphaMappingMode",equals:"Linear"}},
        "alphaInputMax": {displayName:"Input Max",type:"number",order:13,gaugeChannel:"alpha",visibleWhen:{property:"alphaMappingMode",equals:"Linear"}},
        "alphaOutputMinAngle": {displayName:"Angle Min",type:"number",unit:"°",order:14,gaugeChannel:"alpha",visibleWhen:{property:"alphaMappingMode",equals:"Linear"}},
        "alphaOutputMaxAngle": {displayName:"Angle Max",type:"number",unit:"°",order:15,gaugeChannel:"alpha",visibleWhen:{property:"alphaMappingMode",equals:"Linear"}},
        "alphaMappingPoints": {displayName:"Calibration Points",type:"calibrationPoints",order:16,gaugeChannel:"alpha",visibleWhen:{property:"alphaMappingMode",equals:"ByPoints"}},
        "loadFactorValue": {displayName:"Value",type:"number",bindable:true,step:0.1,order:10,gaugeChannel:"loadFactor"},
        "loadFactorMappingMode": {displayName:"Mode",type:"enum",order:11,gaugeChannel:"loadFactor",values:[{label:"Linear",value:"Linear"},{label:"By points",value:"ByPoints"}]},
        "loadFactorInputMin": {displayName:"Input Min",type:"number",order:12,gaugeChannel:"loadFactor",visibleWhen:{property:"loadFactorMappingMode",equals:"Linear"}},
        "loadFactorInputMax": {displayName:"Input Max",type:"number",order:13,gaugeChannel:"loadFactor",visibleWhen:{property:"loadFactorMappingMode",equals:"Linear"}},
        "loadFactorOutputMinAngle": {displayName:"Angle Min",type:"number",unit:"°",order:14,gaugeChannel:"loadFactor",visibleWhen:{property:"loadFactorMappingMode",equals:"Linear"}},
        "loadFactorOutputMaxAngle": {displayName:"Angle Max",type:"number",unit:"°",order:15,gaugeChannel:"loadFactor",visibleWhen:{property:"loadFactorMappingMode",equals:"Linear"}},
        "loadFactorMappingPoints": {displayName:"Calibration Points",type:"calibrationPoints",order:16,gaugeChannel:"loadFactor",visibleWhen:{property:"loadFactorMappingMode",equals:"ByPoints"}}
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
            source: Qt.resolvedUrl("Podlogka_Pribor_005.svg")
            fillMode: Image.PreserveAspectFit
            smooth: true
        }

        // Alfa стрелка
        Item {
            id: bigNeedlePivot
            objectName: "angleOfAttackNeedle"

            x: root.strelka_Alpha_PriborX
            y: root.strelka_Alpha_PriborY

            width: 1
            height: 1

            rotation: root.gaugeNeedleVisualAngle("alpha")
            transformOrigin: Item.Center

            AdaptiveSvgImage {
                source: Qt.resolvedUrl("Strelka_Alpha_Pribor_005.svg")
                // Основание стрелки находится в pivot
                anchors.centerIn: parent
                smooth: true
                fillMode: Image.PreserveAspectFit
            }
        }

        // NY стрелка
        Item {
            id: smallNeedlePivot
            objectName: "loadFactorNeedle"
            x: root.strelka_NY_PriborX
            y: root.strelka_NY_PriborY

            width: 0
            height: 0

            rotation: root.gaugeNeedleVisualAngle("loadFactor")
            transformOrigin: Item.TopLeft

            AdaptiveSvgImage {
                id: smallNeedleImage

                source: Qt.resolvedUrl("Strelka_NY_Pribor_005.svg")
                // Ось вращения: нижняя центральная точка изображения
                x: -width / 2
                y: -height

                smooth: true
                antialiasing: true
                fillMode: Image.PreserveAspectFit
            }
        }
    }
}
