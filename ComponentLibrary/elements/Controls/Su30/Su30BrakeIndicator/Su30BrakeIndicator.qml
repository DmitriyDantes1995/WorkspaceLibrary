import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root
    my_type: "Su30BrakeIndicator"
    my_subtype: "Su30BrakeIndicator"
    componentPath: "elements/Controls/Su30/Su30BrakeIndicator/Su30BrakeIndicator.qml"
    previewSource: "preview.png"
    readonly property real designWidth: 240
    readonly property real designHeight: 245
    width: designWidth; height: designHeight
    preserveAspectRatio: true
    property real leftBrakePressure: 0
    onLeftBrakePressureChanged: synchronizeState("leftBrakePressure", leftBrakePressure)
    property real rightBrakePressure: 0
    onRightBrakePressureChanged: synchronizeState("rightBrakePressure", rightBrakePressure)
    property real airPressure: 0
    onAirPressureChanged: synchronizeState("airPressure", airPressure)
    property bool runtimeMode: false
    property alias checkButton: checkControl.value
    onCheckButtonChanged: synchronizeState("checkButton", checkButton)
    customProperties: ({leftBrakePressure:leftBrakePressure,rightBrakePressure:rightBrakePressure,airPressure:airPressure,checkButton:checkButton})
    propertySchema: ({leftBrakePressure:{displayName:"Brake LH",type:"number",min:0,max:300,step:0.1,unit:"kgf/cm²",bindable:true},
        rightBrakePressure:{displayName:"Brake RH",type:"number",min:0,max:300,step:0.1,unit:"kgf/cm²",bindable:true},
        airPressure:{displayName:"Air",type:"number",min:0,max:300,step:0.1,unit:"kgf/cm²",bindable:true},
        checkButton:{displayName:"HYD ACC CHECK",type:"enum",bindable:true,access:"readWrite",values:[{label:"Released",value:0},{label:"Pressed",value:1}]}})
    function synchronizeState(name, value) {
        if (customProperties[name] !== value) {
            customProperties[name] = value
            customPropertiesChanged()
        }
    }
    Item {
        id: visualRoot
        objectName: "visualRoot"
        width: root.designWidth; height: root.designHeight
        scale: Math.min(root.width / width, root.height / height)
        transformOrigin: Item.TopLeft
        x: (root.width - width * scale) / 2
        y: (root.height - height * scale) / 2
        AdaptiveSvgImage { anchors.fill:parent; source:Qt.resolvedUrl("_parts/background.svg"); fillMode:Image.PreserveAspectFit }
        Rectangle {
            objectName: "leftBrakePressureBar"
            x: 7; width: 48
            y: root.mapLinearValue(root.leftBrakePressure, 0, 300, 225, 78, true)
            height: 225 - y
            color: "#bfd7d0"
        }
        Rectangle {
            objectName: "rightBrakePressureBar"
            x: 67; width: 48
            y: root.mapLinearValue(root.rightBrakePressure, 0, 300, 225, 78, true)
            height: 225 - y
            color: "#bfd7d0"
        }
        Rectangle {
            objectName: "airPressureBar"
            x: 127; width: 48
            y: root.mapLinearValue(root.airPressure, 0, 300, 225, 78, true)
            height: 225 - y
            color: "#bfd7d0"
        }
        AdaptiveSvgImage { anchors.fill:parent; source:Qt.resolvedUrl("_parts/scale.svg"); fillMode:Image.PreserveAspectFit }
        MomentaryButton {
            id:checkControl; objectName:"checkButton"
            x:194; y:185; width:30; height:30
            runtimeMode:root.runtimeMode
            onUserPropertyChanged: function(name,value) { root.userPropertyChanged("checkButton",value) }
            Rectangle { anchors.fill:parent; radius:15; color:"#cbd697"; border.color:"#8e9b6f"
                Rectangle { anchors.centerIn:parent; width:parent.width-10; height:width; radius:width/2;
                    color:checkControl.currentState ? "#a7b2aa" : "#eef5e1"; border.color:"#63847e" }
            }
        }
    }
}
