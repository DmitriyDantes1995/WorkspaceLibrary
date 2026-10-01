import QtQuick 2.15

Item {
    id: root
    property real handLength: 50
    property real thickness: 2
    property real tail: 0
    property color handColor: "#edf0b8"
    transformOrigin: Item.TopLeft
    Rectangle {
        x: -root.thickness / 2
        y: -root.handLength
        width: root.thickness
        height: root.handLength + root.tail
        radius: root.thickness / 2
        color: root.handColor
        antialiasing: true
    }
}
