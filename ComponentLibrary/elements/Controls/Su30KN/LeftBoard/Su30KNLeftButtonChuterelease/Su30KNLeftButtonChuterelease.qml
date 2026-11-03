import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite #521. Instances: btn_chuterelease.
MomentaryButton {
    id: root
    my_type: "Su30KNLeftButtonChuterelease"
    my_subtype: "Su30KNLeftButtonChuterelease"
    implicitWidth: 96.60872
    implicitHeight: 96.65857
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
