import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id:root
    my_type:"Su27KshIndicator"
    my_subtype:"Su27KshIndicator"
    previewSource:"preview.png"
    componentPath:"elements/Controls/Su27/Su27KshIndicator/Su27KshIndicator.qml"
    width:128; height:180
    preserveAspectRatio:true
    property real value:0.5
    property string valueMappingMode:"Linear"
    property real inputMin:0.5
    property real inputMax:3
    property real outputMinAngle:-35
    property real outputMaxAngle:140
    property var valueMappingPoints:[
        {input:0.5,output:-35},
        {input:3,output:140,preserveAngularDelta:true}
    ]
    readonly property real scaleVisual:mapGaugeValue(value,valueMappingMode,
        valueMappingPoints,inputMin,inputMax,outputMinAngle,outputMaxAngle,true)
    supportsGaugeCalibration:true
    gaugeCalibrationCenterX:(width-128*Math.min(width/128,height/180))/2+20*Math.min(width/128,height/180)
    gaugeCalibrationCenterY:height/2
    customProperties:({value:value,valueMappingMode:valueMappingMode,inputMin:inputMin,inputMax:inputMax,
        outputMinAngle:outputMinAngle,outputMaxAngle:outputMaxAngle,valueMappingPoints:valueMappingPoints})
    propertySchema:({
        value:{displayName:"Ksh indication",type:"number",min:0.5,max:3,step:0.01,bindable:true,access:"readOnly"},
        valueMappingMode:{displayName:"Scale mapping",type:"enum",bindable:false,
            values:[{label:"Linear",value:"Linear"},{label:"By points",value:"ByPoints"}]},
        inputMin:{displayName:"Input Min",type:"number",bindable:false},
        inputMax:{displayName:"Input Max",type:"number",bindable:false},
        outputMinAngle:{displayName:"Scale angle Min",type:"number",unit:"deg",bindable:false},
        outputMaxAngle:{displayName:"Scale angle Max",type:"number",unit:"deg",bindable:false},
        valueMappingPoints:{displayName:"Calibration Points",type:"calibrationPoints",bindable:false}
    })
    onValueChanged:synchronizeState("value",value)
    onValueMappingModeChanged:synchronizeState("valueMappingMode",valueMappingMode)
    onInputMinChanged:synchronizeState("inputMin",inputMin)
    onInputMaxChanged:synchronizeState("inputMax",inputMax)
    onOutputMinAngleChanged:synchronizeState("outputMinAngle",outputMinAngle)
    onOutputMaxAngleChanged:synchronizeState("outputMaxAngle",outputMaxAngle)
    onValueMappingPointsChanged:synchronizeState("valueMappingPoints",valueMappingPoints)
    function synchronizeState(name,state) {
        if(!customProperties)return
        if(customProperties[name] !== state) {
            customProperties[name]=state
            customPropertiesChanged()
        }
    }
    Item {
        id:visual
        width:128;height:180
        scale:Math.min(root.width/width,root.height/height)
        transformOrigin:Item.TopLeft
        x:(root.width-width*scale)/2;y:(root.height-height*scale)/2
        Canvas {
            anchors.fill:parent
            onPaint: {
                var c=getContext("2d")
                c.reset();c.clearRect(0,0,width,height)
                c.strokeStyle="#babdad";c.lineWidth=2
                c.beginPath();c.arc(20,90,80,-Math.PI/2,Math.PI/2);c.stroke()
                c.strokeStyle="#727e73";c.lineWidth=1
                c.beginPath();c.arc(20,90,84,-Math.PI/2,Math.PI/2);c.stroke()
                c.beginPath();c.moveTo(20,6);c.lineTo(20,174);c.stroke()
                c.fillStyle="#eeeede"
                c.beginPath();c.moveTo(111,83);c.lineTo(95,90);c.lineTo(111,97);c.closePath();c.fill()
            }
        }
        Item {
            x:20;y:8;width:74;height:164
            clip:true
            Item {
                id:scaleItem
                objectName:"kshScale"
                x:0;y:82
                rotation:root.editorCalibrationActive ? root.editorCalibrationAngle : root.scaleVisual
                Repeater {
                    model:26
                    Item {
                        required property int index
                        rotation:125-index*7
                        Rectangle { x: index%5 === 0 ? -1.5 : -0.7; y:-75; width:index%5 === 0 ? 3 : 1.4; height:index%5 === 0 ? 11 : 5; color:"#e9eadb"; antialiasing:true }
                    }
                }
                Repeater {
                    model:6
                    Text {
                        required property int index
                        readonly property real angle:(125-index*35)*Math.PI/180
                        x:Math.sin(angle)*54-width/2
                        y:-Math.cos(angle)*54-height/2
                        width:29;height:19
                        text:(0.5+index*0.5).toFixed(index%2 === 0 ? 1 : 0)
                        color:"#ececdd";font.family:"Arial";font.pixelSize:17
                        rotation:-scaleItem.rotation
                        horizontalAlignment:Text.AlignHCenter;verticalAlignment:Text.AlignVCenter
                    }
                }
            }
        }
    }
}
