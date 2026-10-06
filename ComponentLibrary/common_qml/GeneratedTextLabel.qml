import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    property string labelText: "TEXT"
    property real fontSize: 18
    property bool fitText: false
    // Preserve legacy styling on load and on subsequent saves; its controls
    // remain hidden in propertySchema.
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
    readonly property color backgroundPaint: backgroundColor
    readonly property real effectiveFontSize: Math.max(1, Math.min(200, fontSize))
    // Use a stable glyph font and scale the entire text layout in scene units.
    // Tiny scene sizes must not depend on platform font rasterization limits.
    readonly property int glyphFontSize: 64
    readonly property real textScale: effectiveFontSize / glyphFontSize
    readonly property real renderedFontSize: fitText
        ? Math.min(effectiveFontSize, label.fontInfo.pixelSize * textScale) : effectiveFontSize

    function migrateLegacyAppearance() {
        if (backgroundOpacity !== 1) {
            var paint = backgroundPaint
            backgroundColor = Qt.rgba(paint.r, paint.g, paint.b,
                                      paint.a * backgroundOpacity).toString()
            backgroundOpacity = 1
        }
    }

    function setCustomProperty(name, value) {
        if (!customProperties.hasOwnProperty(name))
            return false
        if (name === "fontSize" || name === "cornerRadius"
                || name === "backgroundOpacity" || name === "borderWidth" || name === "padding") {
            value = Number(value)
            if (!isFinite(value)) return false
            var minimum = name === "fontSize" ? 1 : 0
            var maximum = name === "backgroundOpacity" ? 1 : 200
            value = Math.max(minimum, Math.min(maximum, value))
        } else if (name === "horizontalAlignment") {
            if ([Text.AlignLeft, Text.AlignHCenter, Text.AlignRight].indexOf(value) < 0) return false
        } else if (name === "verticalAlignment") {
            if ([Text.AlignTop, Text.AlignVCenter, Text.AlignBottom].indexOf(value) < 0) return false
        }
        root[name] = value
        customProperties[name] = root[name]
        return true
    }

    my_type: "Visual"
    my_subtype: "TextLabel"

    implicitWidth: Math.max(1, label.implicitWidth * textScale + 2 * (padding + borderWidth))
    implicitHeight: Math.max(1, label.implicitHeight * textScale + 2 * (padding + borderWidth))
    width: 180
    height: 64
    clip: true

    customProperties: ({
        "labelText": labelText,
        "fontSize": fontSize,
        "fitText": fitText,
        "textColor": textColor,
        "backgroundEnabled": backgroundEnabled,
        "backgroundColor": backgroundColor,
        "cornerRadius": cornerRadius,
        "horizontalAlignment": horizontalAlignment,
        "verticalAlignment": verticalAlignment,
        "fontFamily": fontFamily,
        "backgroundOpacity": backgroundOpacity,
        "borderColor": borderColor,
        "borderWidth": borderWidth,
        "padding": padding
    })

    propertySchema: ({
        "labelText": { label: "Текст", type: "string", bindable: true },
        "fitText": { label: "Вписывать текст", type: "bool", bindable: false },
        "backgroundEnabled": { label: "Показывать фон", type: "bool", bindable: false },
        "backgroundColor": { label: "Цвет фона", type: "string", bindable: false },
        "textColor": { label: "Цвет текста", type: "string", bindable: false },
        "fontSize": { label: "Размер шрифта", type: "number", bindable: false,
                      min: 1, max: 200, step: 0.5, unit: "px" },
        "cornerRadius": { label: "Скругление", type: "number", bindable: false,
                          min: 0, max: 200, step: 1 },
        "fontFamily": { hidden: true, bindable: false },
        "backgroundOpacity": { hidden: true, bindable: false },
        "borderColor": { hidden: true, bindable: false },
        "borderWidth": { hidden: true, bindable: false },
        "padding": { hidden: true, bindable: false },
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
        objectName: "generatedTextLabelBackground"
        anchors.fill: parent
        color: root.backgroundEnabled ? root.backgroundColor : "transparent"
        opacity: root.backgroundOpacity
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
        // Keep fitting/layout alive while the inline editor displays the text.
        opacity: root.editing ? 0 : 1
        x: root.padding + root.borderWidth
        y: x
        width: Math.max(0, root.width - 2 * x) / scale
        height: Math.max(0, root.height - 2 * y) / scale
        scale: root.textScale
        transformOrigin: Item.TopLeft
        text: root.labelText
        textFormat: Text.PlainText
        color: root.textColor
        font.pixelSize: root.glyphFontSize
        fontSizeMode: root.fitText ? Text.Fit : Text.FixedSize
        minimumPixelSize: Math.ceil(1 / scale)
        font.family: root.fontFamily
        horizontalAlignment: root.horizontalAlignment
        verticalAlignment: root.verticalAlignment
        wrapMode: Text.Wrap
        elide: Text.ElideNone
    }
}
