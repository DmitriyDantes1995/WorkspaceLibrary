import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root
    my_type: "Su30FuelIndicator"
    my_subtype: "Su30FuelIndicator"
    componentPath: "elements/Controls/Su30/Su30FuelIndicator/Su30FuelIndicator.qml"
    previewSource: "preview.png"
    readonly property real designWidth: 114
    readonly property real designHeight: 312
    width: designWidth; height: designHeight
    preserveAspectRatio: true
    property real leftQuantity: 4
    onLeftQuantityChanged: synchronizeState("leftQuantity", leftQuantity)
    property real rightQuantity: 0
    onRightQuantityChanged: synchronizeState("rightQuantity", rightQuantity)
    property int tank1: 0
    onTank1Changed: synchronizeState("tank1", tank1)
    property int tank3: 0
    onTank3Changed: synchronizeState("tank3", tank3)
    property int tankLS: 0
    onTankLSChanged: synchronizeState("tankLS", tankLS)
    property int tank4: 0
    onTank4Changed: synchronizeState("tank4", tank4)
    property int reserve: 0
    onReserveChanged: synchronizeState("reserve", reserve)
    customProperties: ({leftQuantity:leftQuantity,rightQuantity:rightQuantity,tank1:tank1,tank3:tank3,tankLS:tankLS,tank4:tank4,reserve:reserve})
    propertySchema: ({leftQuantity:{displayName:"F — left scale",type:"number",min:4,max:10,step:0.1,unit:"×1000 kg",bindable:true},
        rightQuantity:{displayName:"Q — right scale",type:"number",min:0,max:5,step:0.1,unit:"×1000 kg",bindable:true},
        tank1:{displayName:"T1",type:"enum",bindable:true,values:[{label:"Off",value:0},{label:"On",value:1}]},
        tank3:{displayName:"T3",type:"enum",bindable:true,values:[{label:"Off",value:0},{label:"On",value:1}]},
        tankLS:{displayName:"LS",type:"enum",bindable:true,values:[{label:"Off",value:0},{label:"On",value:1}]},
        tank4:{displayName:"T4",type:"enum",bindable:true,values:[{label:"Off",value:0},{label:"On",value:1}]},
        reserve:{displayName:"REM",type:"enum",bindable:true,values:[{label:"Off",value:0},{label:"On",value:1}]}})
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
            objectName: "leftQuantityBar"
            x: 53; width: 8
            y: root.mapLinearValue(root.leftQuantity, 4, 10, 278, 58, true)
            height: 278 - y
            color: "#bfd7d0"
        }
        Rectangle {
            objectName: "rightQuantityBar"
            x: 80; width: 8
            y: root.mapLinearValue(root.rightQuantity, 0, 5, 258, 76, true)
            height: 258 - y
            color: "#bfd7d0"
        }
        AdaptiveSvgImage { anchors.fill:parent; source:Qt.resolvedUrl("_parts/scale.svg"); fillMode:Image.PreserveAspectFit }
        Rectangle {
            x: 10; y: 75; width: 19; height: 26
            color: root.tank1 === 0 ? "#4d0909" : "#e13b25"
            border.color: "#1c2426"
            Text { anchors.centerIn:parent; text:"T1"; font.pixelSize:7; color:root.tank1 === 0 ? "#986e62" : "#ffe3c1" }
        }
        Rectangle {
            x: 10; y: 110; width: 19; height: 26
            color: root.tank3 === 0 ? "#4d0909" : "#e13b25"
            border.color: "#1c2426"
            Text { anchors.centerIn:parent; text:"T3"; font.pixelSize:7; color:root.tank3 === 0 ? "#986e62" : "#ffe3c1" }
        }
        Rectangle {
            x: 10; y: 145; width: 19; height: 26
            color: root.tankLS === 0 ? "#4d0909" : "#e13b25"
            border.color: "#1c2426"
            Text { anchors.centerIn:parent; text:"LS"; font.pixelSize:7; color:root.tankLS === 0 ? "#986e62" : "#ffe3c1" }
        }
        Rectangle {
            x: 10; y: 180; width: 19; height: 26
            color: root.tank4 === 0 ? "#4d0909" : "#e13b25"
            border.color: "#1c2426"
            Text { anchors.centerIn:parent; text:"T4"; font.pixelSize:7; color:root.tank4 === 0 ? "#986e62" : "#ffe3c1" }
        }
        Rectangle {
            x: 10; y: 215; width: 19; height: 26
            color: root.reserve === 0 ? "#4d0909" : "#e13b25"
            border.color: "#1c2426"
            Text { anchors.centerIn:parent; text:"REM"; font.pixelSize:7; color:root.reserve === 0 ? "#986e62" : "#ffe3c1" }
        }
    }
}
