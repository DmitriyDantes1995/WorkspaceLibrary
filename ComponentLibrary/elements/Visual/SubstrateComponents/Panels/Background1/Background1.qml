import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "Background1"
    my_subtype: "Background1"
    previewSource: "panel.svg"

    width: 200
    height: 240

    customProperties: ({})

    Image {
        anchors.fill: parent
        source: "panel.svg"
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
