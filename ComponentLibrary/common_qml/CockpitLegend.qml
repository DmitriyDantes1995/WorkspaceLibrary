import QtQuick
import "CockpitTranslations.js" as Translations

Text {
    property string legendKey

    text: Translations.legend(legendKey, Qt.uiLanguage)
    textFormat: Text.PlainText
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    font.family: "Arial"
    fontSizeMode: Text.Fit
    minimumPixelSize: 1
}
