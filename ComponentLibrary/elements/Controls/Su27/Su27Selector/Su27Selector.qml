pragma ComponentBehavior: Bound
import QtQuick 2.15
import common_qml 1.0
import "../../../../common_qml/CockpitTranslations.js" as Translations
import "Handles.js" as Handles
import "Profiles.js" as Profiles
import "_parts"

RotaryDiscrete {
    id: root
    my_type: "Su27Selector"
    my_subtype: "Su27Selector"
    componentPath: "elements/Controls/Su27/Su27Selector/Su27Selector.qml"
    implicitWidth: designWidth
    implicitHeight: designHeight
    readonly property string catalogLabel: qsTr("Selector")
    readonly property string catalogSection: "scaled"

    property string profile: "radarMode"
    property string handleStyle: "auto"
    property string handleObjectName: "selectorHandle"
    // Zero takes the nominal size of the current handle.
    property real handleSize: 0
    readonly property var profileData: Profiles.profiles[profile]
    readonly property real designWidth: profileData?.layout?.width ?? 148
    readonly property real designHeight: profileData?.layout?.height ?? 148
    readonly property Component profilePreview: selectorPreview
    minimumValue: profileData ? (profileData.minimum || 0) : 0
    value: minimumValue
    angles: profileData ? Profiles.anglesFor(profileData) : []
    inputCenterX: selectorFace.centerX
    inputCenterY: selectorFace.centerY
    enabled: profileData !== undefined
    customProperties: ({ profile: profile, handleStyle: handleStyle, handleSize: handleSize, value: value })
    propertySchema: ({
        profile: { displayName: "Scale", type: "enum", bindable: false, order: 0,
            values: Profiles.choices(profile), previewComponent: scalePreview },
        handleStyle: { displayName: "Handle", type: "enum", bindable: false, order: 1,
            values: [{ label: qsTr("Standard handle"), value: "auto" }].concat(
                Object.keys(Handles.entries).map(function(key) {
                    const name = Handles.entries[key].name
                    return { label: Translations.forLanguage(name, Qt.uiLanguage, name.ru), value: key }
                })), previewComponent: handlePreview },
        handleSize: { displayName: "Handle size", type: "number", bindable: false, order: 2,
            min: 0, sliderMin: 1,
            max: Math.max(200, Math.ceil(selectorFace.defaultHandleSize * 2), Math.ceil(handleSize)),
            step: 1, unit: "px", wheelEnabled: true,
            editorValue: Math.round(selectorFace.effectiveHandleSize * 10) / 10 },
        value: profileData?.positions
            ? { displayName: "Value", type: "enum", bindable: true, access: "readWrite", order: 3,
                values: profileData.positions.map((position, index) => ({
                    label: typeof position === "string" ? position : Translations.legend(position.key, Qt.uiLanguage),
                    value: index
                })) }
            : { displayName: "Value", type: "number", bindable: true, access: "readWrite", order: 3,
                min: minimumValue, max: maximumValue, step: 1 }
    })
    function synchronizePropertyMap() {
        // Range normalization can run before this derived map is initialized.
        if (!customProperties) return
        var changed = false
        for (var name of ["profile", "handleStyle", "handleSize", "value"]) {
            if (customProperties[name] !== root[name]) {
                customProperties[name] = root[name]
                changed = true
            }
        }
        if (changed) customPropertiesChanged()
    }
    onProfileChanged: synchronizePropertyMap()
    onHandleStyleChanged: synchronizePropertyMap()
    onHandleSizeChanged: synchronizePropertyMap()
    SelectorFace {
        id: selectorFace
        anchors.fill: parent
        definition: root.profileData
        visualAngle: root.visualAngle
        handleStyle: root.handleStyle
        handleSize: root.handleSize
    }

    Component {
        id: selectorPreview
        PreviewFace {}
    }

    Component {
        id: scalePreview
        PreviewFace { showHandle: false }
    }

    component PreviewFace: SelectorFace {
        property string previewValue: "radarMode"
        definition: Profiles.profiles[previewValue]
        visualAngle: angles[0] || 0
    }

    Component {
        id: handlePreview
        Item {
            id: tile
            property string previewValue: "auto"

            SelectorHandle {
                anchors.centerIn: parent
                style: tile.previewValue === "auto" ? (root.profileData?.handle || "arrow") : tile.previewValue
                diameter: Math.min(tile.width, tile.height) * 0.79
            }
        }
    }

    component SelectorHandle: Loader {
        id: handleLoader
        property string style: "arrow"
        property real diameter: 0
        readonly property var definition: Handles.entries[style] || Handles.entries.arrow
        readonly property real pointerAngle: item?.pointerAngle ?? definition.pointerAngle ?? 0
        width: diameter
        height: definition.gain && item ? diameter * item.implicitHeight / item.implicitWidth : diameter
        sourceComponent: definition.gain ? gainHandle : definition.source ? svgHandle : drawnHandle

        Component {
            id: svgHandle
            AdaptiveSvgImage {
                source: Qt.resolvedUrl(handleLoader.definition.source)
                fillMode: Image.PreserveAspectFit
            }
        }
        Component {
            id: drawnHandle
            RotaryHandle { handle: handleLoader.style }
        }
        Component {
            id: gainHandle
            GainKnobVisual {}
        }
    }

    component SelectorFace: Item {
        id: face
        property var definition: null
        property real visualAngle: 0
        property string handleStyle: "auto"
        property real handleSize: 0
        property bool showHandle: true
        readonly property var angles: definition ? Profiles.anglesFor(definition) : []
        readonly property string cadScale: definition?.cadScale || ""
        readonly property string scaleArtwork: definition?.scaleSource || cadScale
                                               || (definition?.artwork ? definition.artwork + "scale.svg" : "")
        readonly property var layout: definition?.layout
        readonly property real layoutScale: layout ? Math.min(width / layout.width, height / layout.height) : 1
        readonly property real centerX: layout ? width / 2 + (layout.centerX - layout.width / 2) * layoutScale : width / 2
        readonly property real centerY: layout ? height / 2 + (layout.centerY - layout.height / 2) * layoutScale : height / 2
        readonly property real defaultHandleSize: grip.definition.size * layoutScale
        readonly property real effectiveHandleSize: handleSize > 0 ? handleSize : defaultHandleSize

        AdaptiveSvgImage {
            id: background
            anchors.centerIn: parent
            objectName: "selectorScale"
            width: face.layout ? face.layout.width * face.layoutScale
                               : face.cadScale ? face.width : Math.min(face.width, face.height)
            height: face.layout ? face.layout.height * face.layoutScale
                                : face.cadScale ? face.height : width
            visible: !!face.scaleArtwork
            source: visible ? Qt.resolvedUrl(face.scaleArtwork) : ""
            fillMode: Image.PreserveAspectFit
        }

        Item {
            id: scaleSurface
            anchors.centerIn: background
            width: background.paintedWidth
            height: background.paintedHeight

            Repeater {
                model: face.definition?.scaleLegends || []

                CockpitLegend {
                    required property int index
                    required property var modelData
                    objectName: "scaleLegend" + index
                    legendKey: modelData.key
                    x: scaleSurface.width * modelData.bounds[0]
                    y: scaleSurface.height * modelData.bounds[1]
                    width: scaleSurface.width * modelData.bounds[2]
                    height: scaleSurface.height * modelData.bounds[3]
                    rotation: modelData.rotation ?? 0
                    color: modelData.color ?? (face.cadScale ? "#eae6db" : "#fff")
                    horizontalAlignment: modelData.alignLeft ? Text.AlignLeft : Text.AlignHCenter
                    font.bold: modelData.bold === true
                    font.pixelSize: Math.max(1, Math.round(height * 0.82))
                }
            }
        }

        Loader {
            anchors.fill: parent
            active: !!face.definition && !face.scaleArtwork && face.definition.scaleMarks !== false
            sourceComponent: RotaryFace {
                labels: face.definition?.labels || []
                angles: face.angles
                labelEvery: face.definition?.labelEvery || 1
            }
        }

        SelectorHandle {
            id: grip
            objectName: root.handleObjectName
            visible: face.showHandle
            active: visible
            style: face.handleStyle === "auto" ? (face.definition?.handle || "arrow") : face.handleStyle
            diameter: face.effectiveHandleSize
            x: face.centerX - width / 2
            y: face.centerY - height / 2
            rotation: face.visualAngle - pointerAngle
        }
    }
}
