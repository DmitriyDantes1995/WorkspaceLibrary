import QtQuick 2.15
import "../Su30KNRightNavCheckDisplay" as Displays

// Entry point retained for scenes saved before the display variants were grouped.
Displays.Su30KNRightNavCheckDisplay {
    my_type: "Su30KNRightNavPpmAerDisplay"
    my_subtype: "Su30KNRightNavPpmAerDisplay"
    layout: "single"
    regions: [[0.1188876, 0.1630124, 0.8088378, 0.627483]]
    glassSource: Qt.resolvedUrl("glass.svg")
    previewSource: "preview.svg"
}
