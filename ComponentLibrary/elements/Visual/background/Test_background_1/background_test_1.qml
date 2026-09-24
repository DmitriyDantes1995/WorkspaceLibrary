import QtQuick 2.0
import common_qml 1.0


BaseSceneComponent {
    id: root
    property real oN: 0
    width: image.implicitWidth
    height: image.implicitHeight

    my_type: "RightBort_1"
    my_subtype: "RightBort_1"
    previewSource: "RightBort001_new.svg"
    customProperties: ({
        "": ""
    })

    AdaptiveSvgImage {
        id: image
        width: implicitWidth
        height: implicitHeight
        source: Qt.resolvedUrl("RightBort001_new.svg")
        fillMode: Image.PreserveAspectFit
    }

}