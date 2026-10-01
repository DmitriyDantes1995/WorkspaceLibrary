import QtQuick 2.15
import common_qml 1.0

RotaryDiscrete {
    id: root
    my_type: "Su30TrainSelector"
    my_subtype: "Su30TrainSelector"
    componentPath: "elements/Controls/Su30/Su30TrainSelector/Su30TrainSelector.qml"
    previewSource: "preview.png"
    readonly property real designWidth: 106
    readonly property real designHeight: 138
    width: designWidth
    height: designHeight
    inputCenterX: visualRoot.x + 66 * visualRoot.scale
    inputCenterY: visualRoot.y + 91 * visualRoot.scale
    // Stroke centres in TrainSelectorFace/artwork.svg (Su30.jpg).
    function tickAngle(x, y) { return Math.atan2(x - 66, 91 - y) * 180 / Math.PI }
    angles: [tickAngle(35.5,110), tickAngle(31,90), tickAngle(33,71.5),
             tickAngle(47.5,55.5), tickAngle(66.5,48.5)]
    propertySchema: ({value: {displayName:"Position",type:"enum",bindable:true,access:"readWrite",
        values:[{label:"SCL",value:0},{label:"PART",value:1},{label:"0.1",value:2},
                {label:"0.2",value:3},{label:"0.4",value:4}]}})
    Item {
        id: visualRoot
        objectName: "visualRoot"
        width: root.designWidth; height: root.designHeight
        scale: Math.min(root.width / width, root.height / height)
        transformOrigin: Item.TopLeft
        x: (root.width - width * scale) / 2
        y: (root.height - height * scale) / 2
        AdaptiveSvgImage {
            objectName: "trainScale"
            anchors.fill: parent
            source: Qt.resolvedUrl("_parts/scale.svg")
            fillMode: Image.PreserveAspectFit
        }
        AdaptiveSvgImage {
            objectName: "trainKnob"
            width: 540 / 7; height: width
            x: 66 - width / 2; y: 91 - height / 2
            // Upper tip of the existing white stripe: (52,7), pivot: (45,45).
            rotation: root.visualAngle - Math.atan2(7,38) * 180 / Math.PI
            source: Qt.resolvedUrl("_parts/knob.svg")
            fillMode: Image.PreserveAspectFit
        }
    }
}
