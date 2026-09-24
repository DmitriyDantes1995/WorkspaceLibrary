import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root
    preserveAspectRatio: true

    property real oN: 0
    property bool runtimeMode: false

    readonly property int currentPosition:
        Math.max(0, Math.min(1, Math.round(oN)))
    readonly property var positionSources: ["position_0.svg", "position_1.svg"]

    my_type: "StandardTumbler2Position"
    my_subtype: "StandardTumbler2Position"
    previewSource: "position_0.svg"

    width: 79.2
    height: 140.9

    customProperties: ({
        "oN": oN
    })
    propertySchema: ({
        "oN": {
            displayName: "Position", type: "enum", bindable: true,
            access: "readWrite",
            values: [
                { label: "Position 0", value: 0 },
                { label: "Position 1", value: 1 }
            ]
        }
    })

    function toggleFromUser() {
        root.oN = root.currentPosition === 0 ? 1 : 0
        root.userPropertyChanged("oN", root.oN)
    }

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl(root.positionSources[root.currentPosition])
        fillMode: Image.Stretch
        smooth: true

        MouseArea {
            anchors.fill: parent
            enabled: root.runtimeMode
            onClicked: root.toggleFromUser()
        }
    }
}
