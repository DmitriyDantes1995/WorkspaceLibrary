import QtQuick 2.15
import common_qml 1.0
import "_parts"

// 1LeftBort.swf #528/#525. Flash rotates the scale card by 0..198° for input 0..300.
Indicator {
    id: root

    my_type: "Su30KNLeftKshScale"
    my_subtype: "Su30KNLeftKshScale"
    implicitWidth: 89.115
    implicitHeight: 84.2075
    maximumValue: 300
    discrete: false
    previewSource: "preview.svg"
    propertySchema: ({
        value: {
            displayName: "КШ", type: "number", bindable: true, access: "readOnly",
            min: 0, max: 300
        }
    })

    KshScaleFace {
        anchors.fill: parent
        cardAngle: root.value * 198 / 300
    }
}
