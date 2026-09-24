import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root
    preserveAspectRatio: true

    readonly property real designWidth: 202.1
    readonly property real designHeight: 93.4

    // Public component data. m_value is the property bound to RaNET.
    property string m_text: "FAULT"
    property var m_value: 0

    readonly property bool alarmState: normalizeAlarmState(m_value)
    readonly property color normalTextColor: "#00D060"
    readonly property color alarmTextColor: "#FF3030"

    my_type: "FaultAnnunciator"
    my_subtype: "FaultAnnunciator"
    previewSource: "annunciator_background.svg"

    width: designWidth
    height: designHeight
    clip: true

    customProperties: ({
        "m_text": m_text,
        "m_value": m_value
    })
    propertySchema: ({
        "m_text": {
            label: "Label",
            type: "string",
            bindable: true
        },
        "m_value": {
            label: "Alarm",
            type: "bool",
            bindable: true
        }
    })

    function normalizeAlarmState(value) {
        if (value === true)
            return true
        if (value === false || value === null || value === undefined)
            return false

        if (typeof value === "string") {
            var textValue = value.trim().toLowerCase()
            if (textValue === "true")
                return true
            if (textValue === "false" || textValue.length === 0)
                return false
            value = Number(textValue)
        }

        var numericValue = Number(value)
        return isFinite(numericValue) && numericValue !== 0
    }

    AdaptiveSvgImage {
        id: backgroundImage

        anchors.fill: parent
        source: Qt.resolvedUrl("annunciator_background.svg")
        fillMode: Image.Stretch
        smooth: true
        cache: true
    }

    // The SVG light window occupies approximately x=13..189, y=13..80.
    // This inset working area keeps the label clear of its rounded bevel.
    Item {
        id: textWindow

        readonly property real widthScale: root.width / root.designWidth
        readonly property real heightScale: root.height / root.designHeight
        readonly property real fontScale: Math.min(widthScale, heightScale)

        x: 21 * widthScale
        y: 18 * heightScale
        width: 160 * widthScale
        height: 57 * heightScale
        clip: true

        Text {
            id: label
            objectName: "annunciatorText"

            readonly property real inset: Math.max(1, 3 * textWindow.fontScale)

            anchors.centerIn: parent
            width: Math.max(0, parent.width - inset * 2)
            height: Math.max(0, parent.height - inset * 2)

            text: root.m_text
            color: root.alarmState ? root.alarmTextColor : root.normalTextColor
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WordWrap
            maximumLineCount: 2
            elide: Text.ElideRight
            clip: true

            font.bold: true
            font.pixelSize: Math.max(1, textWindow.height * 0.72)
            fontSizeMode: Text.Fit
            minimumPixelSize: Math.max(1, 6 * textWindow.fontScale)
        }
    }
}
