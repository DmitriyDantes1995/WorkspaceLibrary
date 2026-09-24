import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root
    preserveAspectRatio: true

    property real pos: 0
    property bool runtimeMode: false

    readonly property int currentPosition:
        Math.max(0, Math.min(2, Math.round(pos)))
    readonly property var positionSources: ["position_0.svg", "position_1.svg", "position_2.svg"]

    my_type: "GraySquareTumbler3Position"
    my_subtype: "GraySquareTumbler3Position"
    previewSource: "position_0.svg"

    width: 114.6
    height: 214.8

    customProperties: ({
        "pos": pos
    })
    propertySchema: ({
        "pos": {
            displayName: "Position", type: "enum", bindable: true,
            access: "readWrite",
            values: [
                { label: "Position 0", value: 0 },
                { label: "Position 1", value: 1 },
                { label: "Position 2", value: 2 }
            ]
        }
    })

    function advancePositionFromUser() {
        root.pos = (root.currentPosition + 1) % 3
        root.userPropertyChanged("pos", root.pos)
    }

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl(root.positionSources[root.currentPosition])
        fillMode: Image.Stretch
        smooth: true

        MouseArea {
            anchors.fill: parent
            enabled: root.runtimeMode

            onClicked: root.advancePositionFromUser()
        }
    }
}
