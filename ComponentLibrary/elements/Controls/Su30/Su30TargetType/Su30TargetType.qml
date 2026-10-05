import QtQuick 2.15
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
    // Tick endpoints in the drawn plate share the knob pivot at (46.35,53).
    readonly property var ticks:[{x:30.8,y:81.45},{x:46.35,y:21},{x:61.9,y:81.45}]
    function tickAngle(t){return Math.atan2(t.x-46.35,53-t.y)*180/Math.PI}
    angles:[tickAngle(ticks[0]),tickAngle(ticks[1]),tickAngle(ticks[2])]
    inputCenterX:visual.x+46.35*visual.scale
    inputCenterY:visual.y+53*visual.scale
    propertySchema:({value:{displayName:"Target type",type:"enum",bindable:true,access:"readWrite",
        values:[{label:"S",value:0},{label:"M",value:1},{label:"L",value:2}]}})
    Item {
        id:visual
        width:root.designWidth; height:root.designHeight
        scale:Math.min(root.width/width,root.height/height)
        transformOrigin:Item.TopLeft
        x:(root.width-width*scale)/2;y:(root.height-height*scale)/2
        AdaptiveSvgImage {anchors.fill:parent;source:Qt.resolvedUrl("scale.svg")}
        GainKnobVisual {
            id:knob
            objectName:"targetKnob"
            x:46.35-width/2;y:53-height/2
            rotation:root.visualAngle-knob.pointerAngle
        }
    }
}
