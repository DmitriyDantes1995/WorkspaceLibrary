import QtQuick 2.15
import common_qml 1.0
import "_parts"

BaseSceneComponent {
    id:root
    my_type:"Su30HdgBaroDisplay"
    my_subtype:"Su30HdgBaroDisplay"
    componentPath:"elements/Controls/Su30/Su30HdgBaroDisplay/Su30HdgBaroDisplay.qml"
    previewSource:"preview.png"
    width:540; height:500
    preserveAspectRatio:true
    property bool runtimeMode:false
    readonly property bool supportsWindowCapture:true
    property string targetWindowTitle:""
    property string fitMode:"fit"
    property int indicator:0
    property alias brightnessMinus:brightnessMinusControl.value
    property alias brightnessPlus:brightnessPlusControl.value
    property alias feButton:feControl.value
    property alias hdg:hdgControl.value
    property alias baro:baroControl.value
    onBrightnessMinusChanged:synchronizeState("brightnessMinus",brightnessMinus)
    onBrightnessPlusChanged:synchronizeState("brightnessPlus",brightnessPlus)
    onFeButtonChanged:synchronizeState("feButton",feButton)
    onHdgChanged:synchronizeState("hdg",hdg)
    onBaroChanged:synchronizeState("baro",baro)
    onIndicatorChanged:synchronizeState("indicator",indicator)
    onTargetWindowTitleChanged:synchronizeState("targetWindowTitle",targetWindowTitle)
    onFitModeChanged:synchronizeState("fitMode",fitMode)
    customProperties:({brightnessMinus:brightnessMinus,brightnessPlus:brightnessPlus,feButton:feButton,hdg:hdg,baro:baro,indicator:indicator,targetWindowTitle:targetWindowTitle,fitMode:fitMode})
    propertySchema:({
        brightnessMinus:{displayName:"Brightness в€’",type:"enum",bindable:true,access:"readWrite",values:[{label:"Released",value:0},{label:"Pressed",value:1}]},
        brightnessPlus:{displayName:"Brightness +",type:"enum",bindable:true,access:"readWrite",values:[{label:"Released",value:0},{label:"Pressed",value:1}]},
        feButton:{displayName:"FE",type:"enum",bindable:true,access:"readWrite",values:[{label:"Released",value:0},{label:"Pressed",value:1}]},
        hdg:{displayName:"HDG",type:"number",unit:"°",step:1,bindable:true,access:"readWrite"},
        baro:{displayName:"BARO",type:"number",unit:"°",step:1,bindable:true,access:"readWrite"},
        indicator:{displayName:"Upper indicator",type:"enum",bindable:true,values:[{label:"Off",value:0},{label:"On",value:1}]},
        targetWindowTitle:{displayName:"Window title",type:"string",bindable:true},
        fitMode:{displayName:"Fit mode",type:"enum",bindable:true,values:[{label:"Fit",value:"fit"},{label:"Crop",value:"crop"},{label:"Stretch",value:"stretch"}]}
    })
    onCustomPropertiesChanged: {
        var obsolete=["hdgMinus","hdgPlus","baroMinus","baroPlus"]
        var changed=false
        for(var i=0;i<obsolete.length;i++) {
            if(customProperties.hasOwnProperty(obsolete[i])) { delete customProperties[obsolete[i]]; changed=true }
        }
        if(!customProperties.hasOwnProperty("hdg")) { customProperties.hdg=hdg; changed=true }
        if(!customProperties.hasOwnProperty("baro")) { customProperties.baro=baro; changed=true }
        if(changed) customPropertiesChanged()
    }
    function synchronizeState(name,value){
        if(customProperties[name] !== value){customProperties[name]=value;customPropertiesChanged()}
    }
    Item {
        id:visualRoot; objectName:"visualRoot"
        width:540; height:500
        scale:Math.min(root.width/width,root.height/height)
        transformOrigin:Item.TopLeft
        x:(root.width-width*scale)/2; y:(root.height-height*scale)/2
        AdaptiveSvgImage { anchors.fill:parent;source:Qt.resolvedUrl("_parts/frame.svg") }
        // Inset inside the rounded opening: video never covers the border/corners.
        Rectangle {
            objectName:"externalWindowScreenArea"
            x:56; y:90; width:427; height:319
            color:"#2400df"; clip:true
        }
        DisplayButton {
            id:brightnessMinusControl;objectName:"brightnessMinus";x:137;y:21;runtimeMode:root.runtimeMode
            onUserPropertyChanged:function(name,value){root.userPropertyChanged("brightnessMinus",value)}
        }
        DisplayButton {
            id:brightnessPlusControl;objectName:"brightnessPlus";x:209;y:21;runtimeMode:root.runtimeMode
            onUserPropertyChanged:function(name,value){root.userPropertyChanged("brightnessPlus",value)}
        }
        DisplayButton {
            id:feControl;objectName:"feButton";x:281;y:21;runtimeMode:root.runtimeMode
            onUserPropertyChanged:function(name,value){root.userPropertyChanged("feButton",value)}
        }
        Rectangle {
            x:390;y:21;width:23;height:23;radius:8;color:"#1a292a";border.color:"#142027"
            Rectangle { anchors.centerIn:parent;width:16;height:16;radius:7;color:root.indicator ? "#c9f59a":"#7c9562";border.color:"#3f5650"
                Rectangle { anchors.centerIn:parent;width:9;height:9;radius:4;color:root.indicator ? "#e3ffc1":"#b4c29a";border.color:"#6a8264" }
            }
        }
        DirectionKnob {
            id:hdgControl;objectName:"hdg";x:86;y:434;label:"HDG";runtimeMode:root.runtimeMode
            onUserPropertyChanged:function(name,value){root.userPropertyChanged("hdg",value)}
        }
        DirectionKnob {
            id:baroControl;objectName:"baro";x:392;y:434;label:"BARO";runtimeMode:root.runtimeMode
            onUserPropertyChanged:function(name,value){root.userPropertyChanged("baro",value)}
        }
    }
}
