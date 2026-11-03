import QtQuick 2.15
import common_qml 1.0

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

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("back.svg")
        fillMode: Image.Stretch
    }

    Item {
        id: aperture
        y: root.height * 0.47047472
        width: root.width
        height: root.height - y
        clip: true

        AdaptiveSvgImage {
            y: -aperture.y
            width: root.width
            height: root.height
            source: Qt.resolvedUrl("card.svg")
            fillMode: Image.Stretch
            transform: Rotation {
                origin.x: root.width * 0.5
                origin.y: aperture.y
                angle: root.value * 198 / 300
            }
        }
    }

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("front.svg")
        fillMode: Image.Stretch
    }
}
