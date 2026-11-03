import QtQuick 2.15
import "../Su30KNLeftRudLh/_parts" as Parts
import "../Su30KNLeftButtonStores" as ButtonStores
import "../Su30KNLeftButtonRudvp" as ButtonRudvp
import "../Su30KNLeftButtonRudmrk" as ButtonRudmrk
import "../Su30KNLeftButtonRudradio" as ButtonRudradio
import "../Su30KNLeftSwitchRudairbrake" as SwitchRudairbrake

// 1LeftBort.swf, rrud #589.
Parts.RudLever {
    id: root
    my_type: "Su30KNLeftRudRh"
    my_subtype: "Su30KNLeftRudRh"
    artworkSource: Qt.resolvedUrl("body.svg")
    artworkWidth: 601.85
    artworkHeight: 774
    sourceScaleX: 0.2041626
    sourceScaleY: 0.2041626
    travel: 239.1
    value: 44000

    property alias reset: resetControl.value
    property alias rudvp: rudvpControl.value
    property alias spu: spuControl.value
    property alias marker: markerControl.value
    property alias radio: radioControl.value
    property alias airbrake: airbrakeControl.value
    customProperties: ({ value: value, reset: reset, rudvp: rudvp, spu: spu, marker: marker, radio: radio, airbrake: airbrake })
    propertySchema: ({
        value: { displayName: "Положение РУД", type: "number", bindable: true, access: "readWrite", min: 0, max: 65535, step: 1 },
        reset: { displayName: "Кнопка сброса", type: "number", bindable: true, access: "readWrite", min: 0, max: 1, step: 1 },
        rudvp: { displayName: "Кнопка ВП", type: "number", bindable: true, access: "readWrite", min: 0, max: 1, step: 1 },
        spu: { displayName: "Кнопка СПУ", type: "number", bindable: true, access: "readWrite", min: 0, max: 1, step: 1 },
        marker: { displayName: "Кнопка МРК", type: "number", bindable: true, access: "readWrite", min: 0, max: 1, step: 1 },
        radio: { displayName: "Кнопка радио", type: "number", bindable: true, access: "readWrite", min: 0, max: 1, step: 1 },
        airbrake: { displayName: "Воздушный тормоз", type: "number", bindable: true, access: "readWrite", min: 0, max: 1, step: 1 }
    })
    onResetChanged: synchronizeMountedControl("reset")
    onRudvpChanged: synchronizeMountedControl("rudvp")
    onSpuChanged: synchronizeMountedControl("spu")
    onMarkerChanged: synchronizeMountedControl("marker")
    onRadioChanged: synchronizeMountedControl("radio")
    onAirbrakeChanged: synchronizeMountedControl("airbrake")

    ButtonStores.Su30KNLeftButtonStores {
        id: resetControl
        objectName: "resetControl"
        z: 1
        width: 117.85
        height: 79.1
        runtimeMode: root.acceptsInput
        transform: Matrix4x4 {
            matrix: Qt.matrix4x4(0.0001, -0.6, 0, 416.27651,
                                 0.6, 0.0001, 0, 275.33779,
                                 0, 0, 1, 0,
                                 0, 0, 0, 1)
        }
        onUserPropertyChanged: function(name, value) {
            root.userPropertyChanged("reset", value)
        }
    }

    ButtonRudvp.Su30KNLeftButtonRudvp {
        id: rudvpControl
        objectName: "rudvpControl"
        z: 1
        width: 96
        height: 87
        runtimeMode: root.acceptsInput
        transform: Matrix4x4 {
            matrix: Qt.matrix4x4(1.3, 0, 0, 268.15,
                                 0, 1.4, 0, 564.9,
                                 0, 0, 1, 0,
                                 0, 0, 0, 1)
        }
        onUserPropertyChanged: function(name, value) {
            root.userPropertyChanged("rudvp", value)
        }
    }

    ButtonRudvp.Su30KNLeftButtonRudvp {
        id: spuControl
        objectName: "spuControl"
        z: 1
        width: 96
        height: 87
        runtimeMode: root.acceptsInput
        transform: Matrix4x4 {
            matrix: Qt.matrix4x4(-0.3643, -1.3399, 0, 182.3521,
                                 1.2443, -0.3922, 0, 581.6382,
                                 0, 0, 1, 0,
                                 0, 0, 0, 1)
        }
        onUserPropertyChanged: function(name, value) {
            root.userPropertyChanged("spu", value)
        }
    }

    ButtonRudmrk.Su30KNLeftButtonRudmrk {
        id: markerControl
        objectName: "markerControl"
        z: 1
        width: 122.8
        height: 122.8
        runtimeMode: root.acceptsInput
        transform: Matrix4x4 {
            matrix: Qt.matrix4x4(1.3, 0, 0, 131.095,
                                 0, 1.3, 0, 110.515,
                                 0, 0, 1, 0,
                                 0, 0, 0, 1)
        }
        onUserPropertyChanged: function(name, value) {
            root.userPropertyChanged("marker", value)
        }
    }

    ButtonRudradio.Su30KNLeftButtonRudradio {
        id: radioControl
        objectName: "radioControl"
        z: 1
        width: 104.8
        height: 122.8
        runtimeMode: root.acceptsInput
        transform: Matrix4x4 {
            matrix: Qt.matrix4x4(1.2006, 0, 0, 381.19739,
                                 0, 1.1996, 0, 106.38458,
                                 0, 0, 1, 0,
                                 0, 0, 0, 1)
        }
        onUserPropertyChanged: function(name, value) {
            root.userPropertyChanged("radio", value)
        }
    }

    SwitchRudairbrake.Su30KNLeftSwitchRudairbrake {
        id: airbrakeControl
        objectName: "airbrakeControl"
        z: 1
        width: 170.0163
        height: 102.9742
        runtimeMode: root.acceptsInput
        transform: Matrix4x4 {
            matrix: Qt.matrix4x4(0.60001704, -7.2124532e-06, 0, 276.93397,
                                 7.2124532e-06, 0.60001704, 0, 404.79378,
                                 0, 0, 1, 0,
                                 0, 0, 0, 1)
        }
        onUserPropertyChanged: function(name, value) {
            root.userPropertyChanged("airbrake", value)
        }
    }
}
