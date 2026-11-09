import QtQuick 2.15
import "../_parts" as Buttons

Buttons.MarkableButton {
    my_type: "UniversalButton"
    my_subtype: "UniversalButton"
    implicitWidth: 49.138643
    implicitHeight: 49.138643
    previewSource: "state_0.svg"

    releasedFace: Qt.resolvedUrl("state_0.svg")
    pressedFace: Qt.resolvedUrl("state_1.svg")
    markingCenter: Qt.point(21.6, 21.6)
    pressedOffset: Qt.point(2.4, 1.65)
    markingWidth: 29
    singleTextWidth: 30
    markingHeight: 25
    outlineColor: "#ddb30b"
    outlineWidth: 1.05
    outlinePath: "M 9 6 H 32 Q 36 6 36 10 V 33 Q 36 37 32 37 "
                 + "H 9 Q 5 37 5 33 V 10 Q 5 6 9 6 Z"
}
