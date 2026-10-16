import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id:root
    my_type:"Su27Readout"
    my_subtype:"Su27Readout"
    previewSource:"preview.png"
    componentPath:"elements/Controls/Su27/Su27Readout/Su27Readout.qml"
    width:120; height:58
    property real value:0
    property int digits:2
    property int decimals:0
    property string labelText:""
    property string style:"drum"
    property bool blankWhenZero:false
    readonly property int digitCount:Math.min(12,Math.max(1,digits))
    readonly property int decimalCount:Math.min(6,Math.max(0,decimals),digitCount-1)
    readonly property string formattedText:formatValue(value)
    customProperties:({value:value,digits:digits,decimals:decimals,labelText:labelText,style:style,blankWhenZero:blankWhenZero})
    propertySchema:({
        value:{displayName:"Indicated value",type:"number",step:1,bindable:true,access:"readOnly"},
        digits:{displayName:"Digit positions",type:"number",min:1,max:12,step:1,bindable:false},
        decimals:{displayName:"Decimals",type:"number",min:0,max:6,step:1,bindable:false},
        labelText:{displayName:"Window label",type:"string",bindable:false},
        style:{displayName:"Window style",type:"enum",bindable:false,
            values:[{label:"Mechanical drum",value:"drum"},{label:"Electronic amber",value:"electronic"}]},
        blankWhenZero:{displayName:"Blank at zero",type:"bool",bindable:false}
    })
    onValueChanged:synchronizeState("value",value)
    onDigitsChanged:synchronizeState("digits",digits)
    onDecimalsChanged:synchronizeState("decimals",decimals)
    onLabelTextChanged:synchronizeState("labelText",labelText)
    onStyleChanged:synchronizeState("style",style)
    onBlankWhenZeroChanged:synchronizeState("blankWhenZero",blankWhenZero)
    function synchronizeState(name,state) {
        if(!customProperties)
            return
        if(customProperties[name] !== state) {
            customProperties[name]=state
            customPropertiesChanged()
        }
    }
    function formatValue(numericValue) {
        if(blankWhenZero && numericValue === 0)
            return new Array(digitCount+1).join(" ")
        if(!isFinite(numericValue))
            return new Array(digitCount+1).join("-")
        var negative=numericValue < 0
        var numberText=Math.abs(numericValue).toFixed(decimalCount)
        var count=numberText.length-(decimalCount > 0 ? 1 : 0)+(negative ? 1 : 0)
        if(count > digitCount)
            return new Array(digitCount+1).join("#")
        return (negative ? "-" : "")+new Array(digitCount-count+1).join("0")+numberText
    }
    Rectangle { anchors.fill:parent; radius:3; color:"#242723"; border.color:"#75786c"; border.width:Math.max(1,height*0.035) }
    Rectangle {
        x:root.width*0.06
        y:root.labelText.length ? root.height*0.3 : root.height*0.1
        width:root.width*0.88
        height:root.labelText.length ? root.height*0.59 : root.height*0.8
        radius:1; color:root.style === "electronic" ? "#000000" : "#090e0b"; border.color:"#575e50"; border.width:1
        clip:true
        Row {
            id:digitRow
            anchors.fill:parent; anchors.margins:2
            Repeater {
                model:root.formattedText.length
                Rectangle {
                    id:digitCell
                    required property int index
                    readonly property bool decimalPoint:root.formattedText.charAt(index) === "."
                    width:(digitRow.width / (root.digitCount + (root.decimalCount > 0 ? 0.3 : 0))) * (decimalPoint ? 0.3 : 1)
                    height:digitRow.height
                    color:root.style === "electronic" ? "#000000" : (decimalPoint ? "#101610" : (index % 2 ? "#182019" : "#131a15"))
                    border.color:"#090e0b"; border.width:root.style === "electronic" ? 0 : 0.6
                    Text {
                        anchors.fill:parent
                        text:digitCell.decimalPoint ? "" : root.formattedText.charAt(digitCell.index)
                        color:root.style === "electronic" ? "#ffb74d" : "#e5ebd5"; font.family:"Consolas"; font.bold:true
                        font.pixelSize:Math.max(1,digitCell.height*0.95)
                        minimumPixelSize:1; fontSizeMode:Text.Fit
                        horizontalAlignment:Text.AlignHCenter; verticalAlignment:Text.AlignVCenter
                    }
                    Rectangle {
                        visible:digitCell.decimalPoint
                        anchors.horizontalCenter:digitCell.horizontalCenter
                        y:digitCell.height*0.77
                        width:Math.max(2,digitCell.height*0.085); height:width; radius:width/2
                        color:root.style === "electronic" ? "#ffb74d" : "#e5ebd5"
                    }
                }
            }
        }
        Rectangle { visible:root.style === "drum"; anchors.top:parent.top; width:parent.width; height:parent.height*0.12; color:"#000000"; opacity:0.3 }
        Rectangle { visible:root.style === "drum"; anchors.bottom:parent.bottom; width:parent.width; height:parent.height*0.1; color:"#000000"; opacity:0.3 }
    }
    Text {
        visible:root.labelText.length > 0
        x:root.width*0.06; y:root.height*0.035; width:root.width*0.88; height:root.height*0.22
        text:root.labelText; color:"#e4dfbf"; font.family:"Arial"; font.pixelSize:Math.max(1,height*0.9)
        fontSizeMode:Text.Fit; minimumPixelSize:1
        horizontalAlignment:Text.AlignHCenter; verticalAlignment:Text.AlignVCenter
    }
}
