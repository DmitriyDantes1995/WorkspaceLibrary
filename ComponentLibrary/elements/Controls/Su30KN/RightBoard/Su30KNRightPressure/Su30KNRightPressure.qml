import QtQuick 2.15
import "../_parts/MechanicalCounter" as Parts

// 1RightBort.swf, pressure_mc, pdz, pdz.lmp_pressearth13.
Parts.RollingCounter {
    my_type: "Su30KNRightPressure"
    my_subtype: "Su30KNRightPressure"
    implicitWidth: 23.59253
    implicitHeight: 53.083192
    artworkDirectory: Qt.resolvedUrl("./")
    operatingMinimum: 6600
    maximumValue: 8000
    value: 8000
    fixedDigits: [[0.045375712, 0.75974928, 0.90367554, 0.18536934], [0.045375712, 0.4686967, 0.90367554, 0.18536934]]
    wheelWindow: [0.024182563, 0.0016939567, 0.90367554, 0.37073868]
    wheelStrip: [-0.69911587, 0.016297382, 7.6359004, 0.34357009]
    wheelTravel: [-0.5873422, -0]
    testArea: [0, 0.16200825, 1, 0.83799175]
}
