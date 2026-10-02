import QtQuick 2.15
import common_qml 1.0
RotaryAnalog {
    id:root
    width:62; height:62
    property string label:""
    // Unbounded rotation in degrees, not a physical heading/pressure range.
    minimumValue:0; maximumValue:360
    minimumAngle:0; maximumAngle:360
    wheelStep:5
    function normalized(next) { return Number(next) }
    Item {
        anchors.fill:parent
        objectName:"rotatingVisual"
        rotation:root.value % 360
    AdaptiveSvgImage { anchors.fill:parent; source:Qt.resolvedUrl("knob.svg") }
    Repeater {
        model:root.label.length
        Text {
            required property int index
            readonly property real angle:(index-(root.label.length-1)/2)*28
            x:31+22*Math.sin(angle*Math.PI/180)-width/2
            y:31-22*Math.cos(angle*Math.PI/180)-height/2
            text:root.label.charAt(index); color:"#dce3de"; font.pixelSize:15; rotation:angle
        }
    }
    }
}
