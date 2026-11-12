import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root
    my_type: "ScaledSelectorVisual"
    my_subtype: my_type
    preserveAspectRatio: true
    previewSource: look.face
    implicitWidth: look.width
    implicitHeight: look.height

    property string appearance: "wide"
    property real thinNeedlAngle: 0
    readonly property var catalogVariantProperties: ["appearance"]
    readonly property string catalogSection: "scaled"
    readonly property var looks: ({
        wide: {label: qsTr("Wide selector"), width: 147.5, height: 149, face: "_art/wide/background.svg"},
        square: {label: qsTr("Square selector"), width: 130, height: 130, face: "_art/square/background.svg"}
    })
    readonly property var look: looks[appearance] || looks.wide
    customProperties: ({appearance: appearance, thinNeedlAngle: thinNeedlAngle})
    propertySchema: ({
        appearance: {displayName: qsTr("Appearance"), type: "enum", bindable: false,
            values: Object.keys(looks).map(function(key) { return {label: looks[key].label, value: key} })},
        thinNeedlAngle: {displayName: qsTr("Angle"), type: "number", bindable: true,
            min: 0, max: 360, step: 1, unit: "°"}
    })

    Item {
        objectName: "visualRoot"
        width: root.look.width
        height: root.look.height
        anchors.centerIn: parent
        scale: Math.min(root.width / width, root.height / height)

        AdaptiveSvgImage {
            anchors.fill: parent
            source: Qt.resolvedUrl(root.look.face)
            fillMode: Image.PreserveAspectFit
        }
    }

    AdaptiveSvgImage {
        anchors.centerIn: parent
        width: 130
        height: width
        source: Qt.resolvedUrl("_art/handle.svg")
        fillMode: Image.PreserveAspectFit
        rotation: root.thinNeedlAngle
    }
}
