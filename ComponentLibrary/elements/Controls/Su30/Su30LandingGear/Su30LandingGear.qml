import QtQuick 2.15
import common_qml 1.0

Toggle2Position {
    id: root
    my_type: "Su30LandingGear"
    my_subtype: "Su30LandingGear"
    componentPath: "elements/Controls/Su30/Su30LandingGear/Su30LandingGear.qml"
    previewSource: "preview.png"
    readonly property real designWidth: 135
    readonly property real designHeight: 270
    width: designWidth
    height: designHeight
    propertySchema: ({value:{displayName:"Gear lever",type:"enum",bindable:true,access:"readWrite",
        values:[{label:"Down",value:0},{label:"Up",value:1}]}})
    AdaptiveSvgImage {
        objectName: "gearLeverImage"
        anchors.fill: parent
        source: Qt.resolvedUrl(root.currentState === 0 ? "_parts/drawn-down.svg" : "_parts/drawn-up.svg")
        fillMode: Image.PreserveAspectFit
    }
}
