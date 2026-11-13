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
    readonly property var catalogVariantProperties: ["appearance"]
    // Old scenes may still refer to artwork with baked-in markings.
    property string marking: "standard"
    property int cover: 0
    property string coverPropertyName: "cover"
    property bool guardOpen: false
    readonly property bool usesGuardOpen: coverPropertyName === "guardOpen"
    readonly property bool isCoverOpen: usesGuardOpen ? guardOpen : cover === 1
    // Optional hardware codes in the same order as the artwork frames.
    property var positionValues: []
    property int fire: 0
    readonly property var look: Looks.resolve(appearance, marking)
    readonly property bool hasFireButton: !!look.fire
    readonly property string catalogSection: look.button ? "coveredButtons" : "covered"
    readonly property int catalogPositions: stateCount
    readonly property int frameIndex: positionValues.length ? positionValues.indexOf(currentState) : currentState
    readonly property var coverValue: usesGuardOpen ? guardOpen : cover
    implicitWidth: look.width
    implicitHeight: look.height
    maximumValue: look.maximum
    previewSource: look.closed[0]

    customProperties: {
        const values = { appearance: root.appearance, value: root.value,
                         [root.coverPropertyName]: root.coverValue }
        if (root.coverPropertyName !== "cover")
            values.coverPropertyName = root.coverPropertyName
        if (root.positionValues.length)
            values.positionValues = root.positionValues
        if (root.marking !== "standard")
            values.marking = root.marking
        if (hasFireButton)
            values.fire = root.fire
        return values
    }
    propertySchema: ({
        appearance: { displayName: qsTr("Guard"), type: "enum", bindable: false, order: 0,
            values: Object.keys(Looks.entries).map(function(key) {
                const style = Looks.entries[key]
                return { label: style.label, value: key,
                         previewSource: Qt.resolvedUrl(style.closed[0]) }
            }) },
        marking: { hidden: true, bindable: false },
        coverPropertyName: { hidden: true, bindable: false },
        positionValues: { hidden: true, bindable: false },
        value: { displayName: qsTr("Position"), type: "number", bindable: true, access: "readWrite",
            min: 0, max: root.maximumValue, step: 1, order: 2 },
        [root.coverPropertyName]: { displayName: qsTr("Guard open"),
            type: root.usesGuardOpen ? "bool" : "number", bindable: true,
            access: "readWrite", min: 0, max: 1, step: 1, order: 3 },
        fire: { displayName: qsTr("Fire extinguisher"), type: "number", bindable: true,
            access: "readWrite", min: 0, max: 1, step: 1, order: 4,
            visibleWhen: { property: "hasFireButton", equals: true } }
    })

    function setCoverFromUser(open) {
        if (isCoverOpen === open) return
        if (usesGuardOpen)
            guardOpen = open
        else
            cover = open ? 1 : 0
        userPropertyChanged(coverPropertyName, coverValue)
    }

    AdaptiveSvgImage {
        id: artwork
        anchors.fill: parent
        source: Qt.resolvedUrl((root.isCoverOpen ? root.look.open : root.look.closed)[root.frameIndex])
        fillMode: Image.PreserveAspectFit
    }

    Item {
        id: hitSurface
        anchors.centerIn: parent
        width: artwork.paintedWidth
        height: artwork.paintedHeight

        Repeater {
            model: root.look.regions
            MouseArea {
                required property var modelData
                x: hitSurface.width * modelData.x
                y: hitSurface.height * modelData.y
                width: hitSurface.width * modelData.width
                height: hitSurface.height * modelData.height
                enabled: root.acceptsInput && (modelData.action === "open" ? !root.isCoverOpen
                        : root.isCoverOpen && (modelData.action !== "close" || root.usesGuardOpen || root.value !== 1))
                preventStealing: true
                cursorShape: Qt.PointingHandCursor
                onPressed: {
                    if (modelData.action === "open") root.setCoverFromUser(true)
                    else if (modelData.action === "close") root.setCoverFromUser(false)
                    else root.commitFromUser(root.positionValues.length
                                             ? root.positionValues[modelData.state] : modelData.state)
                }
            }
        }
    }

    Loader {
        parent: hitSurface
        readonly property var region: root.look.button || [0, 0, 0, 0]
        active: !!root.look.button
        x: parent.width * region[0]
        y: parent.height * region[1]
        width: parent.width * region[2]
        height: parent.height * region[3]
        sourceComponent: MomentaryButton {
            runtimeMode: root.acceptsInput && root.isCoverOpen
            onUserPropertyChanged: function(name, value) { root.commitFromUser(value) }
        }
    }

    Loader {
        parent: hitSurface
        readonly property var region: root.look.fire || [0, 0, 0, 0, 0]
        active: root.hasFireButton
        x: parent.width * region[0]
        y: parent.height * region[1]
        width: parent.width * region[2]
        height: parent.height * region[3]
        rotation: region[4]
        sourceComponent: Buttons.RoundButton {
            id: fireButton
            appearance: "red"
            valuePropertyName: "oN"
            runtimeMode: root.acceptsInput
            Binding { fireButton.oN: root.fire }
            onUserPropertyChanged: function(name, value) {
                root.fire = value
                root.userPropertyChanged("fire", value)
            }
        }
    }
}
