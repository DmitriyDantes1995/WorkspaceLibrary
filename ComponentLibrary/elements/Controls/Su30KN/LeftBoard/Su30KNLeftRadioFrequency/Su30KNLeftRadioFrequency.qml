pragma ComponentBehavior: Bound

import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf. rs_MHz (#372), rs_KHz (#378), and their four #385 rollers.
ControlState {
    id: root

    my_type: "Su30KNLeftRadioFrequency"
    my_subtype: "Su30KNLeftRadioFrequency"
    implicitWidth: 96.5032
    implicitHeight: 143.251
    previewSource: "preview.svg"
    minimumValue: 100000
    maximumValue: 399975
    value: 125675

    propertySchema: ({ value: {
        displayName: "Frequency (kHz)", type: "number", bindable: true,
        access: "readWrite", min: minimumValue, max: maximumValue, step: 25
    } })

    readonly property var detents: [[10, 11, 12, 13, 14, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39], [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], [0, 25, 50, 75]]
    readonly property var placeValues: [10000, 1000, 100, 1]
    readonly property var frequencyDigits: [Math.floor(value / 10000), Math.floor(value / 1000) % 10,
                                            Math.floor(value / 100) % 10, value % 100]

    function normalized(next) {
        const rounded = Math.round(Number(next) / 25) * 25
        const frequency = isFinite(rounded) ? Math.max(minimumValue, Math.min(maximumValue, rounded)) : minimumValue
        if (frequency >= 150000 && frequency < 220000)
            return frequency < 185000 ? 149975 : 220000
        return frequency
    }

    function rollerFrame(digit) {
        const detent = detents[digit].indexOf(frequencyDigits[digit])
        return detent === 0 ? 1 : 5 * detent
    }

    function stepDigit(digit, direction) {
        const values = detents[digit]
        const digits = frequencyDigits.slice()
        const next = (values.indexOf(digits[digit]) + direction + values.length) % values.length
        digits[digit] = values[next]
        let frequency = 0
        for (let i = 0; i < placeValues.length; ++i)
            frequency += digits[i] * placeValues[i]
        commitFromUser(frequency)
    }

    AdaptiveSvgImage {
        x: root.width * 0.040947865
        y: root.height * 0
        width: root.width * 0.91914051
        height: root.height * 0.14799199
        source: Qt.resolvedUrl("face.svg")
        fillMode: Image.Stretch
    }

    AdaptiveSvgImage {
        x: root.width * 0.067371859
        y: root.height * 0.033158582
        width: root.width * 0.17667808
        height: root.height * 0.081674823
        source: Qt.resolvedUrl("mhz_high_" + root.frequencyDigits[0] + ".svg")
        fillMode: Image.Stretch
    }

    AdaptiveSvgImage {
        x: root.width * 0.28964428
        y: root.height * 0.033158582
        width: root.width * 0.085489393
        height: root.height * 0.081674823
        source: Qt.resolvedUrl("single_" + root.frequencyDigits[1] + ".svg")
        fillMode: Image.Stretch
    }

    AdaptiveSvgImage {
        x: root.width * 0.62538444
        y: root.height * 0.033158582
        width: root.width * 0.085489393
        height: root.height * 0.081674823
        source: Qt.resolvedUrl("single_" + root.frequencyDigits[2] + ".svg")
        fillMode: Image.Stretch
    }

    AdaptiveSvgImage {
        x: root.width * 0.7569863
        y: root.height * 0.033158582
        width: root.width * 0.17512373
        height: root.height * 0.081674823
        source: Qt.resolvedUrl("khz_low_" + root.frequencyDigits[3] + ".svg")
        fillMode: Image.Stretch
    }

    AdaptiveSvgImage {
        x: root.width * 0.040947865
        y: root.height * 0
        width: root.width * 0.91914051
        height: root.height * 0.14799199
        source: Qt.resolvedUrl("glass.svg")
        fillMode: Image.Stretch
    }

    AdaptiveSvgImage {
        x: root.width * 0.050613088
        y: root.height * 0.43878008
        width: root.width * 0.11330764
        height: root.height * 0.40201206
        source: Qt.resolvedUrl("roller_" + root.rollerFrame(0) + ".svg")
        fillMode: Image.Stretch
    }

    AdaptiveSvgImage {
        x: root.width * 0.2785848
        y: root.height * 0.43878008
        width: root.width * 0.11330764
        height: root.height * 0.40201206
        source: Qt.resolvedUrl("roller_" + root.rollerFrame(1) + ".svg")
        fillMode: Image.Stretch
    }

    AdaptiveSvgImage {
        x: root.width * 0.60758944
        y: root.height * 0.43878008
        width: root.width * 0.11330764
        height: root.height * 0.40201206
        source: Qt.resolvedUrl("roller_" + root.rollerFrame(2) + ".svg")
        fillMode: Image.Stretch
    }

    AdaptiveSvgImage {
        x: root.width * 0.83556115
        y: root.height * 0.43878008
        width: root.width * 0.11330764
        height: root.height * 0.40201206
        source: Qt.resolvedUrl("roller_" + root.rollerFrame(3) + ".svg")
        fillMode: Image.Stretch
    }

    Repeater {
        model: [
            {"x": 0.0, "y": 0.27712896, "width": 0.20728012, "height": 0.22304905, "digit": 0, "direction": 1},
            {"x": 5.1811753e-08, "y": 0.77695095, "width": 0.20728012, "height": 0.22304905, "digit": 0, "direction": -1},
            {"x": 0.23315289, "y": 0.27712896, "width": 0.20728012, "height": 0.22304905, "digit": 1, "direction": 1},
            {"x": 0.23315294, "y": 0.77695095, "width": 0.20728012, "height": 0.22304905, "digit": 1, "direction": -1},
            {"x": 0.55956694, "y": 0.27712896, "width": 0.20728012, "height": 0.22304905, "digit": 2, "direction": 1},
            {"x": 0.55956699, "y": 0.77695095, "width": 0.20728012, "height": 0.22304905, "digit": 2, "direction": -1},
            {"x": 0.79271983, "y": 0.27712896, "width": 0.20728012, "height": 0.22304905, "digit": 3, "direction": 1},
            {"x": 0.79271988, "y": 0.77695095, "width": 0.20728012, "height": 0.22304905, "digit": 3, "direction": -1}
        ]

        delegate: MouseArea {
            id: arrow
            required property var modelData

            x: root.width * modelData.x
            y: root.height * modelData.y
            width: root.width * modelData.width
            height: root.height * modelData.height
            enabled: root.acceptsInput
            cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor

            onPressed: root.stepDigit(modelData.digit, modelData.direction)

            Timer {
                interval: 80
                repeat: true
                running: arrow.pressed && arrow.containsMouse
                onTriggered: root.stepDigit(arrow.modelData.digit, arrow.modelData.direction)
            }
        }
    }
}
