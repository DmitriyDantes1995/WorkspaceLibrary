import QtQuick 2.15
import QtQuick.Shapes
import common_qml 1.0
import "../Su30RedTipToggle"

BaseSceneComponent {
    id: root
    my_type: "Su30MasterArmSwitch"
    my_subtype: "Su30MasterArmSwitch"
    componentPath: "elements/Controls/Su30/Su30MasterArmSwitch/Su30MasterArmSwitch.qml"
    previewSource: "preview.png"
    implicitWidth: 80
    implicitHeight: 100
    width: implicitWidth
    height: implicitHeight
    preserveAspectRatio: true

    property bool runtimeMode: false
    property alias value: toggle.value
    customProperties: ({ value: value })
    propertySchema: ({
        value: { displayName: "M/ARM switch position", type: "enum",
                 bindable: true, access: "readWrite",
                 values: [{label: "Down", value: 0}, {label: "Up", value: 1}] }
    })
    onValueChanged: {
        if (customProperties.value !== value) {
            customProperties.value = value
            customPropertiesChanged()
        }
    }

    Item {
        id: visualRoot
        objectName: "masterArmVisualRoot"
        width: 80
        height: 100
        scale: Math.min(root.width / width, root.height / height)
        transformOrigin: Item.TopLeft
        x: (root.width - width * scale) / 2
        y: (root.height - height * scale) / 2
        clip: true

        Rectangle {
            objectName: "masterArmStripedPlate"
            width: 80
            height: 80
            color: "#293c3d"
            clip: true
            Shape {
                anchors.fill: parent
                preferredRendererType: Shape.CurveRenderer
                asynchronous: true
                ShapePath {
                    fillColor: "transparent"
                    strokeColor: "#eef4ed"
                    strokeWidth: 8
                    capStyle: ShapePath.FlatCap
                    PathSvg {
                        path: "M -64 80 L 16 0 M -48 80 L 32 0 M -32 80 L 48 0 "
                              + "M -16 80 L 64 0 M 0 80 L 80 0 M 16 80 L 96 0 "
                              + "M 32 80 L 112 0 M 48 80 L 128 0 M 64 80 L 144 0 "
                              + "M 80 80 L 160 0"
                    }
                }
            }
        }
        Rectangle {
            x: 12
            y: 28
            width: 56
            height: 18
            color: "#233638"
        }
        Su30RedTipToggle {
            id: toggle
            objectName: "masterArmToggle"
            x: 8
            y: 4
            width: 64
            height: 82 * width / 48
            runtimeMode: root.runtimeMode
            onUserPropertyChanged: function(name, value) {
                root.userPropertyChanged(name, value)
            }
        }
    }
}
