import QtQuick 2.15
import "../_parts" as Parts

// 1RightBort.swf, digit sprite #365 with display window #696.
Parts.NavigationCounter {
    id: root
    my_type: "Su30KNRightNavCheckDisplay"
    my_subtype: "Su30KNRightNavCheckDisplay"
    property string layout: "check"
    readonly property var catalogVariantProperties: ["layout"]
    readonly property bool singleDigit: layout === "single"

    implicitWidth: 39.938354
    implicitHeight: singleDigit ? 29.994508 : 88.732912
    firstNumber: singleDigit ? 1 : 0
    maximumValue: singleDigit ? 9 : 999
    regions: singleDigit ? [[0.1063683, 0.1496767, 0.8088378, 0.627483]]
                         : [[0.1001087, 0.6693061, 0.8088378, 0.212109],
                            [0.1001087, 0.3796728, 0.8088378, 0.212109],
                            [0.1001087, 0.0787698, 0.8088378, 0.212109]]
    glassSource: Qt.resolvedUrl(singleDigit ? "../Su30KNRightNavRmDisplay/glass.svg" : "glass.svg")
    previewSource: singleDigit ? "../Su30KNRightNavRmDisplay/preview.svg" : "preview.svg"

    customProperties: ({ layout: root.layout, value: root.value, testMode: root.testMode })
    propertySchema: Object.assign({}, navigationPropertySchema, {
        layout: {displayName: qsTr("Appearance"), type: "enum", bindable: false,
            values: [
                {label: "Navigation display · 3 digits", value: "check", previewSource: "preview.svg"},
                {label: "Navigation display · 1 digit", value: "single",
                    previewSource: "../Su30KNRightNavRmDisplay/preview.svg"}
            ]}
    })
}
