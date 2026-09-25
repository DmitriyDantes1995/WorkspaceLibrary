import QtQuick 2.15
import common_qml 1.0

Toggle2Position {
    id: root
    preserveAspectRatio: true

    property alias oN: root.value
    valuePropertyName: "oN"

    readonly property int currentPosition:
        currentState
    readonly property var positionSources: ["position_0.svg", "position_1.svg"]

    my_type: "GrayTumbler2Position"
    my_subtype: "GrayTumbler2Position"
    previewSource: "position_0.svg"

    width: 8.4
    height: 59.6

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

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl(root.positionSources[root.currentPosition])
        fillMode: Image.Stretch
        smooth: true

    }
}
