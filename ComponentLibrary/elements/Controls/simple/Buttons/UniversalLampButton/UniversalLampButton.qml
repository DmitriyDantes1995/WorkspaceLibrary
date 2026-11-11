pragma ComponentBehavior: Bound
import QtQuick 2.15
import common_qml 1.0
import "../_parts" as Buttons
import "ChannelLooks.js" as Channels
import "../_parts/BoardButtonLooks.js" as BoardLooks

Buttons.MarkableButton {
    id: root

    my_type: "UniversalLampButton"
    my_subtype: "UniversalLampButton"
    implicitWidth: originalFace ? originalFace.width : (numbered ? channel.width : 52.824042)
    implicitHeight: originalFace ? originalFace.height : (numbered ? channel.height : 54.169505)
    previewSource: originalFace ? originalFace.dark[0] : (numbered ? channel.dark[0] : "state_0.svg")

    property string appearance: "standard"
    readonly property var catalogVariantProperties: ["appearance", "channelNumber"]
    property int channelNumber: 1
    readonly property var originalFace: BoardLooks.lit[appearance]
    readonly property bool numbered: appearance === "orangeChannel"
    readonly property var channel: Channels.entries[channelNumber] || Channels.entries[1]
    property int lamp: 0
    // Older right-board binding files address this same lamp by this name.
    property alias illuminated: root.lamp
    property bool testMode: false
    readonly property bool verticalMarkings: Math.abs(markingRotation % 180) === 90

    readonly property var artworkStates: originalFace || (numbered ? channel : null)
    readonly property var visibleStates: artworkStates ? (lamp === 1 ? artworkStates.lit : artworkStates.dark) : null
    releasedFace: Qt.resolvedUrl(visibleStates ? visibleStates[0] : "state_0.svg")
    pressedFace: Qt.resolvedUrl(visibleStates ? visibleStates[1] : "state_1.svg")
    faceFillMode: artworkStates ? Image.PreserveAspectFit : Image.Stretch
    markingsVisible: !originalFace
    markingCenter: verticalMarkings ? Qt.point(28.5, 28.2) : Qt.point(26, 30)
    pressedOffset: Qt.point(2.46, 1.64)
    markingWidth: 28
    singleTextWidth: verticalMarkings ? 30 : 28
    markingHeight: 20
    outlineColor: "#ddb30b"
    outlineWidth: 1.05
    outlinePath: "M 27.5 10.2 H 38.5 Q 42 10.2 42 13.7 V 41.2 Q 42 44.2 38.5 44.2 "
                 + "H 12.5 Q 8.5 44.2 8.5 40.7 V 28.2 Q 8.5 25.2 11.5 24.7 "
                 + "Q 22 23.7 23 14.2 Q 23.5 10.2 27.5 10.2 Z"

    customProperties: Object.assign({}, root.standardProperties, {
        lamp: root.lamp,
        appearance: root.appearance,
        channelNumber: root.channelNumber,
        illuminated: root.lamp,
        testMode: root.testMode
    })
    propertySchema: Object.assign({}, root.standardPropertySchema, {
        appearance: { displayName: qsTr("Appearance"), type: "enum", bindable: false, order: -2,
            values: [
                { label: qsTr("Standard"), value: "standard", previewSource: Qt.resolvedUrl("state_0.svg") },
                { label: qsTr("Orange channel"), value: "orangeChannel",
                  previewSource: Qt.resolvedUrl(root.channel.dark[0]) }
            ] },
        channelNumber: { displayName: qsTr("Channel number"), type: "enum", bindable: false, order: -1,
            visibleWhen: { property: "numbered", equals: true },
            values: [1, 2, 3, 4].map(function(number) {
                return { label: String(number), value: number,
                         previewSource: Qt.resolvedUrl(Channels.entries[number].dark[0]) }
            }) },
        lamp: { displayName: qsTr("Illuminated"), type: "number", bindable: true, access: "readOnly", min: 0, max: 1, step: 1, order: 7 },
        illuminated: { hidden: true, bindable: false, access: "readOnly" },
        testMode: { displayName: qsTr("Test mode"), type: "bool", bindable: false, order: 8 }
    })

    onLampChanged: {
        if (customProperties.lamp !== lamp || customProperties.illuminated !== lamp) {
            customProperties.lamp = lamp
            customProperties.illuminated = lamp
            customPropertiesChanged()
        }
    }

    onUserPropertyChanged: function(propertyName, value) {
        if (root.testMode && propertyName === root.valuePropertyName)
            root.lamp = value
    }

    faceOverlay: AdaptiveSvgImage {
        source: Qt.resolvedUrl("lamp.svg")
        visible: !root.artworkStates && root.lamp === 1
    }
}
