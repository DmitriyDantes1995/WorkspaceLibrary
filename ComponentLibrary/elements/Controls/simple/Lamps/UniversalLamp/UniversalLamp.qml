import QtQuick 2.15
import QtQuick.Shapes 1.15
import common_qml 1.0
import "Looks.js" as Looks

Indicator {
    id: root

    my_type: "UniversalLamp"
    my_subtype: my_type
    implicitWidth: lens.width
    implicitHeight: lens.height
    previewSource: lens.on

    property string appearance: "round"
    readonly property var catalogVariantProperties: ["appearance", "lampColor"]
    property string lampColor: "green"
    property bool customStates: false
    property color offColor: "#414747"
    property color onColor: "#46e569"
    property string offText: ""
    property string onText: ""
    property bool testMode: false
    property alias oN: root.value

    readonly property bool usesOnChannel: valuePropertyName === "oN"
    readonly property var style: Looks.entries[appearance] || Looks.entries.round
    readonly property var lens: lensFor(style, lampColor)
    readonly property bool hasColorChoices: !customStates && Object.keys(style.colors).length > 1
    readonly property bool illuminated: value === 1

    onStyleChanged: {
        if (!style.colors[lampColor])
            lampColor = style.defaultColor
    }

    customProperties: ({
        appearance: root.appearance,
        lampColor: root.lampColor,
        customStates: root.customStates,
        offColor: root.offColor.toString(),
        onColor: root.onColor.toString(),
        offText: root.offText,
        onText: root.onText,
        testMode: root.testMode,
        valuePropertyName: root.valuePropertyName,
        [root.valuePropertyName]: root.value
    })
    propertySchema: ({
        appearance: { displayName: qsTr("Appearance"), type: "enum", bindable: false, order: 0,
            values: Object.keys(Looks.entries).map(function(key) {
                const entry = Looks.entries[key]
                return { label: entry.label, value: key,
                         previewSource: Qt.resolvedUrl(root.lensFor(entry, root.lampColor).on) }
            }) },
        lampColor: { displayName: qsTr("Color"), type: "enum", bindable: false, order: 1,
            visibleWhen: { property: "hasColorChoices", equals: true },
            values: Object.keys(root.style.colors).map(function(key) {
                const entry = root.style.colors[key]
                return { label: entry.label, value: key, previewSource: Qt.resolvedUrl(entry.on) }
            }) },
        customStates: { displayName: qsTr("Custom states"), type: "bool", bindable: false, order: 2 },
        offColor: { displayName: qsTr("Off color"), type: "color", bindable: false, order: 3,
            visibleWhen: { property: "customStates", equals: true } },
        offText: { displayName: qsTr("Off text"), type: "string", bindable: false, order: 4,
            visibleWhen: { property: "customStates", equals: true } },
        onColor: { displayName: qsTr("On color"), type: "color", bindable: false, order: 5,
            visibleWhen: { property: "customStates", equals: true } },
        onText: { displayName: qsTr("On text"), type: "string", bindable: false, order: 6,
            visibleWhen: { property: "customStates", equals: true } },
        [root.valuePropertyName]: {
            displayName: qsTr("Illuminated"), type: "enum", bindable: true,
            access: root.usesOnChannel ? "readWrite" : "readOnly", order: 7, min: 0, max: 1,
            values: [{ label: qsTr("Off"), value: 0 }, { label: qsTr("On"), value: 1 }]
        },
        testMode: { displayName: qsTr("Test mode"), type: "bool", bindable: false, order: 8 },
        valuePropertyName: { hidden: true, bindable: false }
    })

    function lensFor(entry, color) {
        return entry.colors[color] || entry.colors[entry.defaultColor]
    }

    function normalized(next) {
        const number = Number(next)
        if (!isFinite(number))
            return 0
        // The round lamps used the exact oN value, including non-binary inputs.
        return usesOnChannel ? number : Math.max(0, Math.min(1, Math.round(number)))
    }

    AdaptiveSvgImage {
        id: artwork
        anchors.fill: parent
        source: Qt.resolvedUrl(root.illuminated && !root.customStates ? root.lens.on : root.lens.off)
        fillMode: root.lens.fit ? Image.PreserveAspectFit : Image.Stretch
    }

    Loader {
        anchors.centerIn: artwork
        width: artwork.paintedWidth
        height: artwork.paintedHeight
        active: root.customStates
        sourceComponent: Item {
            id: face
            readonly property var opening: root.style.window
            readonly property real windowWidth: width * opening.width
            readonly property real windowHeight: height * opening.height
            readonly property real textInset: Math.min(windowWidth, windowHeight) * 0.14

            Shape {
                id: faceWindow
                x: face.width * face.opening.x
                y: face.height * face.opening.y
                width: face.windowWidth
                height: face.windowHeight
                visible: width > 0 && height > 0
                antialiasing: true

                readonly property bool oval: face.opening.roundness === 0.5
                readonly property real corner: Math.min(width, height) * face.opening.roundness
                readonly property real radiusX: oval ? width / 2 : corner
                readonly property real radiusY: oval ? height / 2 : corner
                readonly property color tint: root.illuminated ? root.onColor : root.offColor
                readonly property color backing: "#181a1c"

                ShapePath {
                    id: surface
                    objectName: "customLampColor"
                    strokeWidth: -1
                    // Cover the original face, including baked lettering, at any alpha.
                    fillColor: Qt.rgba(
                        faceWindow.tint.r * faceWindow.tint.a + faceWindow.backing.r * (1 - faceWindow.tint.a),
                        faceWindow.tint.g * faceWindow.tint.a + faceWindow.backing.g * (1 - faceWindow.tint.a),
                        faceWindow.tint.b * faceWindow.tint.a + faceWindow.backing.b * (1 - faceWindow.tint.a), 1)
                    PathSvg {
                        path: {
                            const w = faceWindow.width
                            const h = faceWindow.height
                            const rx = faceWindow.radiusX
                            const ry = faceWindow.radiusY
                            return "M " + rx + " 0 H " + (w - rx)
                                + " A " + rx + " " + ry + " 0 0 1 " + w + " " + ry
                                + " V " + (h - ry)
                                + " A " + rx + " " + ry + " 0 0 1 " + (w - rx) + " " + h
                                + " H " + rx
                                + " A " + rx + " " + ry + " 0 0 1 0 " + (h - ry)
                                + " V " + ry
                                + " A " + rx + " " + ry + " 0 0 1 " + rx + " 0 Z"
                        }
                    }
                }
            }

            Text {
                objectName: "customLampLabel"
                x: face.width * face.opening.x + face.textInset
                y: face.height * face.opening.y + face.textInset
                width: face.windowWidth - 2 * face.textInset
                height: face.windowHeight - 2 * face.textInset
                text: root.illuminated ? root.onText : root.offText
                textFormat: Text.PlainText
                visible: width >= 4 && height >= 4 && text.length > 0
                color: contrastingText()
                font.family: "Arial"
                font.bold: true
                font.pixelSize: Math.max(1, Math.min(face.windowWidth, face.windowHeight) * 0.55)
                minimumPixelSize: 1
                fontSizeMode: Text.Fit
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                clip: true

                function contrastingText() {
                    const fill = surface.fillColor
                    return 0.2126 * linear(fill.r) + 0.7152 * linear(fill.g) + 0.0722 * linear(fill.b) > 0.179
                        ? "#000000" : "#ffffff"
                }

                function linear(channel) {
                    return channel <= 0.04045 ? channel / 12.92
                        : Math.pow((channel + 0.055) / 1.055, 2.4)
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        enabled: root.acceptsInput && root.testMode
        preventStealing: true
        cursorShape: Qt.PointingHandCursor
        onPressed: root.commitFromUser(1)
        onReleased: root.commitFromUser(0)
        onCanceled: root.commitFromUser(0)
    }
}
