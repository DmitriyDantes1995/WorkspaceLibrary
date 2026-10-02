import QtQuick 2.15
import common_qml 1.0

// Old configurations store visualVariant: keep its 0=down, 1=up meaning.
Toggle2Position {
    width:187; height:1085
    AdaptiveSvgImage {
        anchors.fill:parent
        source:Qt.resolvedUrl(root.value === 0 ? "../../Su30/Su30LandingGear/_parts/down.svg" : "../../Su30/Su30LandingGear/_parts/up.svg")
        fillMode:Image.PreserveAspectFit
    }
    id: root
    my_type: "LandingGearLeverVisual"
    my_subtype: "LandingGearLeverVisual"
    componentPath: "elements/Controls/Other/LandingGearLeverVisual/LandingGearLeverVisual.qml"
    previewSource: "../../Su30/Su30LandingGear/_parts/down.svg"
    property alias visualVariant: root.value
    valuePropertyName: "visualVariant"
    propertySchema: ({visualVariant:{displayName:"Gear lever",type:"enum",bindable:true,access:"readWrite",
        values:[{label:"Down",value:0},{label:"Up",value:1}]}})
}
