import QtQuick 2.0
import common_qml 1.0

BaseSceneComponent {
    id: root
    preserveAspectRatio: true
    property real oN: 0
    width: image.implicitWidth
    height: image.implicitHeight

    my_type: "Green_lb"
    my_subtype: "Green_lb"
    previewSource: "Green_lb_off_100.svg"
    customProperties: ({
        "oN": oN
    })
    propertySchema: ({
        "oN": {
            displayName: "State", type: "enum", bindable: true,
            values: [
                { label: "Off", value: 0 },
                { label: "On", value: 1 }
            ]
        }
    })

    AdaptiveSvgImage {
        id: image
        anchors.fill: parent
        source: Qt.resolvedUrl(root.oN === 1 ? "Green_lb_on_100.svg" : "Green_lb_off_100.svg")
        fillMode: Image.Stretch
    }
}
