import QtQuick 2.15
import common_qml 1.0
import "_parts"

BaseSceneComponent {
    id:root
    my_type:"Su30EkranDisplay"
    my_subtype:"Su30EkranDisplay"
    componentPath:"elements/Controls/Su30/Su30EkranDisplay/Su30EkranDisplay.qml"
    previewSource:"preview.png"
    width:102.6;height:197.85
    preserveAspectRatio:true
    property bool runtimeMode:false
    readonly property bool supportsWindowCapture:true
    property string targetWindowTitle:""
    property string fitMode:"fit"
    property alias button1:key1.value
    onButton1Changed:synchronizeState("button1",button1)
    property alias button3:key3.value
    onButton3Changed:synchronizeState("button3",button3)
    property alias button5:key5.value
    onButton5Changed:synchronizeState("button5",button5)
    property alias button7:key7.value
    onButton7Changed:synchronizeState("button7",button7)
    property alias button9:key9.value
    onButton9Changed:synchronizeState("button9",button9)
    property alias buttonF:keyF.value
    onButtonFChanged:synchronizeState("buttonF",buttonF)
    property alias button2:key2.value
    onButton2Changed:synchronizeState("button2",button2)
    property alias button4:key4.value
    onButton4Changed:synchronizeState("button4",button4)
    property alias button6:key6.value
    onButton6Changed:synchronizeState("button6",button6)
    property alias button8:key8.value
    onButton8Changed:synchronizeState("button8",button8)
    property alias button0:key0.value
    onButton0Changed:synchronizeState("button0",button0)
    property alias buttonE:keyE.value
    onButtonEChanged:synchronizeState("buttonE",buttonE)
    onTargetWindowTitleChanged:synchronizeState("targetWindowTitle",targetWindowTitle)
    onFitModeChanged:synchronizeState("fitMode",fitMode)
    customProperties:({button1:button1,button3:button3,button5:button5,button7:button7,button9:button9,buttonF:buttonF,button2:button2,button4:button4,button6:button6,button8:button8,button0:button0,buttonE:buttonE,targetWindowTitle:targetWindowTitle,fitMode:fitMode})
    propertySchema:({
        button1:{displayName:"1",type:"enum",bindable:true,access:"readWrite",values:[{label:"Released",value:0},{label:"Pressed",value:1}]},
        button3:{displayName:"3",type:"enum",bindable:true,access:"readWrite",values:[{label:"Released",value:0},{label:"Pressed",value:1}]},
        button5:{displayName:"5",type:"enum",bindable:true,access:"readWrite",values:[{label:"Released",value:0},{label:"Pressed",value:1}]},
        button7:{displayName:"7",type:"enum",bindable:true,access:"readWrite",values:[{label:"Released",value:0},{label:"Pressed",value:1}]},
        button9:{displayName:"9",type:"enum",bindable:true,access:"readWrite",values:[{label:"Released",value:0},{label:"Pressed",value:1}]},
        buttonF:{displayName:"F",type:"enum",bindable:true,access:"readWrite",values:[{label:"Released",value:0},{label:"Pressed",value:1}]},
        button2:{displayName:"2",type:"enum",bindable:true,access:"readWrite",values:[{label:"Released",value:0},{label:"Pressed",value:1}]},
        button4:{displayName:"4",type:"enum",bindable:true,access:"readWrite",values:[{label:"Released",value:0},{label:"Pressed",value:1}]},
        button6:{displayName:"6",type:"enum",bindable:true,access:"readWrite",values:[{label:"Released",value:0},{label:"Pressed",value:1}]},
        button8:{displayName:"8",type:"enum",bindable:true,access:"readWrite",values:[{label:"Released",value:0},{label:"Pressed",value:1}]},
        button0:{displayName:"0",type:"enum",bindable:true,access:"readWrite",values:[{label:"Released",value:0},{label:"Pressed",value:1}]},
        buttonE:{displayName:"E",type:"enum",bindable:true,access:"readWrite",values:[{label:"Released",value:0},{label:"Pressed",value:1}]},
        targetWindowTitle:{displayName:"Window title",type:"string",bindable:true},
        fitMode:{displayName:"Fit mode",type:"enum",bindable:true,values:[{label:"Fit",value:"fit"},{label:"Crop",value:"crop"},{label:"Stretch",value:"stretch"}]}
    })
    function synchronizeState(name,value){if(customProperties[name]!==value){customProperties[name]=value;customPropertiesChanged()}}
    Item {
        objectName:"visualRoot"
        width:102.6;height:197.85
        scale:Math.min(root.width/width,root.height/height)
        transformOrigin:Item.TopLeft
        x:(root.width-width*scale)/2;y:(root.height-height*scale)/2
        AdaptiveSvgImage {anchors.fill:parent;source:Qt.resolvedUrl("_parts/frame.svg")}
        // Safe rectangular area inside the source aperture's bevelled upper corners.
        Rectangle {objectName:"externalWindowScreenArea";x:17.3;y:35.5;width:68;height:111;color:"#090b10";clip:true}
        EkranButton {id:key1;objectName:"button1";x:1.35;y:37.40;runtimeMode:root.runtimeMode;onUserPropertyChanged:function(name,value){root.userPropertyChanged("button1",value)}}
        EkranButton {id:key3;objectName:"button3";x:1.35;y:56.50;runtimeMode:root.runtimeMode;onUserPropertyChanged:function(name,value){root.userPropertyChanged("button3",value)}}
        EkranButton {id:key5;objectName:"button5";x:1.35;y:75.70;runtimeMode:root.runtimeMode;onUserPropertyChanged:function(name,value){root.userPropertyChanged("button5",value)}}
        EkranButton {id:key7;objectName:"button7";x:1.35;y:94.95;runtimeMode:root.runtimeMode;onUserPropertyChanged:function(name,value){root.userPropertyChanged("button7",value)}}
        EkranButton {id:key9;objectName:"button9";x:1.35;y:114.10;runtimeMode:root.runtimeMode;onUserPropertyChanged:function(name,value){root.userPropertyChanged("button9",value)}}
        EkranButton {id:keyF;objectName:"buttonF";x:1.35;y:133.35;runtimeMode:root.runtimeMode;onUserPropertyChanged:function(name,value){root.userPropertyChanged("buttonF",value)}}
        EkranButton {id:key2;objectName:"button2";x:89.65;y:37.40;runtimeMode:root.runtimeMode;onUserPropertyChanged:function(name,value){root.userPropertyChanged("button2",value)}}
        EkranButton {id:key4;objectName:"button4";x:89.65;y:56.50;runtimeMode:root.runtimeMode;onUserPropertyChanged:function(name,value){root.userPropertyChanged("button4",value)}}
        EkranButton {id:key6;objectName:"button6";x:89.65;y:75.70;runtimeMode:root.runtimeMode;onUserPropertyChanged:function(name,value){root.userPropertyChanged("button6",value)}}
        EkranButton {id:key8;objectName:"button8";x:89.65;y:94.95;runtimeMode:root.runtimeMode;onUserPropertyChanged:function(name,value){root.userPropertyChanged("button8",value)}}
        EkranButton {id:key0;objectName:"button0";x:89.65;y:114.10;runtimeMode:root.runtimeMode;onUserPropertyChanged:function(name,value){root.userPropertyChanged("button0",value)}}
        EkranButton {id:keyE;objectName:"buttonE";x:89.65;y:133.35;runtimeMode:root.runtimeMode;onUserPropertyChanged:function(name,value){root.userPropertyChanged("buttonE",value)}}
    }
}
