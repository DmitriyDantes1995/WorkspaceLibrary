import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    required property int operatingMinimum
    required property int maximumValue
    required property url artworkDirectory
    required property var fixedDigits
    required property var wheelWindow
    required property var wheelStrip
    required property var wheelTravel
    required property var testArea

    property bool runtimeMode: false
    property real value: 0
    readonly property int displayValue: value === -1 ? 0
                                        : Math.max(operatingMinimum, Math.min(maximumValue, Math.floor(value)))
    readonly property real rollingDigit: (displayValue % 100) / 10
    preserveAspectRatio: true
    previewSource: "preview.svg"
    customProperties: ({ value: value })
    propertySchema: counterPropertySchema
    readonly property var counterPropertySchema: ({ value: {
        displayName: "Value", type: "number", bindable: true,
        access: "readWrite", min: -1, max: maximumValue, step: 1
    } })

    onValueChanged: {
        if (customProperties.value !== value) {
            customProperties.value = value
            customPropertiesChanged()
        }
    }

    AdaptiveSvgImage {
        anchors.fill: parent
        source: root.artworkDirectory + "back.svg"
    }

    Repeater {
        model: root.fixedDigits
        delegate: AdaptiveSvgImage {
            required property int index
            required property var modelData

            x: modelData[0] * root.width
            y: modelData[1] * root.height
            width: modelData[2] * root.width
            height: modelData[3] * root.height
            readonly property int digit: Math.floor(root.displayValue / (index === 0 ? 1000 : 100)) % 10
            source: Qt.resolvedUrl("digit_" + digit + ".svg")
        }
    }

    Item {
        x: root.wheelWindow[0] * root.width
        y: root.wheelWindow[1] * root.height
        width: root.wheelWindow[2] * root.width
        height: root.wheelWindow[3] * root.height
        clip: true

        AdaptiveSvgImage {
            objectName: "rollingStrip"
            x: (root.wheelStrip[0] - root.wheelWindow[0] + root.wheelTravel[0] * root.rollingDigit) * root.width
            y: (root.wheelStrip[1] - root.wheelWindow[1] + root.wheelTravel[1] * root.rollingDigit) * root.height
            width: root.wheelStrip[2] * root.width
            height: root.wheelStrip[3] * root.height
            source: root.artworkDirectory + "strip.svg"
        }
    }

    AdaptiveSvgImage {
        anchors.fill: parent
        source: root.artworkDirectory + "front.svg"
    }

    MouseArea {
        x: root.testArea[0] * root.width
        y: root.testArea[1] * root.height
        width: root.testArea[2] * root.width
        height: root.testArea[3] * root.height
        enabled: root.runtimeMode
        cursorShape: Qt.PointingHandCursor
        onPressed: {
            const next = Math.min(root.maximumValue,
                                  Math.max(root.operatingMinimum, Math.floor(root.value) + 1))
            if (next === root.value)
                return
            root.value = next
            root.userPropertyChanged("value", next)
        }
    }
}
