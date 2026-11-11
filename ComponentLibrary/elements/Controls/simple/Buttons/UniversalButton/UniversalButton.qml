import QtQuick 2.15
import "../_parts" as Buttons
import "../_parts/BoardButtonLooks.js" as BoardLooks

Buttons.MarkableButton {
    id: root
    my_type: "UniversalButton"
    my_subtype: "UniversalButton"
    implicitWidth: originalFace ? originalFace.width : 49.138643
    implicitHeight: originalFace ? originalFace.height : 49.138643
    previewSource: originalFace ? originalFace.dark[0] : "state_0.svg"
    // The old appearance keys are still read from saved scenes.
    property string appearance: "standard"
    readonly property var originalFace: BoardLooks.plain[appearance]

    releasedFace: Qt.resolvedUrl(originalFace ? originalFace.dark[0] : "state_0.svg")
    pressedFace: Qt.resolvedUrl(originalFace ? originalFace.dark[1] : "state_1.svg")
    markingsVisible: !originalFace
    markingCenter: Qt.point(21.6, 21.6)
    pressedOffset: Qt.point(2.4, 1.65)
    markingWidth: 29
    singleTextWidth: 30
    markingHeight: 25
    outlineColor: "#ddb30b"
    outlineWidth: 1.05
    outlinePath: "M 9 6 H 32 Q 36 6 36 10 V 33 Q 36 37 32 37 "
                 + "H 9 Q 5 37 5 33 V 10 Q 5 6 9 6 Z"

    customProperties: Object.assign({}, standardProperties, {appearance: appearance})
    propertySchema: Object.assign({}, standardPropertySchema, {
        appearance: { hidden: true, bindable: false }
    })
}
