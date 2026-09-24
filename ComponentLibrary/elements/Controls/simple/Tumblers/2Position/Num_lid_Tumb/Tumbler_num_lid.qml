import QtQuick 2.0
import common_qml 1.0

BaseSceneComponent {
    id: root
    preserveAspectRatio: true

    property real oN: 0
    property bool lidOpen: false
property bool runtimeMode: true

    width: image.implicitWidth
    height: image.implicitHeight

    my_type: "CustomTumbler_Lid_Num"
    my_subtype: "CustomTumbler_Lid_Num"

    previewSource: "close_lid.svg"

    customProperties: ({
        "oN": oN
    })
    propertySchema: ({
        "oN": {
            displayName: "Position", type: "enum", bindable: true,
            access: "read",
            values: [
                { label: "Down", value: 0 },
                { label: "Up", value: 1 }
            ]
        }
    })

    AdaptiveSvgImage {
        id: image

        anchors.fill: parent

        source: {
            if (!root.lidOpen)
                return Qt.resolvedUrl("close_lid.svg")

            return Qt.resolvedUrl(root.oN === 1
                                  ? "open_lid_up.svg" : "open_lid_down.svg")
        }

        fillMode: Image.Stretch

        MouseArea {
            anchors.fill: parent
            enabled: root.runtimeMode

            onClicked: {
                root.lidOpen = !root.lidOpen
            }
        }
    }
}
