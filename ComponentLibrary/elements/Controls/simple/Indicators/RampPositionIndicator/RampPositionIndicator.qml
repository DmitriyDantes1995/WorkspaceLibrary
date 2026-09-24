import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root
    preserveAspectRatio: true

    my_type: "clin"
    my_subtype: "clin"
    previewSource: "background.svg"

    readonly property real designWidth: 50.8
    readonly property real designHeight: 58
    readonly property real visualDesignWidth: 312
    readonly property real visualDesignHeight: 364.3
    readonly property real designArrowWidth: 17
    readonly property real designArrowHeight: 58
    readonly property real leftArrowX: 79.8
    readonly property real rightArrowX: 211.6

    implicitWidth: designWidth
    implicitHeight: designHeight
    width: implicitWidth
    height: implicitHeight
    clip: true

    // Значение, которое будет приходить из RaNET.
    property real m_value: 0

    // Ограничиваем входное значение диапазоном 0–100.
    readonly property real normalizedValue:
        Math.max(0, Math.min(100, m_value))

    // Рабочая область шкалы в координатах исходного background.svg.
    readonly property real scaleTop: 83
    readonly property real scaleBottom: 273

    // 100 находится сверху, 0 — снизу.
    readonly property real pointerCenterY:
        scaleBottom
        - (scaleBottom - scaleTop)
        * normalizedValue / 100.0

    customProperties: ({
        "m_value": m_value
    })
    propertySchema: ({
        "m_value": {
            label: "Ramp position",
            type: "number",
            bindable: true,
            min: 0,
            max: 100,
            step: 1,
            unit: "%"
        }
    })

    // Вся графика живёт в одном design-space и масштабируется одним
    // равномерным коэффициентом, чтобы части прибора не расходились.
    Item {
        id: visualRoot
        objectName: "rampVisualRoot"

        readonly property real uniformScale: Math.max(
            0, Math.min(root.width / root.visualDesignWidth,
                        root.height / root.visualDesignHeight))

        x: (root.width - width * uniformScale) / 2
        y: (root.height - height * uniformScale) / 2
        width: root.visualDesignWidth
        height: root.visualDesignHeight
        clip: true

        transform: Scale {
            origin.x: 0
            origin.y: 0
            xScale: visualRoot.uniformScale
            yScale: visualRoot.uniformScale
        }

        AdaptiveSvgImage {
            id: backgroundImage
            objectName: "rampScaleImage"

            anchors.fill: parent

            source: Qt.resolvedUrl("background.svg")
            fillMode: Image.PreserveAspectFit
            smooth: true
        }

        AdaptiveSvgImage {
            id: leftArrow
            objectName: "rampLeftArrowImage"

            x: root.leftArrowX
            y: root.pointerCenterY - height / 2
            width: root.designArrowWidth
            height: root.designArrowHeight

            source: Qt.resolvedUrl("left_arrow.svg")
            fillMode: Image.PreserveAspectFit
            smooth: true

            Behavior on y {
                NumberAnimation {
                    duration: 120
                    easing.type: Easing.OutCubic
                }
            }
        }

        AdaptiveSvgImage {
            id: rightArrow
            objectName: "rampRightArrowImage"

            x: root.rightArrowX
            y: root.pointerCenterY - height / 2
            width: root.designArrowWidth
            height: root.designArrowHeight

            source: Qt.resolvedUrl("right_arrow.svg")
            fillMode: Image.PreserveAspectFit
            smooth: true

            Behavior on y {
                NumberAnimation {
                    duration: 120
                    easing.type: Easing.OutCubic
                }
            }
        }
    }
}
