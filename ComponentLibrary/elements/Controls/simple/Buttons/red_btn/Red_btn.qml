import QtQuick 2.0
import common_qml 1.0

BaseSceneComponent {
    id: root
    preserveAspectRatio: true
    property real oN: 0
    property bool runtimeMode: false
    width: image.implicitWidth
    height: image.implicitHeight

    my_type: "Red_btn"
    my_subtype: "Red_btn"
    previewSource: "red_release.svg"
    customProperties: ({
        "oN": oN
    })
    propertySchema: ({
        "oN": {
            displayName: "State", type: "enum", bindable: true,
            access: "readWrite",
            values: [
                { label: "Released", value: 0 },
                { label: "Pressed", value: 1 }
            ]
        }
    })

    function setPressedFromUser(pressed) {
        root.oN = pressed ? 1 : 0
        root.userPropertyChanged("oN", root.oN)
    }

    AdaptiveSvgImage {
        id: image
        anchors.fill: parent
        source: Qt.resolvedUrl(root.oN === 1 ? "red_pressed.svg" : "red_release.svg")
        fillMode: Image.Stretch

        MouseArea {
            anchors.fill: parent
            enabled: root.runtimeMode
            onPressed: root.setPressedFromUser(true)
            onReleased: root.setPressedFromUser(false)
            onCanceled: root.setPressedFromUser(false)
        }
    }
}
