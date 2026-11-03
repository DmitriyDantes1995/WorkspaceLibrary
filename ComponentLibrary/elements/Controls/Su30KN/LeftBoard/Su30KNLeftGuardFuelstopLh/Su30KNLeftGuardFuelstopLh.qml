import QtQuick 2.15
import "../_parts" as LeftBoard
import "../../../simple/Buttons/red_btn" as Existing

// 1LeftBort.swf #209. Guarded fuel cutoff and independent fire-extinguisher button.
LeftBoard.GuardedSwitch {
    id: root

    my_type: "Su30KNLeftGuardFuelstopLh"
    my_subtype: "Su30KNLeftGuardFuelstopLh"
    implicitWidth: 103.55931
    implicitHeight: 84.87585
    previewSource: "preview.svg"
    assetDirectory: Qt.resolvedUrl("./")
    clickRegions: [
        {"x": 0, "y": 0.5439964, "width": 0.6686729, "height": 0.398883, "action": "open"},
        {"x": 0.6794026, "y": 0.5439565, "width": 0.222886, "height": 0.3989193, "action": "close"},
        {"x": 0.0882509, "y": 0.6875793, "width": 0.2972567, "height": 0.2176464, "action": "switch", "state": 0},
        {"x": 0.4008768, "y": 0.6875793, "width": 0.297215, "height": 0.2175884, "action": "switch", "state": 1}
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
        x: root.width * 0.10693103
        y: root.height * 0.23899164
        width: root.width * 0.22587665
        height: root.height * 0.27559819
        rotation: 89.995703
        runtimeMode: root.acceptsInput
        onUserPropertyChanged: function(propertyName, value) {
            root.userPropertyChanged("fire", value)
        }
    }
}
