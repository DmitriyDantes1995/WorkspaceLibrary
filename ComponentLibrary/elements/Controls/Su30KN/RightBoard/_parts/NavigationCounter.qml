pragma ComponentBehavior: Bound

import QtQuick 2.15
import common_qml 1.0

Indicator {
    id: root

    required property int firstNumber
    required property var regions
    required property url glassSource
    property bool testMode: false
    minimumValue: -1
    value: -1
    customProperties: ({ value: value, testMode: testMode })
    propertySchema: navigationPropertySchema
    readonly property var navigationPropertySchema: ({
        value: { displayName: "Reading", type: "number", bindable: true,
                 access: "readOnly", min: minimumValue, max: maximumValue },
        testMode: { displayName: "Test mode", type: "bool", bindable: false, access: "readWrite" }
    })

    readonly property string digits: String(value).padStart(regions.length, "0")

    function normalized(next) {
        const number = Math.round(Number(next))
        if (!isFinite(number) || number < 0)
            return -1
        return Math.max(firstNumber, Math.min(maximumValue, number))
    }

    Repeater {
        model: root.regions

        AdaptiveSvgImage {
            required property int index
            required property var modelData

            x: modelData[0] * root.width
            y: modelData[1] * root.height
            width: modelData[2] * root.width
            height: modelData[3] * root.height
            source: Qt.resolvedUrl("navDigits/digit_" +
                                  (root.value === -1 ? "off" : root.digits[index]) + ".svg")
            fillMode: Image.Stretch
        }
    }

    AdaptiveSvgImage {
        anchors.fill: parent
        source: root.glassSource
        fillMode: Image.Stretch
    }

    MouseArea {
        anchors.fill: parent
        enabled: root.acceptsInput && root.testMode
        cursorShape: Qt.PointingHandCursor
        onPressed: root.commitFromUser(root.value >= root.maximumValue ? 1 : root.value + 1)
    }
}
