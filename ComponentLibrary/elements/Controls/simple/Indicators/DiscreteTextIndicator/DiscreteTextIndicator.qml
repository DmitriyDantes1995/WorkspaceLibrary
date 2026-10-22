import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root
    my_type: "DiscreteTextIndicator"
    my_subtype: "DiscreteTextIndicator"
    previewSource: "preview.svg"
    width: 37
    height: 17

    // Local state is an index into the prepared captions, not a protocol code.
    property int value: 0
    property string preset: "Weapon"
    readonly property var captions: preset === "Gun"
        ? ["1/2", "30", "RDS", "40", "RL", "10", "3/4"]
        : ["A-G", "STP", "LRM", "MRM", "B", "R", "SRM"]
    readonly property var captionOptions: [{label: "Пусто", value: -1}].concat(
        captions.map(function(caption, index) { return {label: caption, value: index} }))
    readonly property string displayText: value >= 0 && value < captions.length ? captions[value] : ""
    property color backgroundColor: "#afc3c2"
    property color textColor: "#ffffff"
    property string fontFamily: "Arial"

    customProperties: ({value: value, preset: preset,
        backgroundColor: backgroundColor, textColor: textColor, fontFamily: fontFamily})
    propertySchema: ({
        preset: {displayName: "Набор", type: "enum", bindable: false, order: 0,
            values: [{label: "Вооружение", value: "Weapon"}, {label: "GUN", value: "Gun"}]},
        value: {displayName: "Надпись", type: "enum", bindable: true, access: "readOnly",
            values: captionOptions, order: 1},
        backgroundColor: {displayName: "Фон", type: "color", bindable: false},
        textColor: {displayName: "Цвет текста", type: "color", bindable: false},
        fontFamily: {displayName: "Шрифт", type: "string", bindable: false}
    })

    // Scene hosts replace this map on load; subsequent changes still persist.
    function synchronizeState(name, next) {
        if (customProperties[name] !== next) {
            customProperties[name] = next
            customPropertiesChanged()
        }
    }
    onValueChanged: synchronizeState("value", value)
    onPresetChanged: synchronizeState("preset", preset)
    onBackgroundColorChanged: synchronizeState("backgroundColor", backgroundColor)
    onTextColorChanged: synchronizeState("textColor", textColor)
    onFontFamilyChanged: synchronizeState("fontFamily", fontFamily)

    Rectangle {
        anchors.fill: parent
        color: root.backgroundColor
    }
    Text {
        objectName: "indicatorText"
        anchors.fill: parent
        anchors.margins: Math.min(root.width, root.height) * 0.08
        text: root.displayText
        color: root.textColor
        font.family: root.fontFamily
        font.pixelSize: Math.max(1, height * 0.85)
        fontSizeMode: Text.Fit
        minimumPixelSize: 1
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.NoWrap
        textFormat: Text.PlainText
    }
}
