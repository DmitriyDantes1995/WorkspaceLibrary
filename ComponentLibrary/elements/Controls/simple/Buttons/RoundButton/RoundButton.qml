import QtQuick 2.15
import common_qml 1.0
import "Looks.js" as Looks

MomentaryButton {
    id: root
    my_type: "RoundButton"
    my_subtype: my_type
    property string appearance: "labelled"
    readonly property var catalogVariantProperties: ["appearance"]
    readonly property var look: Looks.entries[appearance]
    property alias oN: root.value
    property string labelText: ""
    property real fontSize: 18
    implicitWidth: look ? (look.width || artwork.implicitWidth) : 60
    implicitHeight: look ? (look.height || artwork.implicitHeight) : 60
    preserveAspectRatio: !!look
    previewSource: look ? look.frames[0] : "preview.svg"
    hitRegion: look && look.region ? Qt.rect(look.region[0], look.region[1], look.region[2], look.region[3])
                                  : Qt.rect(0, 0, 1, 1)

    customProperties: ({ appearance: root.appearance, labelText: root.labelText,
                         fontSize: root.fontSize, valuePropertyName: root.valuePropertyName,
                         [root.valuePropertyName]: root.value })
    propertySchema: ({
        appearance: { displayName: qsTr("Appearance"), type: "enum", bindable: false, order: 0,
            values: [{ label: qsTr("Cream with lettering"), value: "labelled", previewSource: Qt.resolvedUrl("preview.svg") }]
                .concat(Object.keys(Looks.entries).map(function(key) {
                    return { label: Looks.entries[key].label, value: key,
                             previewSource: Qt.resolvedUrl(Looks.entries[key].frames[0]) }
                })) },
        [root.valuePropertyName]: { displayName: qsTr("Pressed"), type: "enum", bindable: true,
            access: "readWrite", order: 1,
            values: [{ label: qsTr("Released"), value: 0 }, { label: qsTr("Pressed"), value: 1 }] },
        labelText: { displayName: qsTr("Text"), type: "string", bindable: false, order: 2 },
        fontSize: { displayName: qsTr("Font size"), type: "number", min: 1, max: 72, step: 1, bindable: false, order: 3 },
        valuePropertyName: { hidden: true, bindable: false }
    })

    function normalized(next) {
        const number = Number(next)
        if (!isFinite(number))
            return 0
        return valuePropertyName === "oN" ? number : Math.max(0, Math.min(1, Math.round(number)))
    }

    AdaptiveSvgImage {
        id: artwork
        anchors.fill: parent
        source: root.look ? Qt.resolvedUrl(root.look.frames[root.value === 1 ? 1 : 0]) : ""
        fillMode: root.look && root.look.stretch ? Image.Stretch : Image.PreserveAspectFit
    }

    Text {
        anchors.fill: parent
        anchors.margins: Math.min(parent.width, parent.height) * 0.18
        visible: !!root.look && text.length > 0
        text: root.labelText
        textFormat: Text.PlainText
        color: "#f3f0e8"
        font.family: "Arial"
        font.bold: true
        font.pixelSize: Math.max(1, Math.min(root.fontSize, height * 0.55))
        minimumPixelSize: 1
        fontSizeMode: Text.Fit
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Rectangle {
        id: bezel
        visible: !root.look
        anchors.centerIn: parent
        width: Math.min(root.width, root.height)
        height: width
        radius: width / 2
        color: "#89938c"
        border.color: "#b9c1af"
        border.width: Math.max(0.6, width * 0.025)

        Rectangle {
            anchors.fill: parent
            anchors.margins: bezel.width * 0.09
            radius: width / 2
            color: root.value ? "#a6ada4" : "#eee9ce"
            border.color: root.value ? "#111b1b" : "#aab5af"
            border.width: Math.max(0.5, width * 0.018)
        }

        Text {
            x: bezel.width * 0.13
            y: bezel.height * (root.value ? 0.185 : 0.15)
            width: bezel.width * 0.74
            height: bezel.height * 0.7
            text: root.labelText
            color: "#343d37"
            font.family: "Arial"
            font.pixelSize: Math.max(1, Math.min(root.fontSize, bezel.height * 0.3))
            fontSizeMode: Text.Fit
            minimumPixelSize: 1
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
}
