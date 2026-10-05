import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id:root
    my_type:"VerticalScaleIndicator"
    my_subtype:"VerticalScaleIndicator"
    componentPath:"elements/Controls/Su30/VerticalScaleIndicator/VerticalScaleIndicator.qml"
    previewSource:"preview.png"
    width:60;height:220
    property real value:0
    property real minimumValue:0
    property real maximumValue:300
    property int majorDivisions:3
    property int minorDivisions:5
    property real multiplier:100
    property string units:"kgf/cmВІ"
    property bool showUnits:true
    readonly property int tickCount:Math.max(1,majorDivisions)*Math.max(1,minorDivisions)
    customProperties:({value:value,minimumValue:minimumValue,maximumValue:maximumValue,
        majorDivisions:majorDivisions,minorDivisions:minorDivisions,multiplier:multiplier,units:units,showUnits:showUnits})
    propertySchema:({
        value:{displayName:"Value",type:"number",bindable:true,access:"readOnly",step:0.1},
        minimumValue:{displayName:"Minimum",type:"number",step:1},
        maximumValue:{displayName:"Maximum",type:"number",step:1},
        majorDivisions:{displayName:"Major divisions",type:"number",min:1,max:20,step:1},
        minorDivisions:{displayName:"Minor divisions",type:"number",min:1,max:10,step:1},
        multiplier:{displayName:"Scale multiplier",type:"number",min:0.001,max:1000000,step:1},
        units:{displayName:"Units",type:"string"},showUnits:{displayName:"Show units",type:"bool"}})
    function synchronizeState(name,v){
        if(customProperties[name]!==v){customProperties[name]=v;customPropertiesChanged()}
    }
    onValueChanged:synchronizeState("value",value)
    onMinimumValueChanged:synchronizeState("minimumValue",minimumValue)
    onMaximumValueChanged:synchronizeState("maximumValue",maximumValue)
    onMajorDivisionsChanged:synchronizeState("majorDivisions",majorDivisions)
    onMinorDivisionsChanged:synchronizeState("minorDivisions",minorDivisions)
    onMultiplierChanged:synchronizeState("multiplier",multiplier)
    onUnitsChanged:synchronizeState("units",units)
    onShowUnitsChanged:synchronizeState("showUnits",showUnits)
    Rectangle {
        anchors.fill:parent;color:"#30474a";border.color:"#8da6a1";border.width:Math.max(1,root.width/60)
        Text {x:0;y:2;width:parent.width;height:root.height*0.07;text:"Г—"+root.multiplier;color:"#c1d3ca";
            horizontalAlignment:Text.AlignHCenter;font.pixelSize:root.height*0.047;fontSizeMode:Text.Fit}
        Item {
            id:scaleArea
            x:root.width*0.09;y:root.height*0.105;width:root.width*0.8;height:root.height*0.82
            Rectangle {x:parent.width*0.9;width:root.width/60;height:parent.height;color:"#c1d3ca"}
            Repeater {
                model:root.tickCount+1
                Item {
                    required property int index
                    property bool major:index % Math.max(1,root.minorDivisions)===0
                    y:scaleArea.height*(1-index/root.tickCount)
                    width:scaleArea.width;height:1
                    Rectangle {x:scaleArea.width*(major?0.48:0.65);width:scaleArea.width*0.9-x;height:root.width/60;color:"#c1d3ca"}
                    Text {
                        visible:parent.major
                        x:0;y:-height/2;width:scaleArea.width*0.42;height:root.height*0.055
                        text:Number(((root.minimumValue+(root.maximumValue-root.minimumValue)*parent.index/root.tickCount)/root.multiplier).toFixed(3)).toString()
                        color:"#c1d3ca";font.pixelSize:root.height*0.053;horizontalAlignment:Text.AlignHCenter;fontSizeMode:Text.Fit
                    }
                }
            }
            Canvas {
                objectName:"scalePointer"
                x:scaleArea.width*0.43
                y:root.mapLinearValue(root.value,root.minimumValue,root.maximumValue,scaleArea.height,0,true)-height/2
                width:scaleArea.width*0.43;height:root.height*0.035
                onPaint:{var c=getContext("2d");c.clearRect(0,0,width,height);c.beginPath();c.moveTo(0,0);c.lineTo(width,height/2);c.lineTo(0,height);c.closePath();c.fillStyle="#e0f0df";c.fill()}
                onWidthChanged:requestPaint()
                onHeightChanged:requestPaint()
            }
        }
        Text {objectName:"scaleUnits";visible:root.showUnits;x:2;y:root.height*0.94;width:parent.width-4;height:root.height*0.055;
            text:root.units;color:"#c1d3ca";horizontalAlignment:Text.AlignHCenter;font.pixelSize:root.height*0.04;fontSizeMode:Text.Fit}
    }
}
