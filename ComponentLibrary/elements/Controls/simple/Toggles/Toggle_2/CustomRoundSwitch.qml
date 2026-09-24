import QtQuick 2.0
import common_qml 1.0

BaseSceneComponent {
    id: root
    property real thinNeedlAngle: 0
    readonly property real designWidth: 147.5
    readonly property real designHeight: 149

    width: designWidth
    height: designHeight
    preserveAspectRatio: true

    my_type: "Toggle_2"
    my_subtype: "Toggle_2"
    previewSource: "background.svg"
    customProperties: ({
        "thinNeedlAngle": 0
    })
    propertySchema: ({
        "thinNeedlAngle": {
            displayName: "Angle", type: "number", bindable: true,
            min: 0, max: 360, step: 1, unit: "°"
        }
    })

    Item {
        id: visualRoot
        objectName: "visualRoot"
        width: root.designWidth
        height: root.designHeight
        anchors.centerIn: parent
        scale: Math.min(root.width / root.designWidth,
                        root.height / root.designHeight)

        AdaptiveSvgImage {
            anchors.fill: parent
            source: Qt.resolvedUrl("background.svg")
            fillMode: Image.PreserveAspectFit
            AdaptiveSvgImage {
                id: handleImage
                anchors.fill: parent
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                source: Qt.resolvedUrl("Toggle_2.svg")
                fillMode: Image.PreserveAspectFit
                transform: Rotation {
                    origin.x: handleImage.width / 2
                    origin.y: handleImage.height / 2
                    angle: root.thinNeedlAngle
                }
            }
        }
    }

}

/*##^##
Designer {
    D{i:0;height:59;width:50}D{i:2}D{i:3}
}
##^##*/
