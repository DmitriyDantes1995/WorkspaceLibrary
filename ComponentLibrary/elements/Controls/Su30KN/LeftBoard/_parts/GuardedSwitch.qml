pragma ComponentBehavior: Bound

import QtQuick 2.15
import common_qml 1.0

ControlState {
    id: root

    required property url assetDirectory
    required property var clickRegions
    property int cover: 0

    customProperties: ({ value: root.value, cover: root.cover })
    propertySchema: ({
        value: {
            displayName: "Position", type: "number", bindable: true, access: "readWrite",
            min: 0, max: root.maximumValue, step: 1
        },
        cover: {
            displayName: "Guard open", type: "number", bindable: true, access: "readWrite",
            min: 0, max: 1, step: 1
        }
    })

    function setCoverFromUser(value) {
        if (cover === value) return
        cover = value
        userPropertyChanged("cover", cover)
    }

    AdaptiveSvgImage {
        anchors.fill: parent
        source: root.assetDirectory + (root.cover === 1 ? "open_" : "closed_")
                + root.currentState + ".svg"
        fillMode: Image.PreserveAspectFit
    }

    Repeater {
        model: root.clickRegions

        MouseArea {
            required property var modelData
            x: root.width * modelData.x
            y: root.height * modelData.y
            width: root.width * modelData.width
            height: root.height * modelData.height
            enabled: root.acceptsInput && (modelData.action === "open" ? root.cover === 0
                    : root.cover === 1 && (modelData.action !== "close" || root.value !== 1))
            preventStealing: true
            cursorShape: Qt.PointingHandCursor
            onPressed: {
                if (modelData.action === "open") root.setCoverFromUser(1)
                else if (modelData.action === "close") root.setCoverFromUser(0)
                else root.commitFromUser(modelData.state)
            }
        }
    }
}
