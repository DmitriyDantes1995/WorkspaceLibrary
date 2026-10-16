import QtQuick 2.15
import common_qml 1.0
import "../Su27Selector" as Selectors
import "../Su27Readout" as Readouts

BaseSceneComponent {
    id:root
    my_type:"Su27DrumSelector"
    my_subtype:"Su27DrumSelector"
    componentPath:"elements/Controls/Su27/Su27DrumSelector/Su27DrumSelector.qml"
    width:100; height:174
    preserveAspectRatio:true
    previewSource:"preview.svg"
    property alias runtimeMode:selector.runtimeMode
    property alias value:selector.value
    property string profile:"radioChannel"
    readonly property var profiles: ({radioChannel:2,aimWave:2,aimCode:2,aimCarry:1})
    enabled: profiles[profile] !== undefined
    customProperties:({profile:profile,value:value})
    propertySchema:({
        profile:{displayName:"Профиль",type:"enum",bindable:false,
            values:Object.keys(profiles).map(function(name) { return {label:name,value:name} })},
        value:{displayName:"Положение",type:"number",min:selector.minimumValue,max:selector.maximumValue,
            step:1,bindable:true,access:"readWrite"}
    })
    function synchronizeState() {
        if (!customProperties) return
        if (customProperties.profile !== profile || customProperties.value !== value) {
            customProperties.profile=profile
            customProperties.value=value
            customPropertiesChanged()
        }
    }
    onValueChanged:synchronizeState()
    onProfileChanged:synchronizeState()
    Item {
        width:100; height:174
        scale:Math.min(root.width/width,root.height/height)
        transformOrigin:Item.TopLeft
        x:(root.width-width*scale)/2
        y:(root.height-height*scale)/2
        Readouts.Su27Readout {
            objectName:"drumReadout"
            x:22; y:0; width:56; height:40
            digits:root.profiles[root.profile] || 2
            value:selector.value
        }
        Selectors.Su27Selector {
            id:selector
            objectName:"drumSelector"
            x:0; y:66; width:100; height:100
            profile:root.profile
            onUserPropertyChanged:function(name,next) { root.userPropertyChanged("value",next) }
        }
    }
}
