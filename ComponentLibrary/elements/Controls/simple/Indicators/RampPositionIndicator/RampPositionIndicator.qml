import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root
    preserveAspectRatio: true

    my_type: "clin"
    my_subtype: "clin"
    previewSource: "preview.png"

    readonly property real designWidth: 50.8
    readonly property real designHeight: 58
    readonly property real visualDesignWidth: 312
    readonly property real visualDesignHeight: 364.3
    readonly property real designArrowWidth: 17
    readonly property real designArrowHeight: 58
    readonly property real leftArrowX: 79.8
    readonly property real rightArrowX: 211.6

    implicitWidth: designWidth
    implicitHeight: designHeight
    width: implicitWidth
    height: implicitHeight
    clip: true

    property bool runtimeMode: false
    // Legacy input only. Explicit channel assignments replace these default bindings,
    // so mixed old/new configurations work regardless of property restore order.
    property real m_value: 0
    property real leftValue: m_value
    property real rightValue: m_value
    readonly property real scaleTop: 83
    readonly property real scaleBottom: 273
    function pointerY(value) {
        return scaleBottom - (scaleBottom-scaleTop)*Math.max(0,Math.min(100,value))/100
    }
    customProperties: ({m_value:0, leftValue:0, rightValue:0})
    property bool synchronizingChannels:false
    property bool channelsReady:false
    Component.onCompleted:channelsReady=true
    propertySchema: ({
        m_value:{type:"number",hidden:true,bindable:false},
        leftValue:{displayName:"Left ramp",type:"number",min:0,max:100,step:1,unit:"%",bindable:true,access:"readWrite"},
        rightValue:{displayName:"Right ramp",type:"number",min:0,max:100,step:1,unit:"%",bindable:true,access:"readWrite"}
    })
    function synchronizeChannels() {
        if(synchronizingChannels) return
        synchronizingChannels=true
        var changed=false
        if(customProperties.m_value !== m_value) {customProperties.m_value=m_value;changed=true}
        if(customProperties.leftValue !== leftValue) {customProperties.leftValue=leftValue;changed=true}
        if(customProperties.rightValue !== rightValue) {customProperties.rightValue=rightValue;changed=true}
        if(changed) customPropertiesChanged()
        synchronizingChannels=false
    }
    onLeftValueChanged:synchronizeChannels()
    onRightValueChanged:synchronizeChannels()
    // Qt_Cab replaces the property map after assigning the individual values.
    onCustomPropertiesChanged: {
        if(synchronizingChannels || !channelsReady) return
        // Restore the complete incoming map after C++ assignments, which keep QML
        // bindings alive. Cache both inputs before synchronizing either channel.
        var left=customProperties.hasOwnProperty("leftValue") ? customProperties.leftValue : customProperties.m_value
        var right=customProperties.hasOwnProperty("rightValue") ? customProperties.rightValue : customProperties.m_value
        synchronizingChannels=true
        if(left !== undefined) leftValue=left
        if(right !== undefined) rightValue=right
        synchronizingChannels=false
        synchronizeChannels()
    }

    // Вся графика живёт в одном design-space и масштабируется одним
    // равномерным коэффициентом, чтобы части прибора не расходились.
    Item {
        id: visualRoot
        objectName: "rampVisualRoot"

        readonly property real uniformScale: Math.max(
            0, Math.min(root.width / root.visualDesignWidth,
                        root.height / root.visualDesignHeight))

        x: (root.width - width * uniformScale) / 2
        y: (root.height - height * uniformScale) / 2
        width: root.visualDesignWidth
        height: root.visualDesignHeight
        clip: true

        transform: Scale {
            origin.x: 0
            origin.y: 0
            xScale: visualRoot.uniformScale
            yScale: visualRoot.uniformScale
        }

        AdaptiveSvgImage {
            id: backgroundImage
            objectName: "rampScaleImage"

            anchors.fill: parent

            source: Qt.resolvedUrl("background.svg")
            fillMode: Image.PreserveAspectFit
            smooth: true
        }

        AdaptiveSvgImage {
            id: leftArrow
            objectName: "rampLeftArrowImage"

            x: root.leftArrowX
            y: root.pointerY(root.leftValue) - height / 2
            width: root.designArrowWidth
            height: root.designArrowHeight

            source: Qt.resolvedUrl("left_arrow.svg")
            fillMode: Image.PreserveAspectFit
            smooth: true

            Behavior on y {
                NumberAnimation {
                    duration: 120
                    easing.type: Easing.OutCubic
                }
            }
        }

        AdaptiveSvgImage {
            id: rightArrow
            objectName: "rampRightArrowImage"

            x: root.rightArrowX
            y: root.pointerY(root.rightValue) - height / 2
            width: root.designArrowWidth
            height: root.designArrowHeight

            source: Qt.resolvedUrl("right_arrow.svg")
            fillMode: Image.PreserveAspectFit
            smooth: true

            Behavior on y {
                NumberAnimation {
                    duration: 120
                    easing.type: Easing.OutCubic
                }
            }
        }
        RotaryAnalog {
            id:leftKnob; objectName:"leftKnob"
            x:9; y:224; width:52; height:52
            minimumValue:0; maximumValue:100; wheelStep:1
            Binding {target:leftKnob;property:"value";value:root.leftValue}
            function commitFromUser(next) {
                var bounded=normalized(next)
                if(root.leftValue === bounded) return
                root.leftValue=bounded
                userPropertyChanged("value",bounded)
            }
            runtimeMode:root.runtimeMode
            onUserPropertyChanged:function(name,value) {root.userPropertyChanged("leftValue",value)}
            AdaptiveSvgImage {anchors.fill:parent;source:Qt.resolvedUrl("_parts/knob.png");rotation:parent.visualAngle}
        }
        RotaryAnalog {
            id:rightKnob; objectName:"rightKnob"
            x:251; y:224; width:52; height:52
            minimumValue:0; maximumValue:100; wheelStep:1
            Binding {target:rightKnob;property:"value";value:root.rightValue}
            function commitFromUser(next) {
                var bounded=normalized(next)
                if(root.rightValue === bounded) return
                root.rightValue=bounded
                userPropertyChanged("value",bounded)
            }
            runtimeMode:root.runtimeMode
            onUserPropertyChanged:function(name,value) {root.userPropertyChanged("rightValue",value)}
            AdaptiveSvgImage {anchors.fill:parent;source:Qt.resolvedUrl("_parts/knob.png");rotation:parent.visualAngle}
        }
    }
}
