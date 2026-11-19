pragma ComponentBehavior: Bound
import QtQuick 2.15
import common_qml 1.0
import "../../../../../common_qml/CockpitTranslations.js" as Translations
import "PanelLooks.js" as Looks

RotaryAnalog {
    id: root
    my_type: "KnurledKnob"
    my_subtype: "KnurledKnob"
    implicitWidth: look ? look.width : (controlMode === "trim" ? 69.331502 : 57.47716)
    implicitHeight: look ? look.height : implicitWidth
    previewSource: look ? (look.preview || look.scale) : "knob.svg"

    property string appearance: "knurled"
    readonly property var catalogVariantProperties: ["appearance", "controlMode"]
    readonly property string catalogSection: look && look.scale ? "scaled" : "bare"
    property string controlMode: "volume"
    readonly property var look: Looks.entries[appearance]
    readonly property bool hasTravelModes: !look
    readonly property bool trim: controlMode === "trim"
    readonly property real artworkScale: scaleForMode(controlMode)
    readonly property var bodyRect: look ? look.bodyRect
        : [(1 - artworkScale) / 2, (1 - artworkScale) / 2, artworkScale, artworkScale]

    minimumValue: look ? look.minimum : 0
    maximumValue: look ? look.maximum : 65535
    value: minimumValue
    discrete: look ? look.discrete : trim
    minimumAngle: look ? look.start : startAngleForMode(controlMode)
    maximumAngle: look ? look.end : (trim ? 180 : 90)
    wheelStep: look ? look.step : (trim ? 364 : 1)

    customProperties: ({ appearance: root.appearance, controlMode: root.controlMode, value: root.value })
    propertySchema: ({
        appearance: { displayName: qsTr("Appearance"), type: "enum", bindable: false, order: 0,
            values: [{ label: qsTr("Knurled"), value: "knurled", previewSource: Qt.resolvedUrl("knob.svg") }]
                .concat(Object.keys(Looks.entries).map(function(key) {
                    return { label: Looks.entries[key].label, value: key,
                             previewSource: Looks.entries[key].preview ? Qt.resolvedUrl(Looks.entries[key].preview) : "",
                             catalogHidden: Looks.entries[key].catalogHidden === true }
                })) },
        controlMode: { displayName: qsTr("Travel"), type: "enum", bindable: false, order: 1,
            visibleWhen: { property: "hasTravelModes", equals: true },
            previewComponent: travelPreview,
            values: [{ label: qsTr("Centered"), value: "volume" },
                     { label: qsTr("One-sided"), value: "trim" }] },
        value: { displayName: qsTr("Value"), type: "number", bindable: true, access: "readWrite",
            min: root.minimumValue, max: root.maximumValue, step: root.wheelStep, order: 2 }
    })

    function startAngleForMode(mode) {
        return mode === "trim" ? 0 : -90
    }

    function scaleForMode(mode) {
        return mode === "trim" ? 1 : 56.6 / 79.83264
    }

    Component {
        id: travelPreview
        Image {
            property string previewValue: "volume"
            source: Qt.resolvedUrl("knob.svg")
            sourceSize: Qt.size(width, height)
            fillMode: Image.PreserveAspectFit
            rotation: root.startAngleForMode(previewValue)
            scale: root.scaleForMode(previewValue)
        }
    }

    AdaptiveSvgImage {
        anchors.fill: parent
        visible: !!(root.look && root.look.scale)
        source: visible ? Qt.resolvedUrl(root.look.scale) : ""
    }

    AdaptiveSvgImage {
        id: knobBody
        x: root.width * root.bodyRect[0]
        y: root.height * root.bodyRect[1]
        width: root.width * root.bodyRect[2]
        height: root.height * root.bodyRect[3]
        source: Qt.resolvedUrl(root.look ? root.look.source : "knob.svg")
        rotation: root.visualAngle
        fillMode: root.look && root.look.stretch ? Image.Stretch : Image.PreserveAspectFit
    }

    Loader {
        id: knobLegends
        readonly property var arcs: root.look?.arcLegends || []
        anchors.centerIn: knobBody
        width: knobBody.paintedWidth
        height: knobBody.paintedHeight
        active: arcs.length > 0
        sourceComponent: Canvas {
            objectName: "knobArcLegends"
            rotation: knobBody.rotation
            readonly property var words: knobLegends.arcs.map(function(legend) {
                return Translations.legend(legend.key, Qt.uiLanguage)
            })

            onWordsChanged: requestPaint()
            onWidthChanged: requestPaint()
            onHeightChanged: requestPaint()
            onPaint: {
                const ctx = getContext("2d")
                ctx.reset()
                ctx.clearRect(0, 0, width, height)
                ctx.translate(width / 2, height / 2)
                ctx.scale(width / 360, height / 360)
                ctx.fillStyle = "#fff7e3"
                ctx.textAlign = "center"
                ctx.textBaseline = "middle"

                for (let i = 0; i < words.length; ++i) {
                    const word = words[i]
                    const legend = knobLegends.arcs[i]
                    const centerAngle = legend.angle * Math.PI / 180
                    const letters = Array.from(word)
                    const step = legend.direction * 1.22 / Math.max(3, letters.length - 1)
                    ctx.font = "bold " + Math.min(26, 134 / letters.length) + "px Arial"
                    for (let j = 0; j < letters.length; ++j) {
                        const angle = centerAngle + (j - (letters.length - 1) / 2) * step
                        ctx.save()
                        ctx.translate(65 * Math.cos(angle), 65 * Math.sin(angle))
                        ctx.rotate(angle + legend.direction * Math.PI / 2)
                        ctx.fillText(letters[j], 0, 0)
                        ctx.restore()
                    }
                }
            }
        }
    }
}
