import QtQuick 2.15
import common_qml 1.0

MomentaryButton {
    id: root
    my_type: "Su27Key"
    my_subtype: "Su27Key"
    componentPath: "elements/Controls/Su27/Su27Key/Su27Key.qml"
    previewSource: "preview.svg"
    width: 64
    height: 60
    preserveAspectRatio: false

    property string labelText: "СБРОС"
    property string style: "pnk"
    property bool illuminated: false
    property string lampColor: "#e3edbc"
    property real fontSize: 18
    readonly property bool roundFace: style === "round"
    readonly property bool hasLamp: style === "sau" || style === "target"

    customProperties: ({value:value, labelText:labelText, style:style,
                        illuminated:illuminated, lampColor:lampColor, fontSize:fontSize})
    propertySchema: ({
        value: {displayName:"Нажатие", type:"enum", bindable:true, access:"readWrite",
            values:[{label:"Отпущена",value:0},{label:"Нажата",value:1}]},
        illuminated: {displayName:"Подсветка",type:"bool",bindable:true,access:"readOnly"},
        labelText: {displayName:"Надпись",type:"string",bindable:false},
        style: {displayName:"Исполнение",type:"enum",bindable:false,
            values:[{label:"ПНК",value:"pnk"},{label:"Цели",value:"target"},
                    {label:"САУ",value:"sau"},{label:"Круглая кнопка",value:"round"}]},
        lampColor: {displayName:"Цвет подсветки",type:"string",bindable:false},
        fontSize: {displayName:"Шрифт",type:"number",min:1,max:72,step:1,bindable:false}
    })
    function synchronize(name, next) {
        if (customProperties[name] !== next) {
            customProperties[name] = next
            customPropertiesChanged()
        }
    }
    onLabelTextChanged: synchronize("labelText",labelText)
    onStyleChanged: synchronize("style",style)
    onIlluminatedChanged: synchronize("illuminated",illuminated)
    onLampColorChanged: synchronize("lampColor",lampColor)
    onFontSizeChanged: synchronize("fontSize",fontSize)

    Rectangle {
        id: bezel
        objectName: "keyBezel"
        anchors.centerIn: parent
        width: root.roundFace ? Math.min(root.width,root.height) : root.width
        height: root.roundFace ? width : root.height
        radius: root.roundFace ? width/2 : Math.min(5, height*0.1)
        color: root.roundFace ? "#89938c" : "#161b1e"
        border.color: root.roundFace ? "#b9c1af" : "#758181"
        border.width: Math.max(0.6,Math.min(width,height)*0.025)
        Rectangle {
            anchors.fill: parent
            anchors.margins: Math.min(parent.width,parent.height)*0.09
            radius: root.roundFace ? width/2 : Math.min(4,height*0.1)
            color: root.roundFace ? (root.value ? "#a6ada4" : "#eee9ce")
                   : root.value ? "#515a5d" : "#2b3235"
            border.color: root.value ? "#111b1b" : "#aab5af"
            border.width: Math.max(0.5,Math.min(width,height)*0.018)
        }
        Rectangle {
            visible: root.hasLamp
            x: parent.width*0.77
            y: parent.height*0.08
            width: Math.min(parent.width,parent.height)*0.14
            height: width
            radius: width/2
            color: root.illuminated ? root.lampColor : "#213f37"
            border.color: "#8a9b8a"
            border.width: Math.max(0.5,width*0.1)
        }
        Text {
            objectName: "keyLegend"
            x: parent.width*0.13
            y: parent.height*0.15 + (root.value ? parent.height*0.035 : 0)
            width: parent.width*0.74
            height: parent.height*0.7
            text: root.labelText
            color: root.roundFace ? "#343d37" : root.illuminated ? root.lampColor : "#e4e5d5"
            font.family: "Arial"
            font.pixelSize: Math.max(1,Math.min(root.fontSize,parent.height*0.3))
            fontSizeMode: Text.Fit
            minimumPixelSize: 1
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.NoWrap
        }
    }
}
