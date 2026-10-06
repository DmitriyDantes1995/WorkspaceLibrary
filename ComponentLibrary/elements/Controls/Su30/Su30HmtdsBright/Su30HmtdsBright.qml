import QtQuick 2.15
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
        AdaptiveSvgImage {
            anchors.fill: parent
            source: Qt.resolvedUrl("plate.svg")
        }
        RoundControl.CustomRoundSwitch {
            objectName: "brightnessKnob"
            width: 40
            height: 40
            x: root.dialCenterX - width / 2
            y: root.dialCenterY - height / 2
            rotation: root.visualAngle
        }
        AdaptiveSvgImage {
            objectName: "brightnessSymbol"
            x: 49; y: 25
            width: 16; height: 24
            source: Qt.resolvedUrl("symbol.svg")
        }
    }
}
