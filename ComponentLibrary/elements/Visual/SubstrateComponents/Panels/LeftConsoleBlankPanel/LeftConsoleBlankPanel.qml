import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    my_type: "LeftConsoleBlankPanel"
    my_subtype: "LeftConsoleBlankPanel"
    previewSource: "background.svg"

    width: 172
    height: 589.3

    customProperties: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("background.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
