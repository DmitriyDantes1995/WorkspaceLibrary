pragma ComponentBehavior: Bound
import QtQuick 2.15
import common_qml 1.0
import "../_parts" as Buttons

Buttons.MarkableButton {
    id: root

    my_type: "UniversalLampButton"
    my_subtype: "UniversalLampButton"
    implicitWidth: 52.824042
    implicitHeight: 54.169505
    previewSource: "state_0.svg"

    property int lamp: 0
    // Older right-board binding files address this same lamp by this name.
    property alias illuminated: root.lamp
    property bool testMode: false
    readonly property bool verticalMarkings: Math.abs(markingRotation % 180) === 90

    releasedFace: Qt.resolvedUrl("state_0.svg")
    pressedFace: Qt.resolvedUrl("state_1.svg")
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
        illuminated: root.lamp,
        testMode: root.testMode
    })
    propertySchema: Object.assign({}, root.standardPropertySchema, {
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
        visible: root.lamp === 1
    }
}
