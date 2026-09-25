import QtQuick 2.15

BaseSceneComponent {
    id: root
    implicitWidth: 64
    implicitHeight: 64
    preserveAspectRatio: true
    property bool runtimeMode: false
    property real value: 0
    property real minimumValue: 0
    property real maximumValue: 1
    property bool discrete: true
    property string valuePropertyName: "value"
    readonly property real currentState: value
    readonly property int stateCount: discrete ? Math.round(maximumValue - minimumValue) + 1 : 0
    readonly property bool acceptsInput: runtimeMode && enabled
    customProperties: ({ [valuePropertyName]: value })
    propertySchema: ({ [valuePropertyName]: {
        displayName: "Value", type: "number",
        bindable: true, access: "readWrite", min: minimumValue, max: maximumValue,
        step: discrete ? 1 : 0.01
    } })

    function normalized(next) {
        var number = Number(next)
        if (!isFinite(number)) number = minimumValue
        return Math.max(minimumValue, Math.min(maximumValue, discrete ? Math.round(number) : number))
    }
    function commitFromUser(next) {
        var bounded = normalized(next)
        if (value === bounded) return
        value = bounded
        userPropertyChanged(valuePropertyName, value)
    }
    function synchronizePropertyMap() {
        // Scene loaders may replace the initial binding with a deserialized map.
        if (customProperties[valuePropertyName] !== value) {
            customProperties[valuePropertyName] = value
            customPropertiesChanged()
        }
    }
    onValueChanged: {
        var bounded = normalized(value)
        if (value !== bounded) value = bounded
        synchronizePropertyMap()
    }
    onMinimumValueChanged: value = normalized(value)
    onMaximumValueChanged: value = normalized(value)
}
