import QtQuick 2.15
import "../_parts/MechanicalCounter" as Parts

// 1RightBort.swf, pressure_mc, pdz, pdz.lmp_pressearth13.
Parts.RollingCounter {
    id: root
    my_type: "Su30KNRightPressure"
    my_subtype: "Su30KNRightPressure"
    property string appearance: "pressure"
    readonly property bool magneto: appearance === "magneto"
    readonly property var catalogVariantProperties: ["appearance"]

    implicitWidth: magneto ? 28.950836 : 23.59253
    implicitHeight: magneto ? 42.97115 : 53.083192
    artworkDirectory: Qt.resolvedUrl(magneto ? "../Su30KNRightMagneto/" : "./")
    previewSource: magneto ? "../Su30KNRightMagneto/preview.svg" : "preview.svg"
    operatingMinimum: magneto ? 0 : 6600
    maximumValue: magneto ? 9999 : 8000
    value: magneto ? 3502 : 8000
    fixedDigits: magneto
        ? [[0.11037331, 0.76260382, 0.76337015, 0.23739618], [0.11037331, 0.51243597, 0.76337015, 0.23739618]]
        : [[0.045375712, 0.75974928, 0.90367554, 0.18536934], [0.045375712, 0.4686967, 0.90367554, 0.18536934]]
    wheelWindow: magneto ? [0.0020717622, 0.1115736, 0.99375435, 0.39064295]
                        : [0.024182563, 0.0016939567, 0.90367554, 0.37073868]
    wheelStrip: magneto ? [-0.5775152, 0.081373084, 6.9972722, 0.36273117]
                       : [-0.69911587, 0.016297382, 7.6359004, 0.34357009]
    wheelTravel: magneto ? [-0.53821145, -7.3858383e-05] : [-0.5873422, 0]
    testArea: magneto ? [0, 0, 1, 1] : [0, 0.16200825, 1, 0.83799175]

    customProperties: ({ appearance: root.appearance, value: root.value })
    propertySchema: Object.assign({}, counterPropertySchema, {
        appearance: {displayName: qsTr("Appearance"), type: "enum", bindable: false,
            values: [
                {label: "Pressure counter", value: "pressure", previewSource: "preview.svg"},
                {label: "Magneto counter", value: "magneto",
                    previewSource: "../Su30KNRightMagneto/preview.svg"}
            ]}
    })
}
