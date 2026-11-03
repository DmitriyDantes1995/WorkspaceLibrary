import QtQuick 2.15
import common_qml 1.0

// 1RightBort.swf, satellite_dsp #644 with forty #643 cells.
BaseSceneComponent {
    id: root
    my_type: "Su30KNRightSatelliteDisplay"
    my_subtype: "Su30KNRightSatelliteDisplay"
    implicitWidth: 51
    implicitHeight: 114.55
    preserveAspectRatio: true
    previewSource: "preview.svg"
    property bool runtimeMode: false

    property int lmp_sd1_0: 0
    property int lmp_sd1_1: 0
    property int lmp_sd1_2: 0
    property int lmp_sd1_3: 0
    property int lmp_sd1_4: 0
    property int lmp_sd1_5: 0
    property int lmp_sd1_6: 0
    property int lmp_sd1_7: 0
    property int lmp_sd1_8: 0
    property int lmp_sd1_9: 0
    property int lmp_sd2_0: 0
    property int lmp_sd2_1: 0
    property int lmp_sd2_2: 0
    property int lmp_sd2_3: 0
    property int lmp_sd2_4: 0
    property int lmp_sd2_5: 0
    property int lmp_sd2_6: 0
    property int lmp_sd2_7: 0
    property int lmp_sd2_8: 0
    property int lmp_sd2_9: 0
    property int lmp_sd3_0: 0
    property int lmp_sd3_1: 0
    property int lmp_sd3_2: 0
    property int lmp_sd3_3: 0
    property int lmp_sd3_4: 0
    property int lmp_sd3_5: 0
    property int lmp_sd3_6: 0
    property int lmp_sd3_7: 0
    property int lmp_sd3_8: 0
    property int lmp_sd3_9: 0
    property int lmp_sd4_0: 0
    property int lmp_sd4_1: 0
    property int lmp_sd4_2: 0
    property int lmp_sd4_3: 0
    property int lmp_sd4_4: 0
    property int lmp_sd4_5: 0
    property int lmp_sd4_6: 0
    property int lmp_sd4_7: 0
    property int lmp_sd4_8: 0
    property int lmp_sd4_9: 0

    // Position of the first cell in each group in board coordinates.
    readonly property var groupOrigins: [[0.11689908, 0.93077798], [0.11689908, 0.44190849], [0.5894481, 0.93077798], [0.5894481, 0.44190849]]
    readonly property real cellStride: -0.046704496
    readonly property real cellWidth: 0.31522145
    readonly property real cellHeight: 0.04678101

    function cellName(index) {
        return "lmp_sd" + (Math.floor(index / 10) + 1) + "_" + index % 10
    }
    function describeCells() {
        const schema = {}
        for (let index = 0; index < 40; ++index) {
            schema[cellName(index)] = {
                displayName: "Ячейка " + (Math.floor(index / 10) + 1) + "." + (index % 10 + 1),
                type: "number", access: "readOnly", bindable: true, min: 0, max: 1, step: 1
            }
        }
        return schema
    }
    function cellValues() {
        const values = {}
        for (let index = 0; index < 40; ++index) {
            const name = cellName(index)
            values[name] = root[name]
        }
        return values
    }
    propertySchema: describeCells()
    customProperties: cellValues()

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("panel.svg")
    }

    Repeater {
        model: 40
        delegate: MomentaryButton {
            id: cell
            required property int index
            readonly property string cellKey: root.cellName(index)
            readonly property int level: root[cellKey] > 0 ? 1 : 0
            readonly property var origin: root.groupOrigins[Math.floor(index / 10)]
            objectName: cellKey
            x: origin[0] * root.width
            y: (origin[1] + root.cellStride * (index % 10)) * root.height
            width: root.cellWidth * root.width
            height: root.cellHeight * root.height
            value: level
            runtimeMode: root.runtimeMode
            onLevelChanged: {
                if (root.customProperties[cellKey] === level)
                    return
                root.customProperties[cellKey] = level
                root.customPropertiesChanged()
            }
            onUserPropertyChanged: function(name, value) {
                root[cellKey] = value
                cell.value = Qt.binding(() => cell.level)
                root.userPropertyChanged(cellKey, value)
            }

            AdaptiveSvgImage {
                anchors.fill: parent
                source: Qt.resolvedUrl("cell_" + cell.currentState + ".svg")
            }
        }
    }
}
