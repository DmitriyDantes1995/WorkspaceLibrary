import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root
    my_type: "WingConfigurationFace"
    my_subtype: "WingConfigurationFace"
    componentPath: "elements/Visual/SubstrateComponents/InstrumentFaces/WingConfigurationFace/WingConfigurationFace.qml"
    previewSource: "7.svg"
    readonly property real designWidth: 97.7
    readonly property real designHeight: 98
    width: designWidth
    height: designHeight
    preserveAspectRatio: true

    property bool noseGearOn: false
    property bool leftGearOn: false
    property bool rightGearOn: false
    property bool centerWarningOn: false
    property bool leftFlapOn: false
    property bool rightFlapOn: false
    property bool noseWarningOn: false
    property bool leftUpperFlapOn: false
    property bool rightUpperFlapOn: false

    customProperties: ({
        noseGearOn: noseGearOn,
        leftGearOn: leftGearOn,
        rightGearOn: rightGearOn,
        centerWarningOn: centerWarningOn,
        leftFlapOn: leftFlapOn,
        rightFlapOn: rightFlapOn,
        noseWarningOn: noseWarningOn,
        leftUpperFlapOn: leftUpperFlapOn,
        rightUpperFlapOn: rightUpperFlapOn
    })
    propertySchema: ({
        noseGearOn: { displayName: "Передняя стойка шасси", type: "bool", bindable: true },
        leftGearOn: { displayName: "Левая стойка шасси", type: "bool", bindable: true },
        rightGearOn: { displayName: "Правая стойка шасси", type: "bool", bindable: true },
        centerWarningOn: { displayName: "Красная лампа в центре", type: "bool", bindable: true },
        leftFlapOn: { displayName: "Левый закрылок — нижняя лампа", type: "bool", bindable: true },
        rightFlapOn: { displayName: "Правый закрылок — нижняя лампа", type: "bool", bindable: true },
        noseWarningOn: { displayName: "Жёлтая лампа над носом", type: "bool", bindable: true },
        leftUpperFlapOn: { displayName: "Левый закрылок — верхняя лампа", type: "bool", bindable: true },
        rightUpperFlapOn: { displayName: "Правый закрылок — верхняя лампа", type: "bool", bindable: true }
    })

    // Artwork and lamps share the original SVG coordinates at every size.
    Item {
        id: visualRoot
        objectName: "wingVisualRoot"
        width: root.designWidth
        height: root.designHeight
        scale: Math.min(root.width / width, root.height / height)
        transformOrigin: Item.TopLeft
        x: (root.width - width * scale) / 2
        y: (root.height - height * scale) / 2

        AdaptiveSvgImage {
            anchors.fill: parent
            source: Qt.resolvedUrl("7.svg")
            fillMode: Image.PreserveAspectFit
            smooth: true
        }
        Rectangle {
            objectName: "noseGearOnLamp"
            x: 47.35; y: 65
            width: 4; height: 8
            color: root.noseGearOn ? "#00d060" : "#202522"
        }
        Rectangle {
            objectName: "leftGearOnLamp"
            x: 30; y: 82
            width: 4; height: 8
            color: root.leftGearOn ? "#00d060" : "#202522"
        }
        Rectangle {
            objectName: "rightGearOnLamp"
            x: 64; y: 82
            width: 4; height: 8
            color: root.rightGearOn ? "#00d060" : "#202522"
        }
        Rectangle {
            objectName: "centerWarningOnLamp"
            x: 46.35; y: 42
            width: 6; height: 6
            radius: width / 2
            antialiasing: true
            color: root.centerWarningOn ? "#ff3030" : "#202522"
        }
        Rectangle {
            objectName: "leftFlapOnLamp"
            x: 8; y: 57
            width: 18; height: 2
            color: root.leftFlapOn ? "#00d060" : "#202522"
        }
        Rectangle {
            objectName: "rightFlapOnLamp"
            x: 72; y: 57
            width: 18; height: 2
            color: root.rightFlapOn ? "#00d060" : "#202522"
        }
        Rectangle {
            objectName: "leftUpperFlapOnLamp"
            x: 8; y: 43
            width: 18; height: 2
            color: root.leftUpperFlapOn ? "#00d060" : "#202522"
        }
        Rectangle {
            objectName: "rightUpperFlapOnLamp"
            x: 72; y: 43
            width: 18; height: 2
            color: root.rightUpperFlapOn ? "#00d060" : "#202522"
        }
        Rectangle {
            objectName: "noseWarningOnLamp"
            x: 46.35; y: 25
            width: 6; height: 2
            color: root.noseWarningOn ? "#ffd43b" : "#202522"
        }
    }
}
