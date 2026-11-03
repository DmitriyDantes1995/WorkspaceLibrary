import QtQuick 2.15
import common_qml 1.0

// 1RightBort.swf, shared PN-184 bezel #355 and indicators #351/#354.
BaseSceneComponent {
    id: root

    my_type: "Su27UBRightPnkPrep"
    my_subtype: "Su27UBRightPnkPrep"
    implicitWidth: 72
    implicitHeight: 33
    previewSource: "face.svg"

    property int acc: 0
    property int norm: 0

    customProperties: ({ acc: root.acc, norm: root.norm })
    propertySchema: ({
        acc: { displayName: "ПОДГ. УСК", type: "number", bindable: true,
               access: "readOnly", min: 0, max: 1, step: 1 },
        norm: { displayName: "ПОДГ. НОРМ", type: "number", bindable: true,
                access: "readOnly", min: 0, max: 1, step: 1 }
    })

    function synchronizeLamp(name, value) {
        if (customProperties[name] !== value) {
            customProperties[name] = value
            customPropertiesChanged()
        }
    }
    onAccChanged: synchronizeLamp("acc", acc)
    onNormChanged: synchronizeLamp("norm", norm)

    AdaptiveSvgImage {
        anchors.fill: parent
        source: Qt.resolvedUrl("face.svg")
        fillMode: Image.PreserveAspectFit
    }
    AdaptiveSvgImage {
        anchors.fill: parent
        visible: root.acc > 0
        source: Qt.resolvedUrl("acc.svg")
        fillMode: Image.PreserveAspectFit
    }
    AdaptiveSvgImage {
        anchors.fill: parent
        visible: root.norm > 0
        source: Qt.resolvedUrl("norm.svg")
        fillMode: Image.PreserveAspectFit
    }
}
