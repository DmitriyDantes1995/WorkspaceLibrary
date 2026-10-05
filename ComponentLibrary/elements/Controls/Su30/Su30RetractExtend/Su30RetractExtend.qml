import QtQuick 2.15
import common_qml 1.0

ControlState {
    id: root
    my_type: "Su30RetractExtend"
    my_subtype: "Su30RetractExtend"
    componentPath: "elements/Controls/Su30/Su30RetractExtend/Su30RetractExtend.qml"
    previewSource: "preview.png"
    width: 90; height: 300
    propertySchema: ({value: {displayName:"Position", type:"enum", bindable:true, access:"readWrite",
        values:[{label:"УБР",value:0},{label:"ВЫП",value:1}]}})
    Item {
        id: visual
        width:90; height:300
        scale:Math.min(root.width/width,root.height/height)
        transformOrigin:Item.TopLeft
        x:(root.width-width*scale)/2; y:(root.height-height*scale)/2
        AdaptiveSvgImage {anchors.fill:parent; source:Qt.resolvedUrl("housing.svg")}
        Rectangle {
            objectName:"movingGrip"
            x:17; y:root.currentState === 0 ? 57 : 166; width:54; height:76
            color:"#bbcecb"; border.color:"#7f9694"; radius:2
            gradient:Gradient {
                GradientStop {position:0; color:"#d8e7e2"}
                GradientStop {position:0.5; color:"#a5bbb9"}
                GradientStop {position:1; color:"#d1e0da"}
            }
            Repeater {model:9; Rectangle {x:2; y:5+index*8; width:50; height:1; color:"#829b99"}}
        }
    }
    MouseArea {
        objectName:"leverInput"
        anchors.fill:parent; enabled:root.acceptsInput; preventStealing:true
        cursorShape:Qt.PointingHandCursor
        property real pressY:0
        property bool dragged:false
        onPressed:function(mouse){pressY=mouse.y;dragged=false}
        onPositionChanged:function(mouse){
            if(pressed && Math.abs(mouse.y-pressY)>8) dragged=true
        }
        onReleased:function(mouse){
            root.commitFromUser(dragged ? (mouse.y < root.height/2 ? 0 : 1) : 1-root.currentState)
        }
        onWheel:function(wheel){if(wheel.angleDelta.y)root.commitFromUser(wheel.angleDelta.y>0?0:1)}
    }
}
