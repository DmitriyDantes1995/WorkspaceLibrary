import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root
    preserveAspectRatio: true

    property real n1_rotation: 0
    property real n2_rotation: 0
    property alias n1Value: root.n1_rotation
    property alias n2Value: root.n2_rotation
    property string n1MappingMode: "Linear"
    property real n1InputMin: 0
    property real n1InputMax: 360
    property real n1OutputMinAngle: 0
    property real n1OutputMaxAngle: 360
    property var n1MappingPoints: [{input:0,output:0},{input:360,output:360}]
    property string n2MappingMode: "Linear"
    property real n2InputMin: 0
    property real n2InputMax: 360
    property real n2OutputMinAngle: 0
    property real n2OutputMaxAngle: 360
    property var n2MappingPoints: [{input:0,output:0},{input:360,output:360}]

    readonly property real designWidth: 175.1
    readonly property real designHeight: 169.4
    readonly property real needleCenterX: designWidth / 2
    readonly property real needleCenterY: designHeight / 2

    supportsGaugeCalibration: true
    gaugeCalibrationChannels: [
        { id:"n1", title:"N1", valueProperty:"n1Value", mappingModeProperty:"n1MappingMode", inputMinProperty:"n1InputMin", inputMaxProperty:"n1InputMax", outputMinProperty:"n1OutputMinAngle", outputMaxProperty:"n1OutputMaxAngle", pointsProperty:"n1MappingPoints", centerX:needleCenterX*width/designWidth, centerY:needleCenterY*height/designHeight, angleOffset:90 },
        { id:"n2", title:"N2", valueProperty:"n2Value", mappingModeProperty:"n2MappingMode", inputMinProperty:"n2InputMin", inputMaxProperty:"n2InputMax", outputMinProperty:"n2OutputMinAngle", outputMaxProperty:"n2OutputMaxAngle", pointsProperty:"n2MappingPoints", centerX:needleCenterX*width/designWidth, centerY:needleCenterY*height/designHeight, angleOffset:90 }
    ]

    my_type: "EngineRpmIndicator"
    my_subtype: "EngineRpmIndicator"
    previewSource: "background.svg"

    width: designWidth
    height: designHeight

    customProperties: ({
        "n1_rotation": n1_rotation,
        "n2_rotation": n2_rotation,
        "n1Value": n1Value, "n1MappingMode": n1MappingMode,
        "n1InputMin": n1InputMin, "n1InputMax": n1InputMax,
        "n1OutputMinAngle": n1OutputMinAngle, "n1OutputMaxAngle": n1OutputMaxAngle,
        "n1MappingPoints": n1MappingPoints,
        "n2Value": n2Value, "n2MappingMode": n2MappingMode,
        "n2InputMin": n2InputMin, "n2InputMax": n2InputMax,
        "n2OutputMinAngle": n2OutputMinAngle, "n2OutputMaxAngle": n2OutputMaxAngle,
        "n2MappingPoints": n2MappingPoints
    })
    propertySchema: ({
        "n1_rotation": {
            displayName: "N1 needle",
            type: "number", bindable: false,
            min: 0, max: 360, step: 1, unit: "°", hidden: true
        },
        "n2_rotation": {
            displayName: "N2 needle",
            type: "number", bindable: false,
            min: 0, max: 360, step: 1, unit: "°", hidden: true
        },
        "n1Value": {displayName:"Value",type:"number",bindable:true,step:0.1,order:10,gaugeChannel:"n1"},
        "n1MappingMode": {displayName:"Mode",type:"enum",order:11,gaugeChannel:"n1",values:[{label:"Linear",value:"Linear"},{label:"By points",value:"ByPoints"}]},
        "n1InputMin": {displayName:"Input Min",type:"number",order:12,gaugeChannel:"n1",visibleWhen:{property:"n1MappingMode",equals:"Linear"}},
        "n1InputMax": {displayName:"Input Max",type:"number",order:13,gaugeChannel:"n1",visibleWhen:{property:"n1MappingMode",equals:"Linear"}},
        "n1OutputMinAngle": {displayName:"Angle Min",type:"number",unit:"°",order:14,gaugeChannel:"n1",visibleWhen:{property:"n1MappingMode",equals:"Linear"}},
        "n1OutputMaxAngle": {displayName:"Angle Max",type:"number",unit:"°",order:15,gaugeChannel:"n1",visibleWhen:{property:"n1MappingMode",equals:"Linear"}},
        "n1MappingPoints": {displayName:"Calibration Points",type:"calibrationPoints",order:16,gaugeChannel:"n1",visibleWhen:{property:"n1MappingMode",equals:"ByPoints"}},
        "n2Value": {displayName:"Value",type:"number",bindable:true,step:0.1,order:10,gaugeChannel:"n2"},
        "n2MappingMode": {displayName:"Mode",type:"enum",order:11,gaugeChannel:"n2",values:[{label:"Linear",value:"Linear"},{label:"By points",value:"ByPoints"}]},
        "n2InputMin": {displayName:"Input Min",type:"number",order:12,gaugeChannel:"n2",visibleWhen:{property:"n2MappingMode",equals:"Linear"}},
        "n2InputMax": {displayName:"Input Max",type:"number",order:13,gaugeChannel:"n2",visibleWhen:{property:"n2MappingMode",equals:"Linear"}},
        "n2OutputMinAngle": {displayName:"Angle Min",type:"number",unit:"°",order:14,gaugeChannel:"n2",visibleWhen:{property:"n2MappingMode",equals:"Linear"}},
        "n2OutputMaxAngle": {displayName:"Angle Max",type:"number",unit:"°",order:15,gaugeChannel:"n2",visibleWhen:{property:"n2MappingMode",equals:"Linear"}},
        "n2MappingPoints": {displayName:"Calibration Points",type:"calibrationPoints",order:16,gaugeChannel:"n2",visibleWhen:{property:"n2MappingMode",equals:"ByPoints"}}
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
            objectName: "engineRpmN1Needle"
            x: root.needleCenterX
            y: root.needleCenterY
            width: 0
            height: 0
            rotation: root.gaugeNeedleVisualAngle("n1")

            AdaptiveSvgImage {
                anchors.centerIn: parent
                source: Qt.resolvedUrl("n1_needle.svg")
                fillMode: Image.PreserveAspectFit
                smooth: true
                antialiasing: true
            }
        }

        Item {
            objectName: "engineRpmN2Needle"
            x: root.needleCenterX
            y: root.needleCenterY
            width: 0
            height: 0
            rotation: root.gaugeNeedleVisualAngle("n2")

            AdaptiveSvgImage {
                anchors.centerIn: parent
                source: Qt.resolvedUrl("n2_needle.svg")
                fillMode: Image.PreserveAspectFit
                smooth: true
                antialiasing: true
            }
        }
    }
}
