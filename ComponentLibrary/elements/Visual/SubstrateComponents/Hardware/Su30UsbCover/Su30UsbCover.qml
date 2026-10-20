import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    my_type: "Su30UsbCover"
    my_subtype: "Su30UsbCover"
    componentPath: "elements/Visual/SubstrateComponents/Hardware/Su30UsbCover/Su30UsbCover.qml"
    previewSource: "body.svg"
    width: 35
    height: 116
    preserveAspectRatio: true

    customProperties: ({})
    propertySchema: ({})

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("body.svg")
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
