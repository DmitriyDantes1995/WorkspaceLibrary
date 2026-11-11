import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, sprite 528. The scale card (525) turns behind the bezel.
Item {
    id: face
    property real cardAngle: 0
    readonly property real pivotY: height * 0.47047472

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("../back.svg")
        fillMode: Image.Stretch
    }

    Item {
        id: aperture
        // The graduations sweep inside the dark face, below its straight edge.
        y: face.pivotY + face.height * (1.15 / 129.55)
        width: face.width
        height: face.height - y
        clip: true

        AdaptiveSvgImage {
            objectName: "kshScale"
            y: -aperture.y
            width: face.width
            height: face.height
            source: Qt.resolvedUrl("../card.svg")
            fillMode: Image.Stretch
            transform: Rotation {
                origin.x: face.width / 2
                origin.y: face.pivotY
                angle: face.cardAngle
            }
        }
    }

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("../front.svg")
        fillMode: Image.Stretch
    }
}
