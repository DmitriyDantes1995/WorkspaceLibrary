import QtQuick 2.15
import "../_parts" as LeftBoard
import "../../../simple/Buttons/red_btn" as Existing

// 1LeftBort.swf #214. Guarded fuel cutoff and independent fire-extinguisher button.
LeftBoard.GuardedSwitch {
    id: root

    my_type: "Su30KNLeftGuardFuelstopRh"
    my_subtype: "Su30KNLeftGuardFuelstopRh"
    implicitWidth: 109.73839
    implicitHeight: 88.731045
    previewSource: "preview.svg"
    assetDirectory: Qt.resolvedUrl("./")
    clickRegions: [
        {"x": 0, "y": 0.1873454, "width": 0.6310217, "height": 0.3815523, "action": "open"},
        {"x": 0.6411472, "y": 0.1873073, "width": 0.2103359, "height": 0.381587, "action": "close"},
        {"x": 0.0832817, "y": 0.32469, "width": 0.2805189, "height": 0.2081901, "action": "switch", "state": 0},
        {"x": 0.3783045, "y": 0.32469, "width": 0.2804796, "height": 0.2081346, "action": "switch", "state": 1}
    ]

    property alias fire: fireButton.oN
    customProperties: ({ value: root.value, cover: root.cover, fire: root.fire })
    propertySchema: ({
        value: {
            displayName: "Position", type: "number", bindable: true, access: "readWrite",
            min: 0, max: 1, step: 1
        },
        cover: {
            displayName: "Guard open", type: "number", bindable: true, access: "readWrite",
            min: 0, max: 1, step: 1
        },
        fire: {
            displayName: "Fire extinguisher", type: "number", bindable: true, access: "readWrite",
            min: 0, max: 1, step: 1
        }
    })

    Existing.Red_btn {
        id: fireButton
        x: root.width * 0.10848312
        y: root.height * 0.6399339
        width: root.width * 0.21315812
        height: root.height * 0.26362397
        rotation: 89.995703
        runtimeMode: root.acceptsInput
        onUserPropertyChanged: function(propertyName, value) {
            root.userPropertyChanged("fire", value)
        }
    }
}
