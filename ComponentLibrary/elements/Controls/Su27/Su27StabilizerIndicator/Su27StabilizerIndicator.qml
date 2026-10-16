import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root
    my_type: "Su27StabilizerIndicator"
    my_subtype: "Su27StabilizerIndicator"
    previewSource: "preview.png"
    componentPath: "elements/Controls/Su27/Su27StabilizerIndicator/Su27StabilizerIndicator.qml"
    width: 56; height: 204
    preserveAspectRatio: true
    property real value: 0
    property real inputMin: -15
    property real inputMax: 20
    property real outputMinPosition: 1
    property real outputMaxPosition: 0
    readonly property real indicatorPosition: mapLinearValue(
        isFinite(value) ? value : 0, inputMin, inputMax, outputMinPosition, outputMaxPosition, true)
    customProperties: ({value:value,inputMin:inputMin,inputMax:inputMax,
        outputMinPosition:outputMinPosition,outputMaxPosition:outputMaxPosition})
    propertySchema: ({
        value:{displayName:"Stabilizer angle",type:"number",unit:"deg",min:-15,max:20,
            step:0.1,bindable:true,access:"readOnly"},
        inputMin:{displayName:"Input Min",type:"number",bindable:false},
        inputMax:{displayName:"Input Max",type:"number",bindable:false},
        outputMinPosition:{displayName:"Min position (0 top, 1 bottom)",type:"number",min:0,max:1,step:0.01,bindable:false},
        outputMaxPosition:{displayName:"Max position (0 top, 1 bottom)",type:"number",min:0,max:1,step:0.01,bindable:false}
    })
    onValueChanged:synchronizeState("value",value)
    onInputMinChanged:synchronizeState("inputMin",inputMin)
    onInputMaxChanged:synchronizeState("inputMax",inputMax)
    onOutputMinPositionChanged:synchronizeState("outputMinPosition",outputMinPosition)
    onOutputMaxPositionChanged:synchronizeState("outputMaxPosition",outputMaxPosition)
    function synchronizeState(name,state) {
        if(!customProperties)
            return
        if(customProperties[name] !== state) {
            customProperties[name] = state
            customPropertiesChanged()
        }
    }
    Item {
        width:56; height:204
        scale:Math.min(root.width/width,root.height/height)
        transformOrigin:Item.TopLeft
        x:(root.width-width*scale)/2; y:(root.height-height*scale)/2
        Rectangle { anchors.fill:parent; radius:4; color:"#252725"; border.color:"#66645b"; border.width:2 }
        Rectangle { x:5; y:5; width:46; height:194; radius:3; color:"#0d1513"; border.color:"#9b988a"; border.width:2 }
        Text { x:6; y:7; width:44; height:17; text:"\u041a\u0410\u0411\u0420."; font.family:"Arial"; font.pixelSize:12; font.bold:true; color:"#efecdb"; horizontalAlignment:Text.AlignHCenter }
        Rectangle { x:39; y:32; width:3; height:148; color:"#e1e4d5" }
        Repeater {
            model:8
            Rectangle {
                required property int index
                readonly property int tickValue:20-index*5
                x:tickValue === 0 ? 26 : 32
                y:32+index*148/7
                width:tickValue === 0 ? 16 : 10
                height:tickValue === 0 ? 3 : 2
                color:"#e9e8d8"
            }
        }
        Text { x:10; y:32+4*148/7-8; width:14; height:16; text:"0"; color:"#e9e8d8"; font.pixelSize:15; horizontalAlignment:Text.AlignHCenter }
        Rectangle { x:13; y:30; width:29; height:4; color:"#dadbd0" }
        Rectangle { x:13; y:179; width:29; height:4; color:"#dadbd0" }
        Rectangle {
            objectName:"stabilizerPointer"
            x:8; y:32+root.indicatorPosition*148-2
            width:30; height:4; color:"#9dd8be"; antialiasing:true
        }
        Rectangle { x:7; y:25; width:9; height:164; color:"#181e1b"; opacity:0.25 }
    }
}
