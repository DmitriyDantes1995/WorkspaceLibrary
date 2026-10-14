import QtQuick 2.15
import QtQuick.Shapes
import common_qml 1.0

RotaryDiscrete {
    id: root
    my_type: "TpGain"
    my_subtype: "TpGain"
    componentPath: "elements/Controls/Other/TpGain/TpGain.qml"
    previewSource: "preview.png"
    readonly property real designWidth: 92.7
    readonly property real designHeight: 92.9
    width: designWidth
    height: designHeight

    // SVG dial centre (not the centre of the rectangular plate).
    readonly property real dialCenterX: 36.0
    readonly property real dialCenterY: 53.0
    inputCenterX: visualRoot.x + dialCenterX * visualRoot.scale
    inputCenterY: visualRoot.y + dialCenterY * visualRoot.scale

    // Preserve the existing detents exactly; the scale now follows these angles.
    angles: [-143.88065915052024, -34.6079454105833, 33.66468171483053,
             87.49099180556927, 106.52674504266514, 126.58007006028659, 147.4468004471465]
    readonly property real scaleRadius: 28
    readonly property real tickLength: 4
    function scalePoint(angle, radius) {
        var radians = angle * Math.PI / 180
        return Qt.point(dialCenterX + Math.sin(radians) * radius,
                        dialCenterY - Math.cos(radians) * radius)
    }
    propertySchema: ({ "value": {
        displayName: "Position", type: "enum", bindable: true, access: "readWrite",
        values: [{ label: "0.4", value: 0 }, { label: "0.5", value: 1 },
                 { label: "0.6", value: 2 }, { label: "0.7", value: 3 },
                 { label: "0.8", value: 4 }, { label: "0.9", value: 5 },
                 { label: "1.0", value: 6 }]
    } })

    Item {
        id: visualRoot
        objectName: "visualRoot"
        width: root.designWidth
        height: root.designHeight
        scale: Math.min(root.width / width, root.height / height)
        transformOrigin: Item.TopLeft
        x: (root.width - width * scale) / 2
        y: (root.height - height * scale) / 2

        Text {
            x: 4; y: 2; text: "AMPLFCN HDF"
            color: "white"; font.family: "Arial"; font.bold: true; font.pixelSize: 8
        }
        Shape {
            objectName: "gainScale"
            anchors.fill: parent
            preferredRendererType: Shape.CurveRenderer
            asynchronous: true
            ShapePath {
                fillColor: "transparent"; strokeColor: "white"; strokeWidth: 1
                PathAngleArc {
                    centerX: root.dialCenterX; centerY: root.dialCenterY
                    radiusX: root.scaleRadius; radiusY: root.scaleRadius
                    startAngle: root.angles[0] - 90
                    sweepAngle: root.angles[root.angles.length - 1] - root.angles[0]
                }
            }
        }
        Repeater {
            model: root.propertySchema.value.values
            delegate: Item {
                required property int index
                required property var modelData
                anchors.fill: parent
                readonly property real angle: root.angles[index]
                readonly property point innerPoint: root.scalePoint(angle, root.scaleRadius)
                readonly property point outerPoint: root.scalePoint(angle, root.scaleRadius + root.tickLength)
                Shape {
                    anchors.fill: parent
                    preferredRendererType: Shape.CurveRenderer
                    asynchronous: true
                    ShapePath {
                        fillColor: "transparent"; strokeColor: "white"; strokeWidth: 1
                        startX: innerPoint.x; startY: innerPoint.y
                        PathLine {x: outerPoint.x; y: outerPoint.y}
                    }
                }
                Text {
                    objectName: "scaleLabel_" + index
                    text: modelData.label
                    color: "white"; font.family: "Arial"; font.bold: true; font.pixelSize: 7
                    readonly property real radians: angle * Math.PI / 180
                    // Constant clearance from the tick end to the text's bounding box.
                    readonly property real labelRadius: root.scaleRadius + root.tickLength + 2
                        + (implicitWidth * Math.abs(Math.sin(radians)) + implicitHeight * Math.abs(Math.cos(radians))) / 2
                    x: root.scalePoint(angle, labelRadius).x - implicitWidth / 2
                    y: root.scalePoint(angle, labelRadius).y - implicitHeight / 2
                }
            }
        }
        GainKnobVisual {
            id: knob
            objectName: "gainKnob"
            x: root.dialCenterX - width / 2
            y: root.dialCenterY - height / 2
            // The supplied knob's circular pointer is at (30.15, 33.8).
            // Its original direction belongs to the artwork, not the scale.
            rotation: root.visualAngle - knob.pointerAngle
        }
    }
}
