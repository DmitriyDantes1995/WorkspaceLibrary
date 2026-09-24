import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "SparseArcScale"
    my_subtype: "SparseArcScale"
    previewSource: "background.svg"

    width: 60
    height: 60

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
