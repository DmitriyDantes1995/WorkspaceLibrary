import QtQuick 2.15
import common_qml 1.0

MomentaryButton {
    id: root
    property string label: ""
    implicitWidth: 34
    implicitHeight: 34
    Rectangle {
        anchors.fill: parent
        radius: width / 2
        color: "#344747"
        border.color: "#17282a"
        border.width: 2
        Repeater {
            model: 32
            Rectangle {
                required property int index
                x: parent.width / 2 - 0.5
                y: 1
                width: 1; height: 4
                color: "#b6bc87"
                transform: Rotation { origin.x: 0.5; origin.y: 16; angle: index * 360 / 32 }
            }
        }
        Rectangle {
            anchors.centerIn: parent
            width: parent.width - (root.currentState ? 8 : 6)
            height: width
            radius: width / 2
            color: root.currentState ? "#bcc288" : "#f2f4b8"
            border.color: "#91996b"
            Text { anchors.centerIn: parent; text: root.label; font.pixelSize: 6; color: "#4d5844" }
        }
    }
}
