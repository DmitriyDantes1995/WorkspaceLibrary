import QtQuick 2.15
import common_qml 1.0

BaseSceneComponent {
    id: root

    readonly property real designWidth: 788.8
    readonly property real designHeight: 635.8

    // Safe rectangular part of the rounded screen opening in
    // outline_screen.svg design coordinates.
    readonly property real screenAreaX: 238.3
    readonly property real screenAreaY: 135.1
    readonly property real screenAreaWidth: 417.7
    readonly property real screenAreaHeight: 361.4

    property string targetWindowTitle: ""
    property string fitMode: "fit"

    componentPath: "elements/Controls/simple/Indicators/ExternalWindowScreen/ExternalWindowScreen.qml"
    my_type: "ExternalWindowScreen"
    my_subtype: "ExternalWindowScreen"
    previewSource: "outline_screen.svg"

    preserveAspectRatio: true
    implicitWidth: designWidth
    implicitHeight: designHeight
    width: implicitWidth
    height: implicitHeight
    clip: true

    customProperties: ({
        "targetWindowTitle": targetWindowTitle,
        "fitMode": fitMode
    })
    propertySchema: ({
        "targetWindowTitle": {
            displayName: "Window title", type: "string", bindable: true
        },
        "fitMode": {
            displayName: "Fit mode", type: "enum", bindable: true,
            values: [
                { label: "Fit", value: "fit" },
                { label: "Crop", value: "crop" },
                { label: "Stretch", value: "stretch" }
            ]
        }
    })

    Item {
        id: visualRoot
        objectName: "visualRoot"

        width: root.designWidth
        height: root.designHeight
        scale: Math.max(0, Math.min(root.width / root.designWidth,
                                    root.height / root.designHeight))
        transformOrigin: Item.TopLeft
        x: (root.width - width * scale) / 2
        y: (root.height - height * scale) / 2

        // outline_screen.svg paints an opaque screen backing. Keep the frame
        // as the base, then place content only inside the exact safe opening;
        // clipping prevents either placeholder or runtime video from touching
        // the surrounding bezel.
        AdaptiveSvgImage {
            id: frameImage
            objectName: "externalWindowFrameImage"

            anchors.fill: parent
            source: Qt.resolvedUrl("outline_screen.svg")
            fillMode: Image.PreserveAspectFit
            smooth: true
        }

        Item {
            id: screenArea
            objectName: "externalWindowScreenArea"

            x: root.screenAreaX
            y: root.screenAreaY
            width: root.screenAreaWidth
            height: root.screenAreaHeight
            clip: true

            AdaptiveSvgImage {
                id: screenContent
                objectName: "externalWindowScreenContent"

                anchors.fill: parent
                source: Qt.resolvedUrl("input_screen.svg")
                fillMode: root.fitMode === "crop"
                          ? Image.PreserveAspectCrop
                          : (root.fitMode === "stretch"
                             ? Image.Stretch
                             : Image.PreserveAspectFit)
                smooth: true
            }
        }
    }
}
