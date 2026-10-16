import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root
    my_type: "Su27Voltmeter"
    my_subtype: "Su27Voltmeter"
    previewSource: "preview.png"
    componentPath: "elements/Controls/Su27/Su27Voltmeter/Su27Voltmeter.qml"
    width: 220; height: 220
    preserveAspectRatio: true
    property string profile: "dc"
    property real value: 0
    property string valueMappingMode: "Linear"
    property real inputMin: 0
    property real inputMax: profile === "ac" ? 150 : 30
    property real outputMinAngle: -135
    property real outputMaxAngle: 135
    property var valueMappingPoints: [
        {input:inputMin,output:outputMinAngle},
        {input:inputMax,output:outputMaxAngle,preserveAngularDelta:true}
    ]
    readonly property real needleVisual: mapGaugeValue(value, valueMappingMode,
        valueMappingPoints, inputMin, inputMax, outputMinAngle, outputMaxAngle, true)
    supportsGaugeCalibration: true
    gaugeCalibrationCenterX: width / 2
    gaugeCalibrationCenterY: height / 2

    customProperties: ({profile:profile, value:value,
        valueMappingMode:valueMappingMode, inputMin:inputMin, inputMax:inputMax,
        outputMinAngle:outputMinAngle, outputMaxAngle:outputMaxAngle,
        valueMappingPoints:valueMappingPoints})
    propertySchema: ({
        profile:{displayName:"Instrument",type:"enum",bindable:false,
            values:[{label:"V-1 DC 0..30 V",value:"dc"},{label:"VF-04-150 AC 0..150 V",value:"ac"}]},
        value:{displayName:"Voltage",type:"number",min:0,max:profile === "ac" ? 150 : 30,
            step:0.1,unit:"V",bindable:true,access:"readOnly"},
        valueMappingMode:{displayName:"Scale mapping",type:"enum",bindable:false,
            values:[{label:"Linear",value:"Linear"},{label:"By points",value:"ByPoints"}]},
        inputMin:{displayName:"Input Min",type:"number",bindable:false},
        inputMax:{displayName:"Input Max",type:"number",bindable:false},
        outputMinAngle:{displayName:"Angle Min",type:"number",bindable:false,unit:"deg"},
        outputMaxAngle:{displayName:"Angle Max",type:"number",bindable:false,unit:"deg"},
        valueMappingPoints:{displayName:"Calibration Points",type:"calibrationPoints",bindable:false}
    })
    onProfileChanged: {
        if (!gaugeInstanceOverride) {
            // Deserialization replaces QML bindings with values. Reapply the
            // nominal scale when changing instrument unless the host owns it.
            inputMin = 0
            inputMax = profile === "ac" ? 150 : 30
            outputMinAngle = -135
            outputMaxAngle = 135
            valueMappingMode = "Linear"
            valueMappingPoints = [
                {input:0,output:-135},
                {input:inputMax,output:135,preserveAngularDelta:true}
            ]
        }
        synchronizeState("profile", profile)
    }
    onValueChanged: synchronizeState("value", value)
    onValueMappingModeChanged: synchronizeState("valueMappingMode", valueMappingMode)
    onInputMinChanged: synchronizeState("inputMin", inputMin)
    onInputMaxChanged: synchronizeState("inputMax", inputMax)
    onOutputMinAngleChanged: synchronizeState("outputMinAngle", outputMinAngle)
    onOutputMaxAngleChanged: synchronizeState("outputMaxAngle", outputMaxAngle)
    onValueMappingPointsChanged: synchronizeState("valueMappingPoints", valueMappingPoints)
    function synchronizeState(name, state) {
        // Profile bindings can evaluate before customProperties is constructed.
        if (!customProperties)
            return
        if (customProperties[name] !== state) {
            customProperties[name] = state
            customPropertiesChanged()
        }
    }

    Item {
        width: 220; height: 220
        scale: Math.min(root.width / width, root.height / height)
        transformOrigin: Item.TopLeft
        x: (root.width - width * scale) / 2
        y: (root.height - height * scale) / 2
        Rectangle { anchors.fill: parent; radius:110; color:"#161818"; border.color:"#565755"; border.width:3 }
        Rectangle { x:7; y:7; width:206; height:206; radius:103; color:"#141616"; border.color:"#ad242b"; border.width:7 }
        Rectangle { x:16; y:16; width:188; height:188; radius:94; color:"#151716"; border.color:"#414540"; border.width:2 }
        Repeater {
            model: 31
            Item {
                required property int index
                x:110; y:110
                rotation: -135 + index * 9
                readonly property bool major: index % (root.profile === "ac" ? 6 : 10) === 0
                Rectangle { x:parent.major ? -1.7 : -0.9; y:-88; width:parent.major ? 3.4 : 1.8; height:parent.major ? 17 : 9; color:"#e8e6d7"; antialiasing:true }
            }
        }
        Repeater {
            model: root.profile === "ac" ? 6 : 4
            Text {
                required property int index
                readonly property real angle: (-135 + index * 270 / (root.profile === "ac" ? 5 : 3)) * Math.PI / 180
                x:110 + Math.sin(angle) * 61 - width / 2
                y:110 - Math.cos(angle) * 61 - height / 2
                width:34; height:32
                text:root.profile === "ac" ? index * 3 : index
                color:"#efeddd"; font.family:"Arial"; font.pixelSize:27; font.bold:true
                horizontalAlignment:Text.AlignHCenter; verticalAlignment:Text.AlignVCenter
            }
        }
        Text { x:61; y:148; width:98; height:24; text:"V\u00d710"; color:"#efeddd"; font.pixelSize:21; font.bold:true; horizontalAlignment:Text.AlignHCenter }
        Text { x:70; y:175; width:80; height:16; text:root.profile === "ac" ? "~" : "="; color:"#d2d4c7"; font.pixelSize:17; horizontalAlignment:Text.AlignHCenter }
        Item {
            objectName:"voltageNeedle"
            x:110; y:110
            rotation: root.editorCalibrationActive ? root.editorCalibrationAngle : root.needleVisual
            Rectangle { x:-1.5; y:-78; width:3; height:91; color:"#f2f1df"; antialiasing:true }
            Rectangle { x:-5; y:-10; width:10; height:25; color:"#222522"; antialiasing:true }
        }
        Rectangle { x:101; y:101; width:18; height:18; radius:9; color:"#242724"; border.color:"#565b52"; border.width:2 }
    }
}
