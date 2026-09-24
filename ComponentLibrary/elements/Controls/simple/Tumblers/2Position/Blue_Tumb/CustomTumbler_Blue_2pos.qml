import QtQuick 2.0
import common_qml 1.0

BaseSceneComponent {
    id: root
    preserveAspectRatio: true

    property real oN: 0
    property bool runtimeMode: false
    width: image.implicitWidth
    height: image.implicitHeight

    my_type: "CustomTumbler_Blue_2pos"
    my_subtype: "CustomTumbler_Blue_2pos"
    previewSource: root.oN === 1 ? "Blue_tumbler_up.png" : "Blue_tumbler_down.png"
    customProperties: ({
        "oN": oN
    })
    propertySchema: ({
        "oN": {
            displayName: "Position", type: "enum", bindable: true,
            access: "readWrite",
            values: [
                { label: "Down", value: 0 },
                { label: "Up", value: 1 }
            ]
        }
    })

    function toggleFromUser() {
        root.oN = root.oN === 1 ? 0 : 1
        root.userPropertyChanged("oN", root.oN)
    }

    Image {
        id: image
        anchors.fill: parent
        source: root.oN === 1 ? "Blue_tumbler_up.png" : "Blue_tumbler_down.png"
        fillMode: Image.Stretch

        MouseArea {
            anchors.fill: parent
            enabled: root.runtimeMode
            onClicked: root.toggleFromUser()
        }
    }

}
