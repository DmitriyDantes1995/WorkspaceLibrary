import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root
    my_type: "Su30HydraulicIndicator"
    my_subtype: "Su30HydraulicIndicator"
    componentPath: "elements/Controls/Su30/Su30HydraulicIndicator/Su30HydraulicIndicator.qml"
    previewSource: "preview.png"
    readonly property real designWidth: 130
    readonly property real designHeight: 235
    width: designWidth; height: designHeight
    preserveAspectRatio: true
    property real system1Pressure: 0
    onSystem1PressureChanged: synchronizeState("system1Pressure", system1Pressure)
    property real system2Pressure: 0
    onSystem2PressureChanged: synchronizeState("system2Pressure", system2Pressure)
    customProperties: ({system1Pressure:system1Pressure,system2Pressure:system2Pressure})
    propertySchema: ({system1Pressure:{displayName:"HYD 1",type:"number",min:0,max:300,step:0.1,unit:"kgf/cm²",bindable:true},
        system2Pressure:{displayName:"HYD 2",type:"number",min:0,max:300,step:0.1,unit:"kgf/cm²",bindable:true}})
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
            objectName: "system1PressureBar"
            x: 10; width: 48
            y: root.mapLinearValue(root.system1Pressure, 0, 300, 215, 76, true)
            height: 215 - y
            color: "#bfd7d0"
        }
        Rectangle {
            objectName: "system2PressureBar"
            x: 72; width: 48
            y: root.mapLinearValue(root.system2Pressure, 0, 300, 215, 76, true)
            height: 215 - y
            color: "#bfd7d0"
        }
        AdaptiveSvgImage { anchors.fill:parent; source:Qt.resolvedUrl("_parts/scale.svg"); fillMode:Image.PreserveAspectFit }

    }
}
