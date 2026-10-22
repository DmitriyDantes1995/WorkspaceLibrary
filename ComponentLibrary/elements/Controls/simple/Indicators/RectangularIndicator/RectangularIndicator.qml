import QtQuick 2.15
import common_qml 1.0

Indicator {
    id: root
    my_type: "RectangularIndicator"
    my_subtype: "RectangularIndicator"
    previewSource: "preview.svg"
    preserveAspectRatio: false
    width: 20
    height: 7
    property color offColor: "#808080"
    property color onColor: "#ff0000"
    customProperties: ({value: value, offColor: offColor, onColor: onColor})
    propertySchema: ({
        value: {displayName: "Illuminated", type: "number", bindable: true,
                access: "readOnly", min: 0, max: 1, step: 1},
        offColor: {displayName: "Off color", type: "color", bindable: false},
        onColor: {displayName: "On color", type: "color", bindable: false}
    })
    function synchronizeColor(name, next) {
        if (customProperties[name] !== next) {
            customProperties[name] = next
            customPropertiesChanged()
        }
    }
    onOffColorChanged: synchronizeColor("offColor", offColor)
    onOnColorChanged: synchronizeColor("onColor", onColor)
    Rectangle {
        objectName: "indicatorLight"
        anchors.fill: parent
        color: root.currentState ? root.onColor : root.offColor
    }
}
