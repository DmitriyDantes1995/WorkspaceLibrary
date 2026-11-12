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
    readonly property var catalogVariantProperties: ["profile"]
    readonly property string catalogSection: "scaled"
    readonly property var profiles: ({radioChannel:2,aimWave:2,aimCode:2,aimCarry:1})
    readonly property var profileNames: ({
        radioChannel: "КАНАЛ",
        aimWave: "ВОЛНА",
        aimCode: "ШИФР",
        aimCarry: "РАЗНОС"
    })
    enabled: profiles[profile] !== undefined
    customProperties:({profile:profile,value:value})
    propertySchema:({
        profile:{displayName:"Профиль",type:"enum",bindable:false,
            previewComponent:selector.profilePreview,
            values:Object.keys(profiles).map(function(name) { return {label:root.profileNames[name],value:name} })},
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
        id: face
        readonly property real layoutScale: Math.min(root.width / 100, root.height / 174)
        anchors.centerIn: parent
        width: 100 * layoutScale
        height: 174 * layoutScale
        Readouts.Su27Readout {
            objectName:"drumReadout"
            x: 22 * face.layoutScale
            width:56; height:40
            scale: face.layoutScale
            transformOrigin: Item.TopLeft
            digits:root.profiles[root.profile] || 2
            value:selector.value
        }
        Selectors.Su27Selector {
            id:selector
            objectName:"drumSelector"
            y: 66 * face.layoutScale
            width: face.width
            height: width
            profile:root.profile
            onUserPropertyChanged:function(name,next) { root.userPropertyChanged("value",next) }
        }
    }
}
