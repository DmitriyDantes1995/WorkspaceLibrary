import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root
    preserveAspectRatio: true

    property real oN: 0
    property bool lidOpen: false
    property bool runtimeMode: true

    readonly property int currentPosition:
        Math.max(0, Math.min(1, Math.round(oN)))
    readonly property var positionSources: ["position_0.svg", "position_1.svg"]

    my_type: "CompactRedCoveredTumbler2Position"
    my_subtype: "CompactRedCoveredTumbler2Position"
    previewSource: "closed.svg"

    width: 38.8
    height: 84.4

    customProperties: ({
        "oN": oN
    })
    propertySchema: ({
        "oN": {
            displayName: "Position", type: "enum", bindable: true,
            access: "read",
            values: [
                { label: "Position 0", value: 0 },
                { label: "Position 1", value: 1 }
            ]
        }
    })

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl(root.lidOpen
                               ? root.positionSources[root.currentPosition]
                               : "closed.svg")
        fillMode: Image.Stretch
        smooth: true

        MouseArea {
            anchors.fill: parent
            enabled: root.runtimeMode
            onClicked: root.lidOpen = !root.lidOpen
        }
    }
}
