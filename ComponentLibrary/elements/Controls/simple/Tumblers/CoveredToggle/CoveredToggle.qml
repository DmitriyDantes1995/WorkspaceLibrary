import QtQuick 2.15
import common_qml 1.0
import "Looks.js" as Looks

BaseSceneComponent {
    id: root
    my_type: "CoveredToggle"
    my_subtype: my_type
    preserveAspectRatio: true
    implicitWidth: look.width || artwork.implicitWidth
    implicitHeight: look.height || artwork.implicitHeight
    previewSource: look.frames[0]

    property bool runtimeMode: true
    property real oN: 0
    property bool lidOpen: false
    property string appearance: "red"
    readonly property var catalogVariantProperties: ["appearance"]
    readonly property string catalogSection: "covered"
    readonly property int catalogPositions: 2
    readonly property var look: Looks.entries[appearance] || Looks.entries.red
    readonly property bool raised: look.positionThreshold ? oN >= look.positionThreshold : oN === 1

    customProperties: ({ appearance: root.appearance, oN: root.oN })
    propertySchema: ({
        appearance: { displayName: qsTr("Appearance"), type: "enum", bindable: false,
            values: Object.keys(Looks.entries).map(function(key) {
                const style = Looks.entries[key]
                return { label: style.label, value: key, previewSource: Qt.resolvedUrl(style.frames[0]),
                         catalogHidden: key === "red" }
            }) },
        oN: { displayName: qsTr("Position"), type: "enum", bindable: true, access: "read",
            values: [{ label: qsTr("Down"), value: 0 }, { label: qsTr("Up"), value: 1 }] }
    })

    AdaptiveSvgImage {
        id: artwork
        anchors.fill: parent
        source: Qt.resolvedUrl(root.look.frames[root.lidOpen ? (root.raised ? 2 : 1) : 0])
        fillMode: Image.Stretch
    }

    MouseArea {
        anchors.fill: parent
        enabled: root.runtimeMode
        onClicked: root.lidOpen = !root.lidOpen
    }
}
