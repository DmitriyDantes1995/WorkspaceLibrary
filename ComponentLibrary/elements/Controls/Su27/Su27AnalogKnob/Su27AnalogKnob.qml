import QtQuick 2.15
import common_qml 1.0
import "../Su27Selector/_parts"

RotaryAnalog {
    id: root
    my_type: "Su27AnalogKnob"
    my_subtype: "Su27AnalogKnob"
    previewSource: "preview.png"
    componentPath: "elements/Controls/Su27/Su27AnalogKnob/Su27AnalogKnob.qml"
    implicitWidth: 148
    implicitHeight: 148
    property string profile: "volume"
    readonly property var profiles: ({
        temperature: { minimum: 15, maximum: 25, labels: ["15", "17", "19", "21", "23", "25"], handle: "arrow" },
        volume: { minimum: 0, maximum: 65535, labels: ["МЕНЬШЕ", "", "", "", "", "БОЛЬШЕ"], handle: "fluted" },
        sduKsh: { minimum: 0, maximum: 65535, labels: ["0.5", "1", "1.5", "2", "2.5", "3"], handle: "fluted" },
        lighting: { minimum: 0, maximum: 65535, labels: ["", "", "", "", "", ""], handle: "arrow" },
        pressure: { minimum: 0, maximum: 65535, labels: ["МИН", "", "", "", "", "МАКС"], handle: "fluted" },
        pressureSetting: { minimum: 5255, maximum: 8062, labels: ["МИН", "", "", "", "", "МАКС"], handle: "fluted" },
        magneticDeclination: { minimum: 0, maximum: 3600, labels: ["0", "60", "120", "180", "240", "300", "360"], handle: "fluted" },
        sduCheck: { minimum: -60, maximum: 60, minimumAngle: -60, maximumAngle: 60,
            labels: ["13", "15", "17", "30", "50"], angles: [-110, -80, -50, 50, 80], handle: "arrow" },
        calibrationScrew: { minimum: 0, maximum: 360, minimumAngle: 0, maximumAngle: 360,
            labels: [], scaleMarks: false, handle: "screw" }
    })
    readonly property var profileData: profiles[profile]
    minimumValue: profileData ? profileData.minimum : 0
    value: minimumValue
    maximumValue: profileData ? profileData.maximum : 1
    minimumAngle: profileData && profileData.minimumAngle !== undefined ? profileData.minimumAngle : -135
    maximumAngle: profileData && profileData.maximumAngle !== undefined ? profileData.maximumAngle : 135
    wheelStep: (maximumValue - minimumValue) / 100
    enabled: profileData !== undefined
    customProperties: ({ profile: profile, value: value })
    propertySchema: ({
        profile: { displayName: "Profile", type: "enum", bindable: false,
            values: Object.keys(profiles).map(function(name) { return { label: name, value: name } }) },
        value: { displayName: "Value", type: "number", bindable: true, access: "readWrite", min: minimumValue, max: maximumValue, step: wheelStep }
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
        angles: {
            if (!root.profileData) return []
            if (root.profileData.angles) return root.profileData.angles
            var result = []
            for (var i = 0; i < root.profileData.labels.length; ++i)
                result.push(root.minimumAngle + i * (root.maximumAngle - root.minimumAngle) / Math.max(1, root.profileData.labels.length - 1))
            return result
        }
        handle: root.profileData ? root.profileData.handle : "arrow"
        scaleMarks: !root.profileData || root.profileData.scaleMarks !== false
        visualAngle: root.visualAngle
        taperedScale: root.profile === "lighting"
    }
}
