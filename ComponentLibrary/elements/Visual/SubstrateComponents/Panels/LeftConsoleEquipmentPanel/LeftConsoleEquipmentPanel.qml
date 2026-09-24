import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "LeftConsoleEquipmentPanel"
    my_subtype: "LeftConsoleEquipmentPanel"
    previewSource: "background.svg"

    width: 172.9
    height: 591.7

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
