import QtQuick 2.15
import common_qml 1.0

// 1LeftBort.swf, rud #542.
BaseSceneComponent {
    my_type: "Su30KNLeftRudBody"
    my_subtype: "Su30KNLeftRudBody"
    implicitWidth: 672.99358
    implicitHeight: 205.75094
    preserveAspectRatio: true
    previewSource: "body.svg"

    AdaptiveSvgImage {
        objectName: "rudArtwork"
        anchors.fill: parent
        source: Qt.resolvedUrl("body.svg")
    }
}
