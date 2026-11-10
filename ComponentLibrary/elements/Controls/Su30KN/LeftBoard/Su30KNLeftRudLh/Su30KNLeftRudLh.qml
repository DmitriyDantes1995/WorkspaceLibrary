import QtQuick 2.15
import "_parts" as Parts
import "../../../simple/Rotaries/KnurledKnob" as Knobs
import "../../../simple/Buttons/RoundButton" as Buttons

// 1LeftBort.swf, lrud #563.
Parts.RudLever {
    id: root
    my_type: "Su30KNLeftRudLh"
    my_subtype: "Su30KNLeftRudLh"
    artworkSource: Qt.resolvedUrl("body.svg")
    artworkWidth: 717.75
    artworkHeight: 614.2
    sourceScaleX: 0.2041626
    sourceScaleY: 0.20404053
    travel: 239.2
    value: 10000

    property alias regulator: regulatorControl.value
    property alias stores: storesControl.value
    customProperties: ({ value: value, regulator: regulator, stores: stores })
    propertySchema: ({
        value: { displayName: "Положение РУД", type: "number", bindable: true, access: "readWrite", min: 0, max: 65535, step: 1 },
        regulator: { displayName: "Регулятор РУДД", type: "number", bindable: true, access: "readWrite", min: 0, max: 65535, step: 364 },
        stores: { displayName: "Кнопка сброса грузов", type: "number", bindable: true, access: "readWrite", min: 0, max: 1, step: 1 }
    })
    onRegulatorChanged: synchronizeMountedControl("regulator")
    onStoresChanged: synchronizeMountedControl("stores")

    Knobs.KnurledKnob {
        id: regulatorControl
        objectName: "regulatorControl"
        controlMode: "trim"
        z: 1
        width: 56.6
        height: 56.6
        runtimeMode: root.acceptsInput
        transform: Matrix4x4 {
            matrix: Qt.matrix4x4(5.9998, 0, 0, 216.80566,
                                 0, 5.9998, 0, 160.30566,
                                 0, 0, 1, 0,
                                 0, 0, 0, 1)
        }
        onUserPropertyChanged: function(name, value) {
            root.userPropertyChanged("regulator", value)
        }
    }

    Buttons.RoundButton {
        id: storesControl
        objectName: "storesControl"
        appearance: "whiteStem"
        z: 1
        width: 117.85
        height: 79.1
        runtimeMode: root.acceptsInput
        transform: Matrix4x4 {
            matrix: Qt.matrix4x4(0.7, 0, 0, 572.455,
                                 0, 0.7, 0, 119.715,
                                 0, 0, 1, 0,
                                 0, 0, 0, 1)
        }
        onUserPropertyChanged: function(name, value) {
            root.userPropertyChanged("stores", value)
        }
    }
}
