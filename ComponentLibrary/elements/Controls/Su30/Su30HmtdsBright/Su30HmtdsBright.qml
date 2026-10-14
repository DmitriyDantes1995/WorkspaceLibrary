import QtQuick 2.15
import QtQuick.Shapes
import common_qml 1.0
import "../../simple/Toggles/Toggle_1" as RoundControl

RotaryAnalog {
    id: root
    my_type: "Su30HmtdsBright"
    my_subtype: "Su30HmtdsBright"
    componentPath: "elements/Controls/Su30/Su30HmtdsBright/Su30HmtdsBright.qml"
    previewSource: "preview.png"
    readonly property real designWidth: 70
    readonly property real designHeight: 70
    readonly property real dialCenterX: 28
    readonly property real dialCenterY: 42
    width: designWidth
    height: designHeight
    minimumValue: 0
    maximumValue: 100
    minimumAngle: 0
    maximumAngle: 300
    wheelStep: 1
    inputCenterX: visual.x + dialCenterX * visual.scale
    inputCenterY: visual.y + dialCenterY * visual.scale
    // A tapered brightness mark, concentric with the knob and its unchanged 0..300° travel.
    readonly property string brightnessPath: {
        var path="", innerRadius=22
        for(var i=0;i<=40;++i) {
            var fraction=i/40,angle=(minimumAngle+fraction*(maximumAngle-minimumAngle))*Math.PI/180
            var radius=innerRadius+0.5+2.5*fraction
            path+=(i===0?"M":"L")+(dialCenterX+Math.sin(angle)*radius)+" "+(dialCenterY-Math.cos(angle)*radius)+" "
        }
        for(var j=40;j>=0;--j) {
            var radians=(minimumAngle+j/40*(maximumAngle-minimumAngle))*Math.PI/180
            path+="L"+(dialCenterX+Math.sin(radians)*innerRadius)+" "+(dialCenterY-Math.cos(radians)*innerRadius)+" "
        }
        return path+"Z"
    }
    propertySchema: ({value: {displayName: "Яркость HMTDS · %", type: "number",
        min: 0, max: 100, step: 1, bindable: true, access: "readWrite"}})

    Item {
        id: visual
        width: root.designWidth
        height: root.designHeight
        scale: Math.min(root.width / width, root.height / height)
        transformOrigin: Item.TopLeft
        x: (root.width - width * scale) / 2
        y: (root.height - height * scale) / 2
        Text {x:4;y:2;text:"HMTDS BRIGHT";color:"white";font.family:"Arial";font.bold:true;font.pixelSize:8}
        RoundControl.CustomRoundSwitch {
            objectName: "brightnessKnob"
            width: 40
            height: 40
            x: root.dialCenterX - width / 2
            y: root.dialCenterY - height / 2
            rotation: root.visualAngle
        }
        Shape {
            objectName: "brightnessSymbol"
            anchors.fill:parent
            preferredRendererType:Shape.CurveRenderer
            asynchronous:true
            ShapePath {fillColor:"white";strokeColor:"transparent";PathSvg{path:root.brightnessPath}}
        }
    }
}
