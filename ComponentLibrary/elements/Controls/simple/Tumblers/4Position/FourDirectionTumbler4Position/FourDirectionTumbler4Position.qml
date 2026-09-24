import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root
    preserveAspectRatio: true

    property real pos: 0
    property bool runtimeMode: false

    readonly property int currentPosition:
        Math.max(0, Math.min(3, Math.round(pos)))
    readonly property var positionSources: ["position_0.png", "position_1.png", "position_2.png", "position_3.png"]

    my_type: "FourDirectionTumbler4Position"
    my_subtype: "FourDirectionTumbler4Position"
    previewSource: "position_0.png"

    width: 57
    height: 58

    customProperties: ({
        "pos": pos
    })
    propertySchema: ({
        "pos": {
            displayName: "Position",
            type: "enum",
            bindable: true,
            access: "readWrite",
            values: [
                { label: "Position 0", value: 0 },
                { label: "Position 1", value: 1 },
                { label: "Position 2", value: 2 },
                { label: "Position 3", value: 3 }
            ]
        }
    })

    function advancePositionFromUser() {
        root.pos = (root.currentPosition + 1) % 4
        root.userPropertyChanged("pos", root.pos)
    }

    Image {
        anchors.fill: parent
        source: root.positionSources[root.currentPosition]
        fillMode: Image.Stretch
        smooth: true

        MouseArea {
            anchors.fill: parent
            enabled: root.runtimeMode
            onClicked: root.advancePositionFromUser()
        }
    }
}
