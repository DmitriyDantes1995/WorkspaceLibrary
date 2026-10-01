import QtQuick 2.15
import common_qml 1.0
import "_parts"

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

    // Midpoints of the seven engraved strokes in the original plate SVG,
    // ordered by their labels: 0, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0.
    // Use the artwork coordinates, not a uniform angular increment.
    function tickAngle(x, y) {
        return Math.atan2(x - dialCenterX, dialCenterY - y) * 180 / Math.PI
    }
    angles: [tickAngle(17.1, 78.9), tickAngle(18.3, 27.35),
             tickAngle(53.35, 26.95), tickAngle(67.95, 51.6),
             tickAngle(66.5, 62.05), tickAngle(61.4, 71.85),
             tickAngle(53.3, 80.1)]
    propertySchema: ({ "value": {
        displayName: "Position", type: "enum", bindable: true, access: "readWrite",
        values: [{ label: "0", value: 0 }, { label: "0.5", value: 1 },
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

        AdaptiveSvgImage {
            objectName: "gainScale"
            anchors.fill: parent
            source: Qt.resolvedUrl("_parts/scale.svg")
            fillMode: Image.PreserveAspectFit
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
