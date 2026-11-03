import QtQuick 2.15
import "../_parts" as LeftBoard

// 1LeftBort.swf, sprite #225. Instances: tbl_eng_airstart_lh, tbl_eng_airstart_rh.
LeftBoard.GuardedSwitch {
    id: root
    my_type: "Su30KNLeftGuardEngAirstartRh"
    my_subtype: "Su30KNLeftGuardEngAirstartRh"
    implicitWidth: 105.0468
    implicitHeight: 52.10026
    previewSource: "closed_0.svg"
    maximumValue: 1
    assetDirectory: Qt.resolvedUrl("./")
    clickRegions: [
        {"x": 0, "y": 0.261559, "width": 0.659074, "height": 0.590632, "action": "open"},
        {"x": 0.66965, "y": 0.261494, "width": 0.219687, "height": 0.590679, "action": "close"},
        {"x": 0.086984, "y": 0.49114, "width": 0.29299, "height": 0.354495, "action": "switch", "state": 0},
        {"x": 0.395122, "y": 0.49114, "width": 0.292949, "height": 0.3544, "action": "switch", "state": 1}
    ]
}
