import QtQuick 2.15
import common_qml 1.0
import "../../../../common_qml/CockpitTranslations.js" as Translations

// 1RightBort.swf, bezel #508 and indicator #507.
Indicator {
    id: root

    my_type: "Su27UBRightLampSpoHighSap"
    my_subtype: "Su27UBRightLampSpoHighSap"
    implicitWidth: 70.53
    implicitHeight: 31.38
    previewSource: "state_1.svg"

    AdaptiveSvgImage {
        id: artwork
        anchors.fill: parent
        source: Qt.resolvedUrl("state_" + root.currentState + ".svg")
        fillMode: Image.PreserveAspectFit
    }

    Text {
        objectName: "spoHighSapLegend"
        anchors.centerIn: artwork
        width: artwork.paintedWidth * 0.78
        height: artwork.paintedHeight * 0.71
        text: Translations.forLanguage({ en: "JAMMER\nHV" }, Qt.uiLanguage, "ВЫСОКОЕ\nСАП")
        color: root.currentState === 1 ? "#00ff00" : "#3d6340"
        font.family: "Arial"
        font.bold: true
        font.pixelSize: Math.max(1, Math.round(artwork.paintedHeight * 0.4))
        minimumPixelSize: 1
        fontSizeMode: Text.Fit
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
