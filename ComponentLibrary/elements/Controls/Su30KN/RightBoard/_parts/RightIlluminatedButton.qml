import QtQuick 2.15
import common_qml 1.0

MomentaryButton {
    id: root

    required property url assetDirectory
    property int lamp: 0
    property bool testMode: false

    customProperties: ({ value: root.value, lamp: root.lamp, testMode: root.testMode })
    propertySchema: ({
        value: { displayName: "Pressed", type: "number", bindable: true, access: "readWrite", min: 0, max: 1, step: 1 },
        lamp: { displayName: "Illuminated", type: "number", bindable: true, access: "readOnly", min: 0, max: 1, step: 1 },
        testMode: { displayName: "Test mode", type: "bool", bindable: false, access: "readWrite" }
    })

    onLampChanged: {
        if (customProperties.lamp !== lamp) {
            customProperties.lamp = lamp
            customPropertiesChanged()
        }
    }

    onTestModeChanged: {
        if (customProperties.testMode !== testMode) {
            customProperties.testMode = testMode
            customPropertiesChanged()
        }
    }

    onUserPropertyChanged: function(propertyName, value) {
        if (root.testMode && propertyName === root.valuePropertyName && root.lamp !== value) {
            root.lamp = value
            root.userPropertyChanged("lamp", value)
        }
    }

    AdaptiveSvgImage {
        anchors.fill: parent
        source: root.assetDirectory + (root.lamp === 1 ? "lit_" : "state_") + root.currentState + ".svg"
        fillMode: Image.PreserveAspectFit
    }
}
