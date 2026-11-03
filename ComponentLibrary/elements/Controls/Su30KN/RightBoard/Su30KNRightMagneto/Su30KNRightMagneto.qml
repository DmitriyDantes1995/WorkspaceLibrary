import QtQuick 2.15
import "../_parts/MechanicalCounter" as Parts

// 1RightBort.swf, lmp_magneto3, lmp_magneto2, lmp_magneto1.
Parts.RollingCounter {
    my_type: "Su30KNRightMagneto"
    my_subtype: "Su30KNRightMagneto"
    implicitWidth: 28.950836
    implicitHeight: 42.97115
    artworkDirectory: Qt.resolvedUrl("./")
    operatingMinimum: 0
    maximumValue: 9999
    value: 3502
    fixedDigits: [[0.11037331, 0.76260382, 0.76337015, 0.23739618], [0.11037331, 0.51243597, 0.76337015, 0.23739618]]
    wheelWindow: [0.0020717622, 0.1115736, 0.99375435, 0.39064295]
    wheelStrip: [-0.5775152, 0.081373084, 6.9972722, 0.36273117]
    wheelTravel: [-0.53821145, -7.3858383e-05]
    testArea: [0, 0, 1, 1]
}
