import QtQuick 2.15
import common_qml 1.0
import "_parts"

BaseSceneComponent {
    id: root
    my_type: "Su30Clock"
    my_subtype: "Su30Clock"
    componentPath: "elements/Controls/Su30/Su30Clock/Su30Clock.qml"
    previewSource: "preview.png"
    readonly property real designWidth: 200
    readonly property real designHeight: 210
    width: designWidth; height: designHeight
    preserveAspectRatio: true
    property bool runtimeMode: false
    // Model-owned seconds; no autonomous timer or local stopwatch state.
    property real timeSeconds: 0
    property real flightSeconds: 0
    property real stopwatchSeconds: 0
    property alias flightButton: flightControl.value
    property alias stopwatchButton: stopwatchControl.value
    onTimeSecondsChanged: synchronizeState("timeSeconds", timeSeconds)
    onFlightSecondsChanged: synchronizeState("flightSeconds", flightSeconds)
    onStopwatchSecondsChanged: synchronizeState("stopwatchSeconds", stopwatchSeconds)
    onFlightButtonChanged: synchronizeState("flightButton", flightButton)
    onStopwatchButtonChanged: synchronizeState("stopwatchButton", stopwatchButton)
    customProperties: ({timeSeconds:timeSeconds,flightSeconds:flightSeconds,stopwatchSeconds:stopwatchSeconds,
                        flightButton:flightButton,stopwatchButton:stopwatchButton})
    propertySchema: ({
        timeSeconds:{displayName:"Time of day",type:"number",unit:"s",min:0,max:86400,step:1,bindable:true},
        flightSeconds:{displayName:"Flight time",type:"number",unit:"s",min:0,max:43200,step:1,bindable:true},
        stopwatchSeconds:{displayName:"Stopwatch",type:"number",unit:"s",min:0,max:3600,step:1,bindable:true},
        flightButton:{displayName:"Flight button",type:"enum",bindable:true,access:"readWrite",
            values:[{label:"Released",value:0},{label:"Pressed",value:1}]},
        stopwatchButton:{displayName:"Stopwatch button",type:"enum",bindable:true,access:"readWrite",
            values:[{label:"Released",value:0},{label:"Pressed",value:1}]}
    })
    function synchronizeState(name, value) {
        if (customProperties[name] !== value) {
            customProperties[name] = value
            customPropertiesChanged()
        }
    }
    function angle(seconds, period) { return (Math.max(0, seconds) % period) * 360 / period }
    Item {
        id: visualRoot
        objectName: "visualRoot"
        width: root.designWidth; height: root.designHeight
        scale: Math.min(root.width / width, root.height / height)
        transformOrigin: Item.TopLeft
        x: (root.width - width * scale) / 2
        y: (root.height - height * scale) / 2
        AdaptiveSvgImage { anchors.fill:parent; source:Qt.resolvedUrl("_parts/face.svg"); fillMode:Image.PreserveAspectFit }
        ClockHand { objectName:"flightHourHand"; x:67; y:124; handLength:12; thickness:2.3; rotation:root.angle(root.flightSeconds,43200) }
        ClockHand { objectName:"flightMinuteHand"; x:67; y:124; handLength:21; thickness:1.4; rotation:root.angle(root.flightSeconds,3600) }
        ClockHand { objectName:"stopwatchMinuteHand"; x:133; y:124; handLength:21; thickness:1.4; rotation:root.angle(root.stopwatchSeconds,3600) }
        ClockHand { objectName:"hourHand"; x:100; y:96; handLength:42; thickness:3; rotation:root.angle(root.timeSeconds,43200) }
        ClockHand { objectName:"minuteHand"; x:100; y:96; handLength:65; thickness:2.3; rotation:root.angle(root.timeSeconds,3600) }
        ClockHand { objectName:"secondHand"; x:100; y:96; handLength:73; thickness:1; handColor:"#e7a15a"; rotation:root.angle(root.timeSeconds,60) }
        ClockHand { objectName:"stopwatchSecondHand"; x:100; y:96; handLength:66; thickness:1.2; tail:14; rotation:root.angle(root.stopwatchSeconds,60) }
        Rectangle { x:98; y:94; width:4; height:4; radius:2; color:"#edf0b8" }
        ClockButton {
            id:flightControl; objectName:"flightButton"; x:34; y:173
            runtimeMode:root.runtimeMode
            onUserPropertyChanged: function(name,value) { root.userPropertyChanged("flightButton",value) }
        }
        ClockButton {
            id:stopwatchControl; objectName:"stopwatchButton"; x:132; y:173; label:"ПУСК"
            runtimeMode:root.runtimeMode
            onUserPropertyChanged: function(name,value) { root.userPropertyChanged("stopwatchButton",value) }
        }
    }
}
