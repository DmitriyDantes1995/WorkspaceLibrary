import QtQuick 2.15
import common_qml 1.0
import "Looks.js" as Looks

RotaryDiscrete {
    id: root
    my_type: "MultiPositionToggle"
    my_subtype: my_type
    property string appearance: "classic"
    readonly property var catalogVariantProperties: ["appearance"]
    readonly property string catalogSection: "open"
    readonly property int catalogPositions: angles.length
    readonly property var look: Looks.entries[appearance] || Looks.entries.classic
    implicitWidth: look.width
    implicitHeight: look.height
    angles: look.angles
    previewSource: frame(appearance, 0)

    customProperties: ({ appearance: root.appearance, value: root.value })
    propertySchema: ({
        appearance: { displayName: qsTr("Appearance"), type: "enum", bindable: false,
            values: Object.keys(Looks.entries).map(function(key) {
                return { label: Looks.entries[key].label, value: key,
                    previewSource: Qt.resolvedUrl(root.frame(key, 0)) }
            }) },
        value: { displayName: qsTr("Position"), type: "number", bindable: true, access: "readWrite",
            min: root.minimumValue, max: root.maximumValue, step: 1 }
    })

    function frame(key, position) {
        return (Looks.entries[key] || Looks.entries.classic).frames[position]
    }

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl(root.frame(root.appearance, root.currentState))
        fillMode: Image.PreserveAspectFit
    }
}
