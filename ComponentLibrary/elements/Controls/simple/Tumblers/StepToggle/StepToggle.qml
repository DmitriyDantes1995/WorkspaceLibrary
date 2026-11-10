import QtQuick 2.15
import common_qml 1.0
import "Looks.js" as Looks

BaseSceneComponent {
    id: root
    my_type: "StepToggle"
    my_subtype: my_type
    preserveAspectRatio: true
    implicitWidth: look.width
    implicitHeight: look.height
    previewSource: look.preview

    property bool runtimeMode: false
    property real pos: 0
    property string appearance: "graySquare"
    readonly property var catalogVariantProperties: ["appearance"]
    readonly property string catalogSection: "open"
    readonly property int catalogPositions: look.frames.length
    readonly property var look: Looks.entries[appearance] || Looks.entries.graySquare
    readonly property int currentPosition: Math.max(0, Math.min(look.frames.length - 1, Math.round(pos)))

    customProperties: ({ appearance: root.appearance, pos: root.pos })
    propertySchema: ({
        appearance: { displayName: qsTr("Appearance"), type: "enum", bindable: false,
            values: Object.keys(Looks.entries).map(function(key) {
                const style = Looks.entries[key]
                return { label: style.label, value: key, previewSource: Qt.resolvedUrl(style.preview) }
            }) },
        pos: { displayName: qsTr("Position"), type: "enum", bindable: true, access: "readWrite",
            values: root.look.frames.map(function(frame, index) {
                return { label: qsTr("Position %1").arg(index), value: index }
            }) }
    })

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl(root.look.frames[root.currentPosition])
        fillMode: Image.Stretch
    }

    MouseArea {
        anchors.fill: parent
        enabled: root.runtimeMode
        onClicked: {
            root.pos = (root.currentPosition + 1) % root.look.frames.length
            root.userPropertyChanged("pos", root.pos)
        }
    }
}
