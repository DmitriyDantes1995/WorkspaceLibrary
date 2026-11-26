import QtQuick 2.15
import common_qml 1.0
import "../Su27Selector" as Selectors
import "../Su27Readout" as Readouts

BaseSceneComponent {
    id:root
    my_type:"Su27DrumSelector"
    my_subtype:"Su27DrumSelector"
    componentPath:"elements/Controls/Su27/Su27DrumSelector/Su27DrumSelector.qml"
    width:100; height:face.height
    preserveAspectRatio:true
    previewSource:"preview.svg"
    property alias runtimeMode:selector.runtimeMode
    property alias value:selector.value
    property string profile:"radioChannel"
    readonly property bool panelDrum: profile !== "radioChannel"
    readonly property var catalogVariantProperties: ["profile"]
    readonly property string catalogSection: "otherInstruments"
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
        anchors.centerIn: parent
        width: 100
        height: root.panelDrum ? 140 : 174
        scale: Math.min(root.width / width, root.height / height)
        Readouts.Su27Readout {
            objectName:"drumReadout"
            anchors.horizontalCenter: parent.horizontalCenter
            width: root.panelDrum ? (digits === 1 ? 42 : 68) : 56
            height: root.panelDrum ? 47 : 40
            style: root.panelDrum ? "blueDrum" : "drum"
            digits:root.profiles[root.profile] || 2
            value:selector.value
        }
        Rectangle {
            visible: root.profile === "aimCode"
            anchors.centerIn: selector
            width: 55
            height: width
            radius: width / 2
            border.color: "#564737"
            gradient: Gradient {
                GradientStop { position: 0; color: "#c4a982" }
                GradientStop { position: 0.5; color: "#847058" }
                GradientStop { position: 1; color: "#564536" }
            }
        }
        Selectors.Su27Selector {
            id:selector
            objectName:"drumSelector"
            anchors.horizontalCenter: parent.horizontalCenter
            y: root.panelDrum ? 62 : 66
            width: root.panelDrum ? 76 : face.width
            height: width
            handleStyle: root.panelDrum ? "radio" : "auto"
            handleSize: root.panelDrum ? 100 : 0
            profile:root.profile
            onUserPropertyChanged:function(name,next) { root.userPropertyChanged("value",next) }
        }
    }
}
