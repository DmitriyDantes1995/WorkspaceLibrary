import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root
    preserveAspectRatio: true

    readonly property real designWidth: 202.1
    readonly property real designHeight: 93.4

    // Public component data. m_value is the property bound to RaNET.
    property string m_text: "FAULT"
    property var m_value: 0

    readonly property bool alarmState: normalizeAlarmState(m_value)
    property string lampColor: "green"
    property real fontSize: 28
    readonly property color signalColor: lampColor === "red" ? "#ff1610"
                                      : (lampColor === "yellow" ? "#fff020" : "#80ff18")
    onM_textChanged: synchronizeState("m_text",m_text)
    onM_valueChanged: synchronizeState("m_value",m_value)
    onLampColorChanged: synchronizeState("lampColor",lampColor)
    onFontSizeChanged: synchronizeState("fontSize",fontSize)
    function synchronizeState(name,value) {
        if(customProperties[name] !== value) {customProperties[name]=value;customPropertiesChanged()}
    }
    onCustomPropertiesChanged: {
        // Old scene maps contain only m_text/m_value; add the new defaults.
        if(!customProperties.hasOwnProperty("lampColor")) synchronizeState("lampColor",lampColor)
        if(!customProperties.hasOwnProperty("fontSize")) synchronizeState("fontSize",fontSize)
    }

    my_type: "FaultAnnunciator"
    my_subtype: "FaultAnnunciator"
    previewSource: "preview.png"

    width: designWidth
    height: designHeight
    clip: true

    customProperties: ({
        "m_text": m_text,
        "m_value": m_value,
        "lampColor": lampColor,
        "fontSize": fontSize
    })
    propertySchema: ({
        lampColor: {displayName:"Color",type:"enum",values:[{label:"Green",value:"green"},{label:"Red",value:"red"},{label:"Yellow",value:"yellow"}]},
        fontSize: {displayName:"Font size",type:"number",min:1,max:200,step:1,unit:"px"},
        "m_text": {
            label: "Label",
            type: "string",
            bindable: true
        },
        "m_value": {
            label: "Alarm",
            type: "bool",
            bindable: true
        }
    })

    function normalizeAlarmState(value) {
        if (value === true)
            return true
        if (value === false || value === null || value === undefined)
            return false

        if (typeof value === "string") {
            var textValue = value.trim().toLowerCase()
            if (textValue === "true")
                return true
            if (textValue === "false" || textValue.length === 0)
                return false
            value = Number(textValue)
        }

        var numericValue = Number(value)
        return isFinite(numericValue) && numericValue !== 0
    }

    AdaptiveSvgImage {
        id: backgroundImage

        anchors.fill: parent
        source: Qt.resolvedUrl("annunciator_background.svg")
        fillMode: Image.Stretch
        smooth: true
        cache: true
    }

    // Cover the source's baked lettering with the colored signal window.
    Rectangle {
        objectName:"annunciatorColorArea"
        x:14*root.width/root.designWidth
        y:13*root.height/root.designHeight
        width:174*root.width/root.designWidth
        height:67*root.height/root.designHeight
        radius:3*Math.min(root.width/root.designWidth,root.height/root.designHeight)
        color:root.alarmState ? root.signalColor : Qt.darker(root.signalColor,5)
    }

    Item {
        id: textWindow

        readonly property real widthScale: root.width / root.designWidth
        readonly property real heightScale: root.height / root.designHeight
        readonly property real fontScale: Math.min(widthScale, heightScale)

        x: 21 * widthScale
        y: 18 * heightScale
        width: 160 * widthScale
        height: 57 * heightScale
        clip: true

        Text {
            id: label
            objectName: "annunciatorText"

            readonly property real inset: Math.max(1, 3 * textWindow.fontScale)

            anchors.centerIn: parent
            width: Math.max(0, parent.width - inset * 2)
            height: Math.max(0, parent.height - inset * 2)

            text: root.m_text
            color: "#000000"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.Wrap
            elide: Text.ElideNone
            clip: true

            font.bold: true
            font.pixelSize: Math.max(1, root.fontSize * textWindow.fontScale)
            fontSizeMode: Text.Fit
            minimumPixelSize: 1
        }
    }
}
