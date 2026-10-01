import QtQuick 2.15
import common_qml 1.0
import "_parts"

BaseSceneComponent {
    id: root
    my_type: "Su30Mfd"
    my_subtype: "Su30Mfd"
    componentPath: "elements/Controls/Su30/Su30Mfd/Su30Mfd.qml"
    previewSource: "preview.png"
    readonly property real designWidth: 467
    readonly property real designHeight: 562
    width: designWidth
    height: designHeight
    preserveAspectRatio: true
    property bool runtimeMode: false
    readonly property bool supportsWindowCapture: true
    property string targetWindowTitle: ""
    property string fitMode: "fit"
    onTargetWindowTitleChanged: synchronizeState("targetWindowTitle", targetWindowTitle)
    onFitModeChanged: synchronizeState("fitMode", fitMode)
    // Su30.jpg: seven momentary buttons on each of the four edges.
    // Aliases make the actual button state the single source of truth.
    readonly property var buttonNames: ["top1", "top2", "top3", "top4", "top5", "top6", "top7", "bottom1", "bottom2", "bottom3", "bottom4", "bottom5", "bottom6", "bottom7", "left1", "left2", "left3", "left4", "left5", "left6", "left7", "right1", "right2", "right3", "right4", "right5", "right6", "right7"]
    property alias top1: top1Button.value
    onTop1Changed: synchronizeState("top1", top1)
    property alias top2: top2Button.value
    onTop2Changed: synchronizeState("top2", top2)
    property alias top3: top3Button.value
    onTop3Changed: synchronizeState("top3", top3)
    property alias top4: top4Button.value
    onTop4Changed: synchronizeState("top4", top4)
    property alias top5: top5Button.value
    onTop5Changed: synchronizeState("top5", top5)
    property alias top6: top6Button.value
    onTop6Changed: synchronizeState("top6", top6)
    property alias top7: top7Button.value
    onTop7Changed: synchronizeState("top7", top7)
    property alias bottom1: bottom1Button.value
    onBottom1Changed: synchronizeState("bottom1", bottom1)
    property alias bottom2: bottom2Button.value
    onBottom2Changed: synchronizeState("bottom2", bottom2)
    property alias bottom3: bottom3Button.value
    onBottom3Changed: synchronizeState("bottom3", bottom3)
    property alias bottom4: bottom4Button.value
    onBottom4Changed: synchronizeState("bottom4", bottom4)
    property alias bottom5: bottom5Button.value
    onBottom5Changed: synchronizeState("bottom5", bottom5)
    property alias bottom6: bottom6Button.value
    onBottom6Changed: synchronizeState("bottom6", bottom6)
    property alias bottom7: bottom7Button.value
    onBottom7Changed: synchronizeState("bottom7", bottom7)
    property alias left1: left1Button.value
    onLeft1Changed: synchronizeState("left1", left1)
    property alias left2: left2Button.value
    onLeft2Changed: synchronizeState("left2", left2)
    property alias left3: left3Button.value
    onLeft3Changed: synchronizeState("left3", left3)
    property alias left4: left4Button.value
    onLeft4Changed: synchronizeState("left4", left4)
    property alias left5: left5Button.value
    onLeft5Changed: synchronizeState("left5", left5)
    property alias left6: left6Button.value
    onLeft6Changed: synchronizeState("left6", left6)
    property alias left7: left7Button.value
    onLeft7Changed: synchronizeState("left7", left7)
    property alias right1: right1Button.value
    onRight1Changed: synchronizeState("right1", right1)
    property alias right2: right2Button.value
    onRight2Changed: synchronizeState("right2", right2)
    property alias right3: right3Button.value
    onRight3Changed: synchronizeState("right3", right3)
    property alias right4: right4Button.value
    onRight4Changed: synchronizeState("right4", right4)
    property alias right5: right5Button.value
    onRight5Changed: synchronizeState("right5", right5)
    property alias right6: right6Button.value
    onRight6Changed: synchronizeState("right6", right6)
    property alias right7: right7Button.value
    onRight7Changed: synchronizeState("right7", right7)
    customProperties: ({
        "top1": top1,
        "top2": top2,
        "top3": top3,
        "top4": top4,
        "top5": top5,
        "top6": top6,
        "top7": top7,
        "bottom1": bottom1,
        "bottom2": bottom2,
        "bottom3": bottom3,
        "bottom4": bottom4,
        "bottom5": bottom5,
        "bottom6": bottom6,
        "bottom7": bottom7,
        "left1": left1,
        "left2": left2,
        "left3": left3,
        "left4": left4,
        "left5": left5,
        "left6": left6,
        "left7": left7,
        "right1": right1,
        "right2": right2,
        "right3": right3,
        "right4": right4,
        "right5": right5,
        "right6": right6,
        "right7": right7,
        "targetWindowTitle": targetWindowTitle, "fitMode": fitMode
    })
    propertySchema: {
        var schema = {
            targetWindowTitle: { displayName: "Window title", type: "string", bindable: true },
            fitMode: { displayName: "Fit mode", type: "enum", bindable: true,
                values: [{label:"Fit",value:"fit"},{label:"Crop",value:"crop"},{label:"Stretch",value:"stretch"}] }
        }
        for (var i = 0; i < buttonNames.length; ++i) {
            var name = buttonNames[i]
            schema[name] = { displayName: name, type: "enum", bindable: true, access: "readWrite",
                values: [{ label: "Released", value: 0 }, { label: "Pressed", value: 1 }] }
        }
        return schema
    }
    function synchronizeState(name, value) {
        // Qt_Cab restores a plain map, replacing the initial binding.
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
        AdaptiveSvgImage {
            anchors.fill: parent
            source: Qt.resolvedUrl("_parts/frame.svg")
            fillMode: Image.PreserveAspectFit
        }
        Rectangle {
            objectName: "externalWindowScreenArea"
            x: 43; y: 44; width: 381; height: 474
            color: "#0b1118"
            clip: true
        }
        MfdButton {
            id: top1Button
            objectName: "top1"
            x: 65-16; y: 20-16; width: 32; height: 32
            runtimeMode: root.runtimeMode
            onUserPropertyChanged: function(name, value) { root.userPropertyChanged("top1", value) }
        }
        MfdButton {
            id: top2Button
            objectName: "top2"
            x: 121-16; y: 20-16; width: 32; height: 32
            runtimeMode: root.runtimeMode
            onUserPropertyChanged: function(name, value) { root.userPropertyChanged("top2", value) }
        }
        MfdButton {
            id: top3Button
            objectName: "top3"
            x: 177-16; y: 20-16; width: 32; height: 32
            runtimeMode: root.runtimeMode
            onUserPropertyChanged: function(name, value) { root.userPropertyChanged("top3", value) }
        }
        MfdButton {
            id: top4Button
            objectName: "top4"
            x: 233-16; y: 20-16; width: 32; height: 32
            runtimeMode: root.runtimeMode
            onUserPropertyChanged: function(name, value) { root.userPropertyChanged("top4", value) }
        }
        MfdButton {
            id: top5Button
            objectName: "top5"
            x: 289-16; y: 20-16; width: 32; height: 32
            runtimeMode: root.runtimeMode
            onUserPropertyChanged: function(name, value) { root.userPropertyChanged("top5", value) }
        }
        MfdButton {
            id: top6Button
            objectName: "top6"
            x: 345-16; y: 20-16; width: 32; height: 32
            runtimeMode: root.runtimeMode
            onUserPropertyChanged: function(name, value) { root.userPropertyChanged("top6", value) }
        }
        MfdButton {
            id: top7Button
            objectName: "top7"
            x: 401-16; y: 20-16; width: 32; height: 32
            runtimeMode: root.runtimeMode
            onUserPropertyChanged: function(name, value) { root.userPropertyChanged("top7", value) }
        }
        MfdButton {
            id: bottom1Button
            objectName: "bottom1"
            x: 65-16; y: 542-16; width: 32; height: 32
            runtimeMode: root.runtimeMode
            onUserPropertyChanged: function(name, value) { root.userPropertyChanged("bottom1", value) }
        }
        MfdButton {
            id: bottom2Button
            objectName: "bottom2"
            x: 121-16; y: 542-16; width: 32; height: 32
            runtimeMode: root.runtimeMode
            onUserPropertyChanged: function(name, value) { root.userPropertyChanged("bottom2", value) }
        }
        MfdButton {
            id: bottom3Button
            objectName: "bottom3"
            x: 177-16; y: 542-16; width: 32; height: 32
            runtimeMode: root.runtimeMode
            onUserPropertyChanged: function(name, value) { root.userPropertyChanged("bottom3", value) }
        }
        MfdButton {
            id: bottom4Button
            objectName: "bottom4"
            x: 233-16; y: 542-16; width: 32; height: 32
            runtimeMode: root.runtimeMode
            onUserPropertyChanged: function(name, value) { root.userPropertyChanged("bottom4", value) }
        }
        MfdButton {
            id: bottom5Button
            objectName: "bottom5"
            x: 289-16; y: 542-16; width: 32; height: 32
            runtimeMode: root.runtimeMode
            onUserPropertyChanged: function(name, value) { root.userPropertyChanged("bottom5", value) }
        }
        MfdButton {
            id: bottom6Button
            objectName: "bottom6"
            x: 345-16; y: 542-16; width: 32; height: 32
            runtimeMode: root.runtimeMode
            onUserPropertyChanged: function(name, value) { root.userPropertyChanged("bottom6", value) }
        }
        MfdButton {
            id: bottom7Button
            objectName: "bottom7"
            x: 401-16; y: 542-16; width: 32; height: 32
            runtimeMode: root.runtimeMode
            onUserPropertyChanged: function(name, value) { root.userPropertyChanged("bottom7", value) }
        }
        MfdButton {
            id: left1Button
            objectName: "left1"
            x: 20-16; y: 134-16; width: 32; height: 32
            runtimeMode: root.runtimeMode
            onUserPropertyChanged: function(name, value) { root.userPropertyChanged("left1", value) }
        }
        MfdButton {
            id: left2Button
            objectName: "left2"
            x: 20-16; y: 183-16; width: 32; height: 32
            runtimeMode: root.runtimeMode
            onUserPropertyChanged: function(name, value) { root.userPropertyChanged("left2", value) }
        }
        MfdButton {
            id: left3Button
            objectName: "left3"
            x: 20-16; y: 232-16; width: 32; height: 32
            runtimeMode: root.runtimeMode
            onUserPropertyChanged: function(name, value) { root.userPropertyChanged("left3", value) }
        }
        MfdButton {
            id: left4Button
            objectName: "left4"
            x: 20-16; y: 281-16; width: 32; height: 32
            runtimeMode: root.runtimeMode
            onUserPropertyChanged: function(name, value) { root.userPropertyChanged("left4", value) }
        }
        MfdButton {
            id: left5Button
            objectName: "left5"
            x: 20-16; y: 330-16; width: 32; height: 32
            runtimeMode: root.runtimeMode
            onUserPropertyChanged: function(name, value) { root.userPropertyChanged("left5", value) }
        }
        MfdButton {
            id: left6Button
            objectName: "left6"
            x: 20-16; y: 379-16; width: 32; height: 32
            runtimeMode: root.runtimeMode
            onUserPropertyChanged: function(name, value) { root.userPropertyChanged("left6", value) }
        }
        MfdButton {
            id: left7Button
            objectName: "left7"
            x: 20-16; y: 428-16; width: 32; height: 32
            runtimeMode: root.runtimeMode
            onUserPropertyChanged: function(name, value) { root.userPropertyChanged("left7", value) }
        }
        MfdButton {
            id: right1Button
            objectName: "right1"
            x: 447-16; y: 134-16; width: 32; height: 32
            runtimeMode: root.runtimeMode
            onUserPropertyChanged: function(name, value) { root.userPropertyChanged("right1", value) }
        }
        MfdButton {
            id: right2Button
            objectName: "right2"
            x: 447-16; y: 183-16; width: 32; height: 32
            runtimeMode: root.runtimeMode
            onUserPropertyChanged: function(name, value) { root.userPropertyChanged("right2", value) }
        }
        MfdButton {
            id: right3Button
            objectName: "right3"
            x: 447-16; y: 232-16; width: 32; height: 32
            runtimeMode: root.runtimeMode
            onUserPropertyChanged: function(name, value) { root.userPropertyChanged("right3", value) }
        }
        MfdButton {
            id: right4Button
            objectName: "right4"
            x: 447-16; y: 281-16; width: 32; height: 32
            runtimeMode: root.runtimeMode
            onUserPropertyChanged: function(name, value) { root.userPropertyChanged("right4", value) }
        }
        MfdButton {
            id: right5Button
            objectName: "right5"
            x: 447-16; y: 330-16; width: 32; height: 32
            runtimeMode: root.runtimeMode
            onUserPropertyChanged: function(name, value) { root.userPropertyChanged("right5", value) }
        }
        MfdButton {
            id: right6Button
            objectName: "right6"
            x: 447-16; y: 379-16; width: 32; height: 32
            runtimeMode: root.runtimeMode
            onUserPropertyChanged: function(name, value) { root.userPropertyChanged("right6", value) }
        }
        MfdButton {
            id: right7Button
            objectName: "right7"
            x: 447-16; y: 428-16; width: 32; height: 32
            runtimeMode: root.runtimeMode
            onUserPropertyChanged: function(name, value) { root.userPropertyChanged("right7", value) }
        }
    }
}
