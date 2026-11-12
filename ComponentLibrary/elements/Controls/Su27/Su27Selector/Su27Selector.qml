import QtQuick 2.15
import common_qml 1.0
import "Profiles.js" as Profiles
import "_parts"

RotaryDiscrete {
    id: root
    my_type: "Su27Selector"
    my_subtype: "Su27Selector"
    previewSource: "preview.svg"
    componentPath: "elements/Controls/Su27/Su27Selector/Su27Selector.qml"
    implicitWidth: 148
    implicitHeight: 148
    property string profile: "radarMode"
    property real handleSize: 0
    readonly property var catalogVariantProperties: ["profile"]
    readonly property string catalogSection: "scaled"
    readonly property var profileData: Profiles.profiles[profile]
    readonly property Component profilePreview: selectorPreview
    minimumValue: profileData ? (profileData.minimum || 0) : 0
    value: minimumValue
    angles: profileData ? Profiles.anglesFor(profileData) : []
    enabled: profileData !== undefined
    customProperties: ({ profile: profile, handleSize: handleSize, value: value })
    propertySchema: ({
        profile: { displayName: "Profile", type: "enum", bindable: false,
            values: Profiles.choices(), previewComponent: root.profilePreview },
        handleSize: { displayName: "Handle size", type: "number", bindable: false,
            min: 0, sliderMin: 1,
            max: Math.max(200, Math.ceil(selectorFace.defaultHandleSize * 2), Math.ceil(handleSize)),
            step: 1, unit: "px", wheelEnabled: true,
            hidden: !profileData?.artwork || !!profileData?.sharedHandle,
            editorValue: Math.round(selectorFace.effectiveHandleSize * 10) / 10 },
        value: { displayName: "Value", type: "number", bindable: true, access: "readWrite", min: minimumValue, max: maximumValue, step: 1 }
    })
    function synchronizePropertyMap() {
        // Range normalization can run before this derived map is initialized.
        if (!customProperties) return
        if (customProperties.profile !== profile || customProperties.value !== value) {
            customProperties.profile = profile
            customProperties.value = value
            customPropertiesChanged()
        }
    }
    onProfileChanged: synchronizePropertyMap()
    SelectorFace {
        id: selectorFace
        anchors.fill: parent
        definition: root.profileData
        visualAngle: root.visualAngle
        handleSize: root.handleSize
    }

    Component {
        id: selectorPreview
        SelectorFace {
            property string previewValue: "radarMode"
            definition: Profiles.profiles[previewValue]
            visualAngle: angles[0] || 0
        }
    }

    component SelectorFace: Item {
        id: face
        property var definition: null
        property real visualAngle: 0
        property real handleSize: 0
        readonly property var angles: definition ? Profiles.anglesFor(definition) : []
        readonly property string artwork: definition && definition.artwork ? definition.artwork : ""
        readonly property string cadScale: definition && definition.cadScale ? definition.cadScale : ""
        readonly property var sharedHandle: definition?.sharedHandle
        readonly property real defaultHandleSize: sharedHandle?.size ?? Math.min(width, height)
        readonly property real effectiveHandleSize: !sharedHandle && handleSize > 0 ? handleSize : defaultHandleSize

        AdaptiveSvgImage {
            anchors.fill: parent
            visible: !!face.cadScale
            source: visible ? Qt.resolvedUrl(face.cadScale) : ""
            fillMode: Image.PreserveAspectFit
        }

        Loader {
            anchors.centerIn: parent
            width: face.artwork ? Math.min(face.width, face.height) : face.width
            height: face.artwork ? width : face.height
            sourceComponent: face.artwork ? sourceArtwork : generatedFace
        }
        Component {
            id: sourceArtwork
            Item {
                AdaptiveSvgImage {
                    anchors.fill: parent
                    visible: !face.cadScale
                    source: visible ? Qt.resolvedUrl(face.artwork + "scale.svg") : ""
                }
                AdaptiveSvgImage {
                    anchors.centerIn: parent
                    width: face.effectiveHandleSize
                    height: width
                    source: face.definition?.artwork
                            ? Qt.resolvedUrl(face.definition.sharedHandle?.source
                                             ?? (face.definition.artwork + "handle.svg"))
                            : ""
                    rotation: face.visualAngle
                }
            }
        }
        Component {
            id: generatedFace
            RotaryFace {
                labels: face.definition ? face.definition.labels : []
                angles: face.angles
                labelEvery: face.definition ? (face.definition.labelEvery || 1) : 1
                handle: face.definition?.handle || "arrow"
                handleSize: Profiles.drawnHandleSizes[handle]
                visualAngle: face.visualAngle
                scaleMarks: !face.cadScale && (!face.definition || face.definition.scaleMarks !== false)
            }
        }
    }
}
