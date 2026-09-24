import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "RightConsoleMainPanelCompact"
    my_subtype: "RightConsoleMainPanelCompact"
    previewSource: "background.svg"

    width: 342.5
    height: 200

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
