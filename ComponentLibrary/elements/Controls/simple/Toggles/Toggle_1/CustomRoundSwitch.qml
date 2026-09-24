import QtQuick 2.0
import common_qml 1.0

BaseSceneComponent {
    id: root
    property real thinNeedlAngle: 0
    readonly property real designWidth: 54
    readonly property real designHeight: 54

    width: designWidth
    height: designHeight
    preserveAspectRatio: true

    my_type: "Toggle_1"
    my_subtype: "Toggle_1"
    previewSource: "Toggle_1.svg"
    customProperties: ({
        "thinNeedlAngle": 0
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
            source: Qt.resolvedUrl("Toggle_1.svg")
            fillMode: Image.PreserveAspectFit
            smooth: true
        }
    }
}

/*##^##
Designer {
    D{i:0;height:59;width:50}D{i:2}D{i:3}
}
##^##*/
