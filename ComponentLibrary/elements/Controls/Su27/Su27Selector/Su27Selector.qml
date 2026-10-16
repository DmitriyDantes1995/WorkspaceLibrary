import QtQuick 2.15
import common_qml 1.0
import "Profiles.js" as Profiles
import "_parts"

RotaryDiscrete {
    id: root
    my_type: "Su27Selector"
    my_subtype: "Su27Selector"
    previewSource: "preview.png"
    componentPath: "elements/Controls/Su27/Su27Selector/Su27Selector.qml"
    implicitWidth: 148
    implicitHeight: 148
    property string profile: "radarMode"
    readonly property var profileData: Profiles.profiles[profile]
    minimumValue: profileData ? (profileData.minimum || 0) : 0
    value: minimumValue
    angles: profileData ? Profiles.anglesFor(profileData) : []
    enabled: profileData !== undefined
    customProperties: ({ profile: profile, value: value })
    propertySchema: ({
        profile: { displayName: "Profile", type: "enum", bindable: false, values: Profiles.choices() },
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
    RotaryFace {
        anchors.fill: parent
        labels: root.profileData ? root.profileData.labels : []
        angles: root.angles
        labelEvery: root.profileData ? (root.profileData.labelEvery || 1) : 1
        handle: root.profileData ? root.profileData.handle : "arrow"
        visualAngle: root.visualAngle
    }
}
