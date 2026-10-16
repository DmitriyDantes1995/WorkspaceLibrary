import QtQuick 2.15
import common_qml 1.0

Indicator {
    id: root
    my_type: "Su27Annunciator"
    my_subtype: "Su27Annunciator"
    componentPath: "elements/Controls/Su27/Su27Annunciator/Su27Annunciator.qml"
    previewSource: "preview.svg"
    width: 90
    height: 40
    preserveAspectRatio: false
    property string labelText: "ПИТАНИЕ"
    property string lightColor: "#efd7a0"
    property real fontSize: 14
    customProperties: ({value:value,labelText:labelText,lightColor:lightColor,fontSize:fontSize})
    propertySchema: ({
        value:{displayName:"Свечение",type:"number",min:0,max:1,step:1,bindable:true,access:"readOnly"},
        labelText:{displayName:"Надпись",type:"string",bindable:false},
        lightColor:{displayName:"Цвет свечения",type:"string",bindable:false},
        fontSize:{displayName:"Шрифт",type:"number",min:1,max:72,step:1,bindable:false}
    })
    function synchronize(name,next) {
        if (customProperties[name] !== next) {
            customProperties[name]=next
            customPropertiesChanged()
        }
    }
    onLabelTextChanged:synchronize("labelText",labelText)
    onLightColorChanged:synchronize("lightColor",lightColor)
    onFontSizeChanged:synchronize("fontSize",fontSize)
    Rectangle {
        anchors.fill:parent
        radius:2
        color:"#151b1e"
        border.color:"#78817b"
        border.width:Math.max(0.6,Math.min(width,height)*0.035)
        Rectangle {
            anchors.fill:parent
            anchors.margins:Math.min(parent.width,parent.height)*0.12
            radius:1
            color:root.value ? "#5a5540" : "#323b3e"
            border.color:"#111b1c"
            border.width:Math.max(0.5,height*0.025)
        }
        Text {
            objectName:"annunciatorLegend"
            anchors.fill:parent
            anchors.margins:Math.min(parent.width,parent.height)*0.18
            text:root.labelText
            color:root.value ? root.lightColor : "#a8b1a5"
            font.family:"Arial"
            font.pixelSize:Math.max(1,Math.min(root.fontSize,parent.height*0.35))
            fontSizeMode:Text.Fit
            minimumPixelSize:1
            wrapMode:Text.NoWrap
            horizontalAlignment:Text.AlignHCenter
            verticalAlignment:Text.AlignVCenter
        }
    }
}
