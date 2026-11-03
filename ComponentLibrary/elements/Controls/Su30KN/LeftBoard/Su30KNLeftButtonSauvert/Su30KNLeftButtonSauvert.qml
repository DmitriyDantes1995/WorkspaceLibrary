import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #494. Instances: btn_sauvert.
MomentaryButton {
    id: root
    my_type: "Su30KNLeftButtonSauvert"
    my_subtype: "Su30KNLeftButtonSauvert"
    implicitWidth: 44
    implicitHeight: 44.15
    previewSource: "state_0.svg"
    property int lamp: 0
    customProperties: ({ value: root.value, lamp: root.lamp })
    propertySchema: ({
        value: { displayName: "Pressed", type: "number", bindable: true, access: "readWrite", min: 0, max: 1, step: 1 },
        lamp: { displayName: "Illuminated", type: "number", bindable: true, access: "readOnly", min: 0, max: 1, step: 1 }
    })

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl((root.lamp === 1 ? "lit_" : "state_") + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }
}
