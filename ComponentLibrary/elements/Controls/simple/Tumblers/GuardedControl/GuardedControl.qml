pragma ComponentBehavior: Bound
import QtQuick 2.15
import common_qml 1.0
import "../../Buttons/RoundButton" as Buttons
import "../../../../../common_qml/CockpitTranslations.js" as Translations
import "Looks.js" as Looks

ControlState {
    id: root
    my_type: "GuardedControl"
    my_subtype: my_type
    property string appearance: "horizontal"
    readonly property var catalogVariantProperties: ["appearance"]
    // Old scenes may still refer to artwork with baked-in markings.
    property string marking: "standard"
    property string coverLegendKey: look.legendKey || ""
    property var coverText: null
    property var coverTranslations: ({})
    property int coverTextRotation: look.legend?.rotation || 0
    property real coverTextFontSize: 0
    property real coverTextOffsetX: 0
    property real coverTextOffsetY: 0
    property int cover: 0
    property string coverPropertyName: "cover"
    property bool guardOpen: false
    readonly property bool usesGuardOpen: coverPropertyName === "guardOpen"
    readonly property bool isCoverOpen: usesGuardOpen ? guardOpen : cover === 1
    // Optional hardware codes in the same order as the artwork frames.
    property var positionValues: []
    property int fire: 0
    readonly property var look: Looks.resolve(appearance, marking)
    readonly property bool hasPresetLegend: (look.legend?.keys?.length || 0) > 0
    readonly property bool supportsCoverText: marking === "standard" && look.legend?.editable === true
    readonly property bool supportsCoverTextLayout: supportsCoverText || hasPresetLegend
    readonly property string legacyCoverText: coverTranslations.ru || coverTranslations.en || ""
    readonly property string coverLegendText: supportsCoverText
        ? (coverText ?? Translations.forLanguage(coverTranslations, Qt.uiLanguage, legacyCoverText))
        : (look.legend?.keys?.includes(coverLegendKey)
           ? Translations.legend(coverLegendKey, Qt.uiLanguage) : "")
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
        if (root.hasPresetLegend || root.coverLegendKey)
            values.coverLegendKey = root.coverLegendKey
        if (root.supportsCoverText || root.coverText != null)
            values.coverText = root.coverText ?? undefined
        if (root.coverText == null && Object.keys(root.coverTranslations).length)
            values.coverTranslations = root.coverTranslations
        if (root.supportsCoverTextLayout) {
            values.coverTextRotation = root.coverTextRotation
            values.coverTextFontSize = root.coverTextFontSize
            values.coverTextOffsetX = root.coverTextOffsetX
            values.coverTextOffsetY = root.coverTextOffsetY
        }
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
        coverLegendKey: { displayName: qsTr("Cover inscription"), type: "enum", bindable: false, order: 1,
            visibleWhen: { property: "hasPresetLegend", equals: true },
            values: [{ label: qsTr("None"), value: "" }]
                .concat((root.look.legend?.keys || []).map(function(key) {
                    return { label: Translations.legend(key, Qt.uiLanguage).replace(/\n/g, " "), value: key }
                })) },
        coverText: { displayName: "Cover text", type: "string", bindable: false, order: 1,
            editorValue: root.coverText ?? root.legacyCoverText,
            visibleWhen: { property: "supportsCoverText", equals: true } },
        coverTranslations: { hidden: true, bindable: false },
        coverTextFontSize: { displayName: "Cover font size (0 = auto)", type: "number", bindable: false,
            min: 0, max: coverLabel.item?.maximumFontSize ?? 0, step: 1, wheelEnabled: true,
            editorValue: coverLabel.item?.fontSize ?? 0, unit: "px", order: 2,
            visibleWhen: { property: "supportsCoverTextLayout", equals: true } },
        coverTextRotation: { displayName: "Cover text rotation", type: "enum", bindable: false, order: 3,
            values: [{ label: "0°", value: 0 }, { label: "90°", value: 90 }, { label: "−90°", value: -90 }],
            visibleWhen: { property: "supportsCoverTextLayout", equals: true } },
        coverTextOffsetX: { displayName: "Cover text offset X", type: "number", bindable: false,
            min: coverLabel.item?.offsetX.min ?? 0, max: coverLabel.item?.offsetX.max ?? 0,
            editorValue: coverLabel.item?.offsetX.value ?? 0, step: 0.5, wheelEnabled: true, unit: "px", order: 4,
            visibleWhen: { property: "supportsCoverTextLayout", equals: true } },
        coverTextOffsetY: { displayName: "Cover text offset Y", type: "number", bindable: false,
            min: coverLabel.item?.offsetY.min ?? 0, max: coverLabel.item?.offsetY.max ?? 0,
            editorValue: coverLabel.item?.offsetY.value ?? 0, step: 0.5, wheelEnabled: true, unit: "px", order: 5,
            visibleWhen: { property: "supportsCoverTextLayout", equals: true } },
        coverPropertyName: { hidden: true, bindable: false },
        positionValues: { hidden: true, bindable: false },
        value: { displayName: qsTr("Position"), type: "number", bindable: true, access: "readWrite",
            min: 0, max: root.maximumValue, step: 1, order: 6 },
        [root.coverPropertyName]: { displayName: qsTr("Guard open"),
            type: root.usesGuardOpen ? "bool" : "number", bindable: true,
            access: "readWrite", min: 0, max: 1, step: 1, order: 7 },
        fire: { displayName: qsTr("Fire extinguisher"), type: "number", bindable: true,
            access: "readWrite", min: 0, max: 1, step: 1, order: 8,
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

        Loader {
            id: coverLabel
            readonly property var layout: root.look.legend
            active: root.supportsCoverTextLayout
            visible: active && !root.isCoverOpen
            anchors.centerIn: parent
            width: root.look.width
            height: root.look.height
            scale: Math.min(hitSurface.width / width, hitSurface.height / height)

            sourceComponent: Item {
                id: coverArtwork
                readonly property var layout: coverLabel.layout
                // The old item can still be evaluated while the Loader switches to a cover without a legend.
                readonly property real centerX: width * (layout?.center[0] ?? 0.5)
                readonly property real centerY: height * (layout?.center[1] ?? 0.5)
                readonly property real nominalWidth: width * (layout?.size[0] ?? 1)
                readonly property real nominalHeight: height * (layout?.size[1] ?? 1)
                // Layout size is expressed in the unrotated label's axes.
                readonly property bool presetVertical: Math.abs(layout?.rotation || 0) % 180 === 90
                readonly property real faceWidth: presetVertical ? nominalHeight : nominalWidth
                readonly property real faceHeight: presetVertical ? nominalWidth : nominalHeight
                readonly property var bounds: layout?.bounds
                readonly property real faceLeft: Math.max(0, bounds ? width * bounds[0] : centerX - faceWidth / 2)
                readonly property real faceTop: Math.max(0, bounds ? height * bounds[1] : centerY - faceHeight / 2)
                readonly property real faceRight: Math.min(width, bounds ? width * (bounds[0] + bounds[2]) : centerX + faceWidth / 2)
                readonly property real faceBottom: Math.min(height, bounds ? height * (bounds[1] + bounds[3]) : centerY + faceHeight / 2)
                readonly property real inset: layout?.plate ? nominalHeight * 0.12 : 0
                readonly property real roomX: 2 * Math.min(centerX - faceLeft, faceRight - centerX) - 2 * inset
                readonly property real roomY: 2 * Math.min(centerY - faceTop, faceBottom - centerY) - 2 * inset
                readonly property real angleRadians: root.coverTextRotation * Math.PI / 180
                readonly property real cosine: Math.abs(Math.cos(angleRadians))
                readonly property real sine: Math.abs(Math.sin(angleRadians))
                readonly property bool vertical: sine > cosine
                readonly property real lineWidth: vertical ? roomY : roomX
                readonly property real lineHeight: vertical ? roomX : roomY
                readonly property real fitScale: Math.min(1, roomX / rotatedWidth(lineWidth, lineHeight),
                    roomY / rotatedHeight(lineWidth, lineHeight))
                readonly property int maximumFontSize: Math.max(1, Math.floor(Math.min(roomX, roomY) * fitScale))
                readonly property real fontSize: Math.max(0, Math.min(maximumFontSize, root.coverTextFontSize))
                readonly property var offsetX: offsetRange(centerX, faceLeft, faceRight,
                    rotatedWidth(legend.contentWidth, legend.contentHeight), root.coverTextOffsetX)
                readonly property var offsetY: offsetRange(centerY, faceTop, faceBottom,
                    rotatedHeight(legend.contentWidth, legend.contentHeight), root.coverTextOffsetY)

                function rotatedWidth(w, h) { return cosine * w + sine * h }
                function rotatedHeight(w, h) { return sine * w + cosine * h }

                function offsetRange(center, first, last, textExtent, requestedOffset) {
                    const halfExtent = textExtent / 2 + inset
                    const minimum = Math.min(0, Math.ceil(2 * (first + halfExtent - center)) / 2)
                    const maximum = Math.max(0, Math.floor(2 * (last - halfExtent - center)) / 2)
                    return { min: minimum, max: maximum,
                             value: Math.max(minimum, Math.min(maximum, requestedOffset)) }
                }

                Rectangle {
                    x: coverArtwork.faceLeft
                    y: coverArtwork.faceTop
                    width: coverArtwork.faceRight - x
                    height: coverArtwork.faceBottom - y
                    visible: coverArtwork.layout?.plate === true && root.coverLegendText.length > 0
                    radius: height * 0.1
                    gradient: Gradient {
                        GradientStop { position: 0; color: "#d51d11" }
                        GradientStop { position: 1; color: "#bb1308" }
                    }
                }

                Item {
                    x: coverArtwork.faceLeft + coverArtwork.inset
                    y: coverArtwork.faceTop + coverArtwork.inset
                    width: coverArtwork.faceRight - coverArtwork.inset - x
                    height: coverArtwork.faceBottom - coverArtwork.inset - y
                    clip: true

                    CockpitLegend {
                        id: legend
                        objectName: "coverLegend"
                        x: coverArtwork.centerX - parent.x - width / 2 + coverArtwork.offsetX.value
                        y: coverArtwork.centerY - parent.y - height / 2 + coverArtwork.offsetY.value
                        width: coverArtwork.lineWidth * coverArtwork.fitScale
                        height: coverArtwork.lineHeight * coverArtwork.fitScale
                        rotation: root.coverTextRotation
                        text: root.coverLegendText
                        color: coverArtwork.layout?.color || "#f3ecd5"
                        font.bold: coverArtwork.layout?.bold === true
                        font.pixelSize: Math.max(1, Math.round(coverArtwork.fontSize ||
                            (coverArtwork.nominalHeight - 2 * coverArtwork.inset)
                                * (coverArtwork.layout?.fontScale || 0.72)))
                    }
                }
            }
        }

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
