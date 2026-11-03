import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf. Same two-digit #441 display and #594 bezel for R-862 and RS-2.
Indicator {
    id: root

    my_type: "Su30KNLeftRadioChannel"
    my_subtype: "Su30KNLeftRadioChannel"
    implicitWidth: 38.38902
    implicitHeight: 42.99202
    previewSource: "preview.svg"
    minimumValue: -1
    maximumValue: 20
    value: -1

    // The original allows clicks on the display only in test mode.
    property bool testMode: false
    propertySchema: ({
        value: {
            displayName: "Channel", type: "number", bindable: true,
            access: "readOnly", min: minimumValue, max: maximumValue, step: 1
        },
        testMode: { displayName: "Test mode", type: "bool", bindable: false, access: "readWrite" }
    })
    customProperties: ({ value: root.value, testMode: root.testMode })

    function normalized(next) {
        const channel = Math.round(Number(next))
        return !isFinite(channel) || channel <= -1 ? -1 : Math.max(1, Math.min(maximumValue, channel))
    }

    onTestModeChanged: {
        if (customProperties.testMode !== testMode) {
            customProperties.testMode = testMode
            customPropertiesChanged()
        }
    }

    AdaptiveSvgImage {
        x: root.width * 0.12570092
        y: root.height * 0.065866526
        width: root.width * 0.77464728
        height: root.height * 0.40306434
        source: Qt.resolvedUrl("digit_" + (root.value === -1 ? "blank" : Math.floor(root.value / 10)) + ".svg")
        fillMode: Image.Stretch
    }

    AdaptiveSvgImage {
        x: root.width * 0.12570092
        y: root.height * 0.55432927
        width: root.width * 0.77464728
        height: root.height * 0.40306434
        source: Qt.resolvedUrl("digit_" + (root.value === -1 ? "blank" : root.value % 10) + ".svg")
        fillMode: Image.Stretch
    }

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("glass.svg")
        fillMode: Image.Stretch
    }

    MouseArea {
        anchors.fill: parent
        enabled: root.acceptsInput && root.testMode
        cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
        onClicked: root.commitFromUser(root.value < 1 || root.value >= root.maximumValue ? 1 : root.value + 1)
    }
}
