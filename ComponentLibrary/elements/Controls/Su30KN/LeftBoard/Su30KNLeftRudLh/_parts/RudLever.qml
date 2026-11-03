import QtQuick 2.15
import common_qml 1.0

ControlState {
    id: root

    required property url artworkSource
    required property real artworkWidth
    required property real artworkHeight
    required property real sourceScaleX
    required property real sourceScaleY
    required property real travel
    default property alias mountedControls: lever.data

    readonly property var detents: [0, 10000, 36000, 44000, 65535]
    readonly property real sourceWidth: artworkWidth * sourceScaleX + travel
    readonly property real sourceHeight: artworkHeight * sourceScaleY
    readonly property real horizontalScale: width / sourceWidth
    readonly property real verticalScale: height / sourceHeight

    implicitWidth: sourceWidth
    implicitHeight: sourceHeight
    minimumValue: 0
    maximumValue: 65535
    previewSource: "preview.svg"

    function synchronizeMountedControl(name) {
        if (customProperties[name] === root[name])
            return
        customProperties[name] = root[name]
        customPropertiesChanged()
    }

    Item {
        id: lever
        objectName: "rudLever"
        width: root.artworkWidth
        height: root.artworkHeight
        x: root.value / root.maximumValue * root.travel * root.horizontalScale
        transform: Scale {
            xScale: root.sourceScaleX * root.horizontalScale
            yScale: root.sourceScaleY * root.verticalScale
        }

        AdaptiveSvgImage {
            objectName: "rudArtwork"
            anchors.fill: parent
            source: root.artworkSource
        }

        MouseArea {
            anchors.fill: parent
            enabled: root.acceptsInput
            preventStealing: true
            cursorShape: Qt.SizeHorCursor
            property real startX
            property real startValue

            onPressed: function(mouse) {
                startX = mapToItem(root, mouse.x, mouse.y).x
                startValue = root.value
            }
            onPositionChanged: function(mouse) {
                if (!pressed)
                    return
                const distance = mapToItem(root, mouse.x, mouse.y).x - startX
                root.commitFromUser(startValue + distance / (root.travel * root.horizontalScale)
                                    * root.maximumValue)
            }
            onReleased: {
                // The Flash slider snapped within 5 units of a stop on a 381.35-unit track.
                const tolerance = 5 / 381.35 * root.maximumValue
                for (const detent of root.detents) {
                    if (Math.abs(detent - root.value) <= tolerance) {
                        root.commitFromUser(detent)
                        break
                    }
                }
            }
        }
    }
}
