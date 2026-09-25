import QtQuick 2.15

ControlState {
    propertySchema: ({ "value": {
        displayName: "Illuminated", type: "number", bindable: true,
        access: "readOnly", min: 0, max: 1
    } })
}
