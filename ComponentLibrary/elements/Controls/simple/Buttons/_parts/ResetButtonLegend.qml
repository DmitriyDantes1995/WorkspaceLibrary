import QtQuick 2.15
import "../../../../../common_qml/CockpitTranslations.js" as Translations

Text {
    required property bool pressed

    objectName: "resetButtonLegend"
    width: parent.height * 0.65
    height: parent.width * 0.22
    // Positions follow the center of the cap in the released and pressed artwork.
    x: parent.width * (pressed ? 0.49 : 0.44) - width / 2
    y: parent.height * (pressed ? 0.56 : 0.40) - height / 2
    rotation: 90
    text: Translations.forLanguage({ en: "RESET" }, Qt.uiLanguage, "СБРОС")
    color: "#ffffff"
    font.family: "Arial"
    font.bold: true
    font.pixelSize: Math.max(1, Math.round(parent.height * 0.16))
    minimumPixelSize: 1
    fontSizeMode: Text.Fit
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
}
