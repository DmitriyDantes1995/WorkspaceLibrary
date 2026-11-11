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
    readonly property var catalogVariantProperties: ["profile"]
    readonly property string catalogSection: "scaled"
    readonly property var profileData: Profiles.profiles[profile]
    readonly property Component profilePreview: selectorPreview
    minimumValue: profileData ? (profileData.minimum || 0) : 0
    value: minimumValue
    angles: profileData ? Profiles.anglesFor(profileData) : []
    enabled: profileData !== undefined
    customProperties: ({ profile: profile, value: value })
    propertySchema: ({
        profile: { displayName: "Profile", type: "enum", bindable: false,
            values: Profiles.choices(), previewComponent: root.profilePreview },
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
        anchors.fill: parent
        definition: root.profileData
        visualAngle: root.visualAngle
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
        readonly property var angles: definition ? Profiles.anglesFor(definition) : []
        readonly property string artwork: definition && definition.artwork ? definition.artwork : ""
        readonly property string cadScale: definition && definition.cadScale ? definition.cadScale : ""

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
                    width: parent.width * (face.definition.handleScale || 1)
                    height: width
                    source: Qt.resolvedUrl(face.definition.handleSource || (face.artwork + "handle.svg"))
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
                handle: face.definition ? face.definition.handle : "arrow"
                visualAngle: face.visualAngle
                scaleMarks: !face.cadScale && (!face.definition || face.definition.scaleMarks !== false)
            }
        }
    }
}
