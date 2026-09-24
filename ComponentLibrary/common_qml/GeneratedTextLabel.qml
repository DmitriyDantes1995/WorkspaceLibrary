import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    property string labelText: "TEXT"
    property real fontSize: 18
    // Legacy properties stay available so older scene JSON can still be read.
    // They are intentionally absent from customProperties/propertySchema.
    property string fontFamily: ""
    property string textColor: "#ffffff"
    property bool backgroundEnabled: true
    property string backgroundColor: "#000000"
    property real backgroundOpacity: 1.0
    property string borderColor: "#ffffff"
    property real borderWidth: 0
    property real cornerRadius: 0
    property real padding: 4
    property int horizontalAlignment: Text.AlignLeft
    property int verticalAlignment: Text.AlignVCenter
    property bool editing: false

    my_type: "Visual"
    my_subtype: "TextLabel"

    implicitWidth: Math.max(1, label.implicitWidth + 2 * (padding + borderWidth))
    implicitHeight: Math.max(1, label.implicitHeight + 2 * (padding + borderWidth))
    width: implicitWidth
    height: implicitHeight
    clip: true

    customProperties: ({
        "labelText": labelText,
        "fontSize": fontSize,
        "textColor": textColor,
        "backgroundColor": backgroundColor,
        "cornerRadius": cornerRadius,
        "horizontalAlignment": horizontalAlignment,
        "verticalAlignment": verticalAlignment
    })

    propertySchema: ({
        "labelText": { label: "Text", type: "string", bindable: true },
        "backgroundColor": { label: "Background", type: "string", bindable: false },
        "textColor": { label: "Text Color", type: "string", bindable: false },
        "fontSize": { label: "Font Size", type: "number", bindable: false,
                      min: 6, max: 200, step: 1 },
        "cornerRadius": { label: "Corner Radius", type: "number", bindable: false,
                          min: 0, max: 200, step: 1 },
        "horizontalAlignment": {
            label: "Horizontal Align", type: "enum", bindable: false,
            options: [
                { label: "Left", value: Text.AlignLeft },
                { label: "Center", value: Text.AlignHCenter },
                { label: "Right", value: Text.AlignRight }
            ]
        },
        "verticalAlignment": {
            label: "Vertical Align", type: "enum", bindable: false,
            options: [
                { label: "Top", value: Text.AlignTop },
                { label: "Center", value: Text.AlignVCenter },
                { label: "Bottom", value: Text.AlignBottom }
            ]
        }
    })

    Rectangle {
        anchors.fill: parent
        color: root.backgroundColor
        radius: root.cornerRadius
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        radius: root.cornerRadius
        border.color: root.borderColor
        border.width: root.borderWidth
    }

    Text {
        id: label
        objectName: "generatedTextLabelText"
        visible: !root.editing
        anchors.fill: parent
        anchors.margins: root.padding + root.borderWidth
        text: root.labelText
        color: root.textColor
        font.pixelSize: root.fontSize
        font.family: root.fontFamily
        horizontalAlignment: root.horizontalAlignment
        verticalAlignment: root.verticalAlignment
        wrapMode: Text.NoWrap
        elide: Text.ElideRight
    }
}
