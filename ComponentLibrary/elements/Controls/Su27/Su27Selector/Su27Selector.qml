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
        angles: root.angles
        visualAngle: root.visualAngle
    }

    Component {
        id: selectorPreview
        SelectorFace {
            property string previewValue: "radarMode"
            definition: Profiles.profiles[previewValue]
            visualAngle: angles.length ? angles[0] : 0
        }
    }

    component SelectorFace: RotaryFace {
        property var definition: null
        labels: definition ? definition.labels : []
        angles: definition ? Profiles.anglesFor(definition) : []
        labelEvery: definition ? (definition.labelEvery || 1) : 1
        handle: definition ? definition.handle : "arrow"
    }
}
