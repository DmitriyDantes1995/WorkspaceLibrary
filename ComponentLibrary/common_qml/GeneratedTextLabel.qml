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
    property real padding: 0
    property int horizontalAlignment: Text.AlignLeft
    property int verticalAlignment: Text.AlignVCenter
    property bool editing: false
    readonly property color backgroundPaint: backgroundColor
    readonly property real effectiveFontSize: Math.max(1, Math.min(200, fontSize))
    // Use a stable glyph font and scale the entire text layout in scene units.
    // Tiny scene sizes must not depend on platform font rasterization limits.
    readonly property int glyphFontSize: 64
    readonly property var textEditor: label
    readonly property rect textInkBounds: measureText(label.text, glyphMetrics.font)
    readonly property real renderedFontSize: effectiveFontSize * (fitText
        ? Math.min(1,
                   textInkBounds.width > 0
                   ? textViewport.width / (textInkBounds.width * effectiveFontSize / glyphFontSize) : 1,
                   textInkBounds.height > 0
                   ? textViewport.height / (textInkBounds.height * effectiveFontSize / glyphFontSize) : 1)
        : 1)
    readonly property real textScale: renderedFontSize / glyphFontSize

    // Measure ink relative to the first baseline, including accents and bearings.
    // The font argument keeps the binding current when the font family changes.
    function measureText(text, font) {
        var lines = text.split("\n")
        var lineHeight = label.contentHeight / lines.length
        var position = 0
        var left = Infinity, top = Infinity, right = -Infinity, bottom = -Infinity
        for (var i = 0; i < lines.length; ++i) {
            var bounds = glyphMetrics.tightBoundingRect(lines[i])
            var lineX = root.horizontalAlignment === Text.AlignLeft
                    ? 0 : label.positionToRectangle(position).x
            if (bounds.height === 0)
                bounds = Qt.rect(0, -glyphMetrics.ascent, 0, glyphMetrics.height)
            left = Math.min(left, lineX + bounds.x)
            right = Math.max(right, lineX + bounds.x + bounds.width)
            top = Math.min(top, bounds.y + i * lineHeight)
            bottom = Math.max(bottom, bounds.y + bounds.height + i * lineHeight)
            position += lines[i].length + 1
        }
        return Qt.rect(left, top, right - left, bottom - top)
    }

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

    implicitWidth: Math.max(1, textInkBounds.width * effectiveFontSize / glyphFontSize + 2 * padding)
    implicitHeight: Math.max(1, textInkBounds.height * effectiveFontSize / glyphFontSize + 2 * padding)
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
        "padding": { label: "Внутренний отступ", type: "number", bindable: false,
                     min: 0, max: 200, step: 0.5 },
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

    FontMetrics {
        id: glyphMetrics
        font: label.font
    }

    MouseArea {
        anchors.fill: parent
        enabled: root.editing
        cursorShape: Qt.IBeamCursor
        property int selectionAnchor: 0
        onPressed: function(mouse) {
            label.forceActiveFocus()
            var point = label.mapFromItem(this, mouse.x, mouse.y)
            selectionAnchor = label.positionAt(point.x, point.y)
            label.cursorPosition = selectionAnchor
        }
        onPositionChanged: function(mouse) {
            if (pressed) {
                var point = label.mapFromItem(this, mouse.x, mouse.y)
                label.select(selectionAnchor, label.positionAt(point.x, point.y))
            }
        }
    }

    Item {
        id: textViewport
        objectName: "generatedTextLabelViewport"
        x: root.padding
        y: root.padding
        width: Math.max(0, root.width - 2 * root.padding)
        height: Math.max(0, root.height - 2 * root.padding)
        clip: true

        TextEdit {
            id: label
            objectName: "generatedTextLabelText"
            signal accepted()
            signal cancelled()
            readOnly: !root.editing
            enabled: root.editing
            selectByMouse: root.editing
            focus: root.editing
            cursorVisible: root.editing && activeFocus
            x: (root.horizontalAlignment === Text.AlignRight ? 1
                : root.horizontalAlignment === Text.AlignHCenter ? 0.5 : 0)
               * (textViewport.width - root.textInkBounds.width * scale)
               - root.textInkBounds.x * scale
            y: (root.verticalAlignment === Text.AlignBottom ? 1
                : root.verticalAlignment === Text.AlignVCenter ? 0.5 : 0)
               * (textViewport.height - root.textInkBounds.height * scale)
               - (baselineOffset + root.textInkBounds.y) * scale
            width: implicitWidth
            height: implicitHeight
            scale: root.textScale
            transformOrigin: Item.TopLeft
            text: root.labelText
            textFormat: TextEdit.PlainText
            color: root.textColor
            font.pixelSize: root.glyphFontSize
            font.family: root.fontFamily
            horizontalAlignment: root.horizontalAlignment
            verticalAlignment: root.verticalAlignment
            wrapMode: TextEdit.NoWrap
            onTextChanged: {
                if (root.editing && root.labelText !== text)
                    root.setCustomProperty("labelText", text)
            }
            onActiveFocusChanged: if (!activeFocus) deselect()
            Keys.onPressed: function(event) {
                if ((event.key === Qt.Key_Return || event.key === Qt.Key_Enter)
                        && (event.modifiers & Qt.ControlModifier)) {
                    accepted()
                    event.accepted = true
                }
            }
            Keys.onEscapePressed: function(event) {
                cancelled()
                event.accepted = true
            }
        }
    }
}
