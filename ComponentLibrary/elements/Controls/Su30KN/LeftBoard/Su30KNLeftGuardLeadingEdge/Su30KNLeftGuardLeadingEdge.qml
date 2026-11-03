import QtQuick 2.15
import "../_parts" as LeftBoard

// 1LeftBort.swf, sprite #233. Instances: tbl_leading_edge.
LeftBoard.GuardedSwitch {
    id: root
    my_type: "Su30KNLeftGuardLeadingEdge"
    my_subtype: "Su30KNLeftGuardLeadingEdge"
    implicitWidth: 93.26674
    implicitHeight: 81.96561
    previewSource: "closed_0.svg"
    maximumValue: 2
    assetDirectory: Qt.resolvedUrl("./")
    clickRegions: [
        {"x": 0.293908, "y": 0.28589, "width": 0.418385, "height": 0.713897, "action": "open"},
        {"x": 0.293684, "y": 0.036592, "width": 0.418241, "height": 0.2381, "action": "close"},
        {"x": 0.000178, "y": 0.310269, "width": 0.323432, "height": 0.352374, "action": "switch", "state": 0},
        {"x": 0.676421, "y": 0.309727, "width": 0.323432, "height": 0.352374, "action": "switch", "state": 1},
        {"x": 0.338299, "y": 0.309998, "width": 0.323432, "height": 0.352374, "action": "switch", "state": 2}
    ]
}
