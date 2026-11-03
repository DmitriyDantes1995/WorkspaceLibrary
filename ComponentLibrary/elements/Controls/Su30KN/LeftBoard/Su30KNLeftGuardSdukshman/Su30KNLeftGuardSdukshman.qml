import QtQuick 2.15
import "../_parts" as LeftBoard

// 1LeftBort.swf, sprite #304. Instances: tbl_sdukshman.
LeftBoard.GuardedSwitch {
    id: root
    my_type: "Su30KNLeftGuardSdukshman"
    my_subtype: "Su30KNLeftGuardSdukshman"
    implicitWidth: 90.66581
    implicitHeight: 61.36625
    previewSource: "closed_0.svg"
    maximumValue: 1
    assetDirectory: Qt.resolvedUrl("./")
    clickRegions: [
        {"x": 0.00017, "y": 0.180675, "width": 0.705642, "height": 0.799704, "action": "open"},
        {"x": 0.723741, "y": 0.180709, "width": 0.23543, "height": 0.799038, "action": "close"},
        {"x": 0.015332, "y": 0.351949, "width": 0.29416, "height": 0.434559, "action": "switch", "state": 0},
        {"x": 0.335279, "y": 0.351746, "width": 0.294151, "height": 0.434559, "action": "switch", "state": 1}
    ]
}
