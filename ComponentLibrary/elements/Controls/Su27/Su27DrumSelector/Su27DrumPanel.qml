pragma ComponentBehavior: Bound
import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root
    my_type: "Su27DrumPanel"
    my_subtype: "Su27DrumPanel"
    componentPath: "elements/Controls/Su27/Su27DrumSelector/Su27DrumPanel.qml"
    readonly property string catalogLabel: "ВОЛНА · ШИФР · РАЗНОС"
    readonly property string catalogSection: "otherInstruments"
    width: columns.width
    height: columns.height
    preserveAspectRatio: true

    property bool runtimeMode: false
    property alias wave: waveControl.value
    property alias code: codeControl.value
    property alias spacing: spacingControl.value
    customProperties: ({ wave: wave, code: code, spacing: spacing })
    propertySchema: ({
        wave: waveControl.channelSchema,
        code: codeControl.channelSchema,
        spacing: spacingControl.channelSchema
    })

    component Channel: Su27DrumSelector {
        required property string propertyName
        required property int columnIndex
        readonly property var channelSchema: Object.assign({}, propertySchema.value, {
            displayName: profileNames[profile], order: columnIndex
        })
        runtimeMode: root.runtimeMode
        onValueChanged: {
            // A scene host can replace the initial bound map when restoring an instance.
            if (root.customProperties && root.customProperties[propertyName] !== value) {
                root.customProperties[propertyName] = value
                root.customPropertiesChanged()
            }
        }
        onUserPropertyChanged: function(name, next) {
            root.userPropertyChanged(propertyName, next)
        }
    }

    Row {
        id: columns
        anchors.centerIn: parent
        width: waveControl.width + codeControl.width + spacingControl.width
        height: waveControl.height
        scale: Math.min(root.width / width, root.height / height)
        Channel { id: waveControl; propertyName: "wave"; columnIndex: 0; profile: "aimWave" }
        Channel { id: codeControl; propertyName: "code"; columnIndex: 1; profile: "aimCode" }
        Channel { id: spacingControl; propertyName: "spacing"; columnIndex: 2; profile: "aimCarry" }
    }
}
