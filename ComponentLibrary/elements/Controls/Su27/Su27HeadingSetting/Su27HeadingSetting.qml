import QtQuick 2.15
import common_qml 1.0
import "../Su27AnalogKnob" as Knobs
import "../Su27Readout" as Readouts

BaseSceneComponent {
    id: root
    my_type: "Su27HeadingSetting"
    my_subtype: "Su27HeadingSetting"
    previewSource: "preview.png"
    componentPath: "elements/Controls/Su27/Su27HeadingSetting/Su27HeadingSetting.qml"
    width: 148
    height: 185
    preserveAspectRatio: true
    property alias value: knob.value
    property alias runtimeMode: knob.runtimeMode
    customProperties: ({ value: value })
    propertySchema: ({ value: {
        displayName: "Magnetic declination (0.1 deg)", type: "number",
        min: 0, max: 3600, step: 1, bindable: true, access: "readWrite"
    } })
    onValueChanged: {
        if (customProperties && customProperties.value !== value) {
            customProperties.value = value
            customPropertiesChanged()
        }
    }
    Item {
        width: 148
        height: 185
        scale: Math.min(root.width / width, root.height / height)
        transformOrigin: Item.TopLeft
        x: (root.width - width * scale) / 2
        y: (root.height - height * scale) / 2
        Knobs.Su27AnalogKnob {
            id: knob
            objectName: "headingKnob"
            width: 148
            height: 148
            profile: "magneticDeclination"
            onUserPropertyChanged: function(name, next) { root.userPropertyChanged(name, next) }
        }
        Readouts.Su27Readout {
            objectName: "headingWindow"
            x: 33
            y: 150
            width: 82
            height: 30
            value: root.value / 10
            digits: 4
            decimals: 1
        }
    }
}
