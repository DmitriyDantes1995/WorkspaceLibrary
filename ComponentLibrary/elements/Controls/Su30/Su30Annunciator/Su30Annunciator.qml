import QtQuick 2.15
import common_qml 1.0

Indicator {
    id: root
    my_type: "Su30Annunciator"
    my_subtype: "Su30Annunciator"
    implicitWidth: 56
    implicitHeight: 18
    previewSource: "preview.svg"
    property color onColor: "#72ffd1"
    property color offColor: "#345650"
    customProperties: ({ value: value, onColor: onColor, offColor: offColor })
    propertySchema: ({
        value: { displayName: "Illuminated", type: "number", bindable: true, access: "readOnly", min: 0, max: 1, step: 1 },
        onColor: { displayName: "On color", type: "string", bindable: false },
        offColor: { displayName: "Off color", type: "string", bindable: false }
    })
    Rectangle {
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        radius: 0
        color: root.currentState ? root.onColor : root.offColor
        border.width: Math.min(width, height) * 0.025
        border.color: Qt.darker(color, 1.2)
    }
}
