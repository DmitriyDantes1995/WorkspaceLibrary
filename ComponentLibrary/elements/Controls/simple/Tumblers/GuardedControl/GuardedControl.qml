pragma ComponentBehavior: Bound
import QtQuick 2.15
import common_qml 1.0
import "../../Buttons/RoundButton" as Buttons
import "Looks.js" as Looks

ControlState {
    id: root
    my_type: "GuardedControl"
    my_subtype: my_type
    property string appearance: "horizontal"
    readonly property var catalogVariantProperties: ["appearance", "marking"]
    property string marking: "conditioning"
    property int cover: 0
    property alias fire: fireButton.oN
    readonly property var variants: Looks.entries[appearance] || Looks.entries.horizontal
    readonly property var look: variants[marking] || variants[Object.keys(variants)[0]]
    readonly property bool hasMarkings: Object.keys(variants).length > 1
    readonly property bool hasFireButton: !!look.fire
    readonly property string catalogSection: look.button ? "coveredButtons" : "covered"
    readonly property int catalogPositions: stateCount
    implicitWidth: look.width
    implicitHeight: look.height
    maximumValue: look.maximum
    previewSource: look.preview || look.closed[0]

    onVariantsChanged: {
        if (!variants[marking])
            marking = Object.keys(variants)[0]
    }

    customProperties: {
        const values = { appearance: root.appearance, marking: root.marking,
                         value: root.value, cover: root.cover }
        if (hasFireButton)
            values.fire = root.fire
        return values
    }
    propertySchema: ({
        appearance: { displayName: qsTr("Guard"), type: "enum", bindable: false, order: 0,
            values: Object.keys(Looks.entries).map(function(key) {
                const variants = Looks.entries[key]
                const first = variants[Object.keys(variants)[0]]
                return { label: Looks.labels[key], value: key,
                         previewSource: Qt.resolvedUrl(first.preview || first.closed[0]) }
            }) },
        marking: { displayName: qsTr("Marking"), type: "enum", bindable: false, order: 1,
            visibleWhen: { property: "hasMarkings", equals: true },
            values: Object.keys(root.variants).map(function(key) {
                const variant = root.variants[key]
                return { label: variant.label, value: key,
                         previewSource: Qt.resolvedUrl(variant.preview || variant.closed[0]) }
            }) },
        value: { displayName: qsTr("Position"), type: "number", bindable: true, access: "readWrite",
            min: 0, max: root.maximumValue, step: 1, order: 2 },
        cover: { displayName: qsTr("Guard open"), type: "number", bindable: true,
            access: "readWrite", min: 0, max: 1, step: 1, order: 3 },
        fire: { displayName: qsTr("Fire extinguisher"), type: "number", bindable: true,
            access: "readWrite", min: 0, max: 1, step: 1, order: 4,
            visibleWhen: { property: "hasFireButton", equals: true } }
    })

    function setCoverFromUser(next) {
        if (cover === next) return
        cover = next
        userPropertyChanged("cover", cover)
    }

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl((root.cover === 1 ? root.look.open : root.look.closed)[root.currentState])
        fillMode: Image.PreserveAspectFit
    }

    Repeater {
        model: root.look.regions
        MouseArea {
            required property var modelData
            x: root.width * modelData.x
            y: root.height * modelData.y
            width: root.width * modelData.width
            height: root.height * modelData.height
            enabled: root.acceptsInput && (modelData.action === "open" ? root.cover === 0
                    : root.cover === 1 && (modelData.action !== "close" || root.value !== 1))
            preventStealing: true
            cursorShape: Qt.PointingHandCursor
            onPressed: {
                if (modelData.action === "open") root.setCoverFromUser(1)
                else if (modelData.action === "close") root.setCoverFromUser(0)
                else root.commitFromUser(modelData.state)
            }
        }
    }

    MomentaryButton {
        readonly property var region: root.look.button || [0, 0, 0, 0]
        x: root.width * region[0]
        y: root.height * region[1]
        width: root.width * region[2]
        height: root.height * region[3]
        runtimeMode: !!root.look.button && root.acceptsInput && root.cover === 1
        onUserPropertyChanged: function(name, value) { root.commitFromUser(value) }
    }

    Buttons.RoundButton {
        id: fireButton
        appearance: "red"
        valuePropertyName: "oN"
        readonly property var region: root.look.fire || [0, 0, 0, 0, 0]
        x: root.width * region[0]
        y: root.height * region[1]
        width: root.width * region[2]
        height: root.height * region[3]
        rotation: region[4]
        visible: root.hasFireButton
        runtimeMode: root.hasFireButton && root.acceptsInput
        onUserPropertyChanged: function(name, value) { root.userPropertyChanged("fire", value) }
    }
}
