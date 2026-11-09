import QtQuick 2.15
import common_qml 1.0

MomentaryButton {
    id: root

    my_type: "Su27RoundButton"
    my_subtype: "Su27RoundButton"
    implicitWidth: 60
    implicitHeight: 60
    preserveAspectRatio: false
    previewSource: "preview.svg"

    property string labelText: ""
    property real fontSize: 18

    customProperties: ({ value: root.value, labelText: root.labelText, fontSize: root.fontSize })
    propertySchema: ({
        value: { displayName: qsTr("Нажатие"), type: "enum", bindable: true, access: "readWrite",
            values: [{ label: qsTr("Отпущена"), value: 0 }, { label: qsTr("Нажата"), value: 1 }] },
        labelText: { displayName: qsTr("Надпись"), type: "string", bindable: false },
        fontSize: { displayName: qsTr("Шрифт"), type: "number", min: 1, max: 72, step: 1, bindable: false }
    })

    Rectangle {
        id: bezel
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
