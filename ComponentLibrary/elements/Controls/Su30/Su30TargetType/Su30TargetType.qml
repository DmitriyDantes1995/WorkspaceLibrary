import QtQuick 2.15
import QtQuick.Shapes
import common_qml 1.0

RotaryDiscrete {
    id:root
    my_type:"Su30TargetType"
    my_subtype:"Su30TargetType"
    componentPath:"elements/Controls/Su30/Su30TargetType/Su30TargetType.qml"
    previewSource:"preview.png"
    readonly property real designWidth:92.7
    readonly property real designHeight:92.9
    width:designWidth; height:designHeight
    readonly property real dialCenterX:46.35
    readonly property real dialCenterY:53
    // Preserve the existing S/M/L detents.
    angles:[-151.34017782851353,0,151.34017782851353]
    inputCenterX:visual.x+dialCenterX*visual.scale
    inputCenterY:visual.y+dialCenterY*visual.scale
    readonly property real scaleRadius:25
    readonly property real tickLength:4
    function scalePoint(angle,radius) {
        var radians=angle*Math.PI/180
        return Qt.point(dialCenterX+Math.sin(radians)*radius,dialCenterY-Math.cos(radians)*radius)
    }
    propertySchema:({value:{displayName:"Target type",type:"enum",bindable:true,access:"readWrite",
        values:[{label:"S",value:0},{label:"M",value:1},{label:"L",value:2}]}})
    Item {
        id:visual
        width:root.designWidth; height:root.designHeight
        scale:Math.min(root.width/width,root.height/height)
        transformOrigin:Item.TopLeft
        x:(root.width-width*scale)/2;y:(root.height-height*scale)/2
        Text {x:0;y:2;width:parent.width;horizontalAlignment:Text.AlignHCenter;text:"TARGET TYPE";color:"white";font.family:"Arial";font.bold:true;font.pixelSize:8}
        Shape {
            anchors.fill:parent;preferredRendererType:Shape.CurveRenderer;asynchronous:true
            ShapePath {
                fillColor:"transparent";strokeColor:"white";strokeWidth:1
                PathAngleArc {centerX:root.dialCenterX;centerY:root.dialCenterY;radiusX:root.scaleRadius;radiusY:root.scaleRadius;startAngle:root.angles[0]-90;sweepAngle:root.angles[2]-root.angles[0]}
            }
        }
        Repeater {
            model:root.propertySchema.value.values
            delegate:Item {
                required property int index
                required property var modelData
                anchors.fill:parent
                readonly property real angle:root.angles[index]
                readonly property point innerPoint:root.scalePoint(angle,root.scaleRadius)
                readonly property point outerPoint:root.scalePoint(angle,root.scaleRadius+root.tickLength)
                Shape {
                    anchors.fill:parent;preferredRendererType:Shape.CurveRenderer;asynchronous:true
                    ShapePath {fillColor:"transparent";strokeColor:"white";strokeWidth:1;startX:innerPoint.x;startY:innerPoint.y;PathLine{x:outerPoint.x;y:outerPoint.y}}
                }
                Text {
                    objectName:"scaleLabel_"+index;text:modelData.label;color:"white";font.family:"Arial";font.bold:true;font.pixelSize:7
                    readonly property real radians:angle*Math.PI/180
                    readonly property real labelRadius:root.scaleRadius+root.tickLength+2
                        +(implicitWidth*Math.abs(Math.sin(radians))+implicitHeight*Math.abs(Math.cos(radians)))/2
                    x:root.scalePoint(angle,labelRadius).x-implicitWidth/2
                    y:root.scalePoint(angle,labelRadius).y-implicitHeight/2
                }
            }
        }
        GainKnobVisual {
            id:knob
            objectName:"targetKnob"
            x:root.dialCenterX-width/2;y:root.dialCenterY-height/2
            rotation:root.visualAngle-knob.pointerAngle
        }
    }
}
