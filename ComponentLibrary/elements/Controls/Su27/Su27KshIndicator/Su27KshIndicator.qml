import QtQuick 2.15
import common_qml 1.0
import "../../Su30KN/LeftBoard/Su30KNLeftKshScale/_parts"

BaseSceneComponent {
    id:root
    my_type:"Su27KshIndicator"
    my_subtype:"Su27KshIndicator"
    previewSource:"../../Su30KN/LeftBoard/Su30KNLeftKshScale/preview.svg"
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
    gaugeCalibrationCenterX: width / 2 + (scaleFace.pivotY - scaleFace.height / 2) * scaleFace.scale
    gaugeCalibrationCenterY: height / 2
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
    KshScaleFace {
        id: scaleFace
        anchors.centerIn: parent
        width: 137.1
        height: 129.55
        scale: Math.min(root.width / height, root.height / width)
        rotation: -90
        // The engraved card runs in the opposite direction, at 66° per unit
        // versus 70° for the saved calibration. Its 0.5 mark starts 57° from the pointer.
        readonly property real calibrationAngle: root.editorCalibrationActive
                                                  ? root.editorCalibrationAngle : root.scaleVisual
        cardAngle: 57 - (calibrationAngle + 35) * 66 / 70
    }
}
