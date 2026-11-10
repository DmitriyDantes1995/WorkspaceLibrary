import QtQuick 2.15
import QtQuick.Shapes 1.15
import common_qml 1.0

MomentaryButton {
    id: root

    required property url releasedFace
    required property url pressedFace
    property int faceFillMode: Image.Stretch
    property Component faceOverlay
    required property string outlinePath
    property real outlineWidth: 0.85
    required property point markingCenter
    required property point pressedOffset
    property real markingWidth: 23
    property real singleTextWidth: 28
    property real markingHeight: 18
    property string labelBottomRight: ""
    property bool showDivider: false

    property string labelTop: ""
    property string labelBottom: ""
    property int arrowDirection: 0
    property int markingRotation: 0
    property bool showOutline: false
    property color outlineColor: "#e7bf42"

    customProperties: standardProperties
    propertySchema: standardPropertySchema

    readonly property var standardProperties: ({
        value: root.value,
        labelTop: root.labelTop,
        labelBottom: root.labelBottom,
        labelBottomRight: root.labelBottomRight,
        showDivider: root.showDivider,
        arrowDirection: root.arrowDirection,
        markingRotation: root.markingRotation,
        showOutline: root.showOutline,
        outlineColor: root.outlineColor.toString()
    })
    readonly property var standardPropertySchema: ({
        labelTop: { displayName: qsTr("Top text"), type: "string", bindable: false, order: 0 },
        labelBottom: { displayName: qsTr("Bottom text"), type: "string", bindable: false, order: 1 },
        labelBottomRight: { displayName: qsTr("Bottom right text"), type: "string", bindable: false, order: 1.1 },
        showDivider: { displayName: qsTr("Keypad dividers"), type: "bool", bindable: false, order: 1.2 },
        arrowDirection: { displayName: qsTr("Arrow"), type: "enum", bindable: false, order: 2, values: [
            { value: 0, label: qsTr("None") },
            { value: 1, label: "↑" },
            { value: 2, label: "→" },
            { value: 3, label: "↓" },
            { value: 4, label: "←" }
        ] },
        markingRotation: { displayName: qsTr("Marking rotation"), type: "enum", bindable: false, order: 3, values: [
            { value: 0, label: "0°" },
            { value: 90, label: "90°" },
            { value: -90, label: "−90°" },
            { value: 180, label: "180°" }
        ] },
        showOutline: { displayName: qsTr("Outline"), type: "bool", bindable: false, order: 4 },
        outlineColor: { displayName: qsTr("Outline color"), type: "color", bindable: false, order: 5, visibleWhen: { property: "showOutline", equals: true } },
        value: { displayName: qsTr("Pressed"), type: "number", bindable: true, access: "readWrite", min: 0, max: 1, step: 1, order: 6 }
    })

    Item {
        id: face
        anchors.centerIn: parent
        width: root.implicitWidth
        height: root.implicitHeight
        scale: Math.min(root.width / width, root.height / height)

        AdaptiveSvgImage {
            parent: root.faceFillMode === Image.PreserveAspectFit ? root : face
            anchors.fill: parent
            z: -1
            source: root.currentState === 1 ? root.pressedFace : root.releasedFace
            fillMode: root.faceFillMode
        }

        Loader {
            anchors.fill: parent
            sourceComponent: root.faceOverlay
        }

        Item {
            // The cap and its markings move together. The lamp stays in the housing.
            x: root.currentState === 1 ? root.pressedOffset.x : 0
            y: root.currentState === 1 ? root.pressedOffset.y : 0

            Shape {
                visible: root.showOutline
                width: face.width
                height: face.height
                antialiasing: true
                ShapePath {
                    strokeColor: root.outlineColor
                    strokeWidth: root.outlineWidth
                    fillColor: "transparent"
                    PathSvg { path: root.outlinePath }
                }
            }

            Item {
                id: marking
                readonly property bool hasUpperRow: topText.visible || arrow.visible
                readonly property bool hasLowerRow: bottomText.visible || bottomRight.visible
                readonly property bool singleText: !arrow.visible && !bottomRight.visible
                                                   && hasUpperRow !== hasLowerRow
                readonly property int topLines: root.labelTop.split("\n").length
                readonly property int bottomLines: Math.max(root.labelBottom.split("\n").length,
                                                            root.labelBottomRight.split("\n").length)
                readonly property real topRowHeight: height * topLines / (topLines + bottomLines)

                x: root.markingCenter.x - width / 2
                y: root.markingCenter.y - height / 2
                width: singleText ? root.singleTextWidth : root.markingWidth
                height: root.markingHeight
                rotation: root.markingRotation

                FaceText {
                    id: topText
                    singleLine: marking.singleText
                    height: marking.hasLowerRow ? marking.topRowHeight : (singleLine ? 13 : 9)
                    y: marking.hasLowerRow ? 0 : (marking.height - height) / 2
                    width: marking.width - (arrow.visible ? arrow.width + 3 : 0)
                    text: root.labelTop
                }

                Shape {
                    id: arrow
                    visible: root.arrowDirection !== 0
                    x: topText.visible ? marking.width - width - 2 : (marking.width - width) / 2
                    y: topText.y + (topText.height - height) / 2
                    width: 8
                    height: 8
                    // Direction is relative to the button, independently of the text angle.
                    rotation: (root.arrowDirection - 1) * 90 - root.markingRotation
                    antialiasing: true
                    ShapePath {
                        strokeWidth: -1
                        fillColor: "#f3f0e8"
                        PathSvg { path: "M 4 0.5 L 7.5 4 H 5.1 V 7.5 H 2.9 V 4 H 0.5 Z" }
                    }
                }

                FaceText {
                    id: bottomText
                    singleLine: marking.singleText
                    height: marking.hasUpperRow ? marking.height - marking.topRowHeight
                                                : (singleLine ? 13 : marking.height)
                    y: marking.hasUpperRow ? marking.topRowHeight : (marking.height - height) / 2
                    width: bottomRight.visible ? marking.width / 2 : marking.width
                    text: root.labelBottom
                }

                FaceText {
                    id: bottomRight
                    x: marking.width / 2
                    y: bottomText.y
                    width: marking.width / 2
                    height: bottomText.height
                    text: root.labelBottomRight
                }

                Rectangle {
                    visible: root.showDivider && marking.hasUpperRow && marking.hasLowerRow
                    y: marking.topRowHeight - height / 2
                    width: marking.width
                    height: 0.7
                    color: "#f3f0e8"
                }

                Rectangle {
                    visible: root.showDivider && bottomRight.visible
                    x: marking.width / 2 - width / 2
                    y: bottomText.y
                    width: 0.7
                    height: bottomText.height
                    color: "#f3f0e8"
                }
            }
        }
    }

    component FaceText: Text {
        property bool singleLine: false

        visible: text.length > 0
        color: "#f3f0e8"
        font.family: "Arial"
        font.bold: true
        font.pixelSize: singleLine ? 12 : 9
        minimumPixelSize: 4
        fontSizeMode: Text.Fit
        textFormat: Text.PlainText
        elide: Text.ElideRight
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
