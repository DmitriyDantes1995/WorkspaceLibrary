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
    property bool showDivider: false
    property bool markingsVisible: true

    property string labelTop: ""
    property real labelTopFontSize: 0
    property real labelTopOffsetX: 0
    property real labelTopOffsetY: 0
    property string labelBottom: ""
    property real labelBottomFontSize: 0
    property real labelBottomOffsetX: 0
    property real labelBottomOffsetY: 0
    property string labelBottomRight: ""
    property real labelBottomRightFontSize: 0
    property real labelBottomRightOffsetX: 0
    property real labelBottomRightOffsetY: 0
    property int arrowDirection: 0
    property int markingRotation: 0
    property bool showOutline: false
    property color outlineColor: "#e7bf42"

    customProperties: standardProperties
    propertySchema: standardPropertySchema

    readonly property var standardProperties: ({
        value: root.value,
        labelTop: root.labelTop,
        labelTopFontSize: root.labelTopFontSize,
        labelTopOffsetX: root.labelTopOffsetX,
        labelTopOffsetY: root.labelTopOffsetY,
        labelBottom: root.labelBottom,
        labelBottomFontSize: root.labelBottomFontSize,
        labelBottomOffsetX: root.labelBottomOffsetX,
        labelBottomOffsetY: root.labelBottomOffsetY,
        labelBottomRight: root.labelBottomRight,
        labelBottomRightFontSize: root.labelBottomRightFontSize,
        labelBottomRightOffsetX: root.labelBottomRightOffsetX,
        labelBottomRightOffsetY: root.labelBottomRightOffsetY,
        showDivider: root.showDivider,
        arrowDirection: root.arrowDirection,
        markingRotation: root.markingRotation,
        showOutline: root.showOutline,
        outlineColor: root.outlineColor.toString()
    })
    readonly property var standardPropertySchema: Object.assign({
        labelTop: { displayName: qsTr("Top text"), type: "string", bindable: false, hidden: !root.markingsVisible, order: 0 },
        labelBottom: { displayName: qsTr("Bottom text"), type: "string", bindable: false, hidden: !root.markingsVisible, order: 1 },
        labelBottomRight: { displayName: qsTr("Bottom right text"), type: "string", bindable: false, hidden: !root.markingsVisible, order: 1.1 },
        showDivider: { displayName: qsTr("Keypad dividers"), type: "bool", bindable: false, hidden: !root.markingsVisible, order: 1.2 },
        arrowDirection: { displayName: qsTr("Arrow"), type: "enum", bindable: false, hidden: !root.markingsVisible, order: 2, values: [
            { value: 0, label: qsTr("None") },
            { value: 1, label: "↑" },
            { value: 2, label: "→" },
            { value: 3, label: "↓" },
            { value: 4, label: "←" }
        ] },
        markingRotation: { displayName: qsTr("Marking rotation"), type: "enum", bindable: false, hidden: !root.markingsVisible, order: 3, values: [
            { value: 0, label: "0°" },
            { value: 90, label: "90°" },
            { value: -90, label: "−90°" },
            { value: 180, label: "180°" }
        ] },
        showOutline: { displayName: qsTr("Outline"), type: "bool", bindable: false, hidden: !root.markingsVisible, order: 4 },
        outlineColor: { displayName: qsTr("Outline color"), type: "color", bindable: false, hidden: !root.markingsVisible, order: 5, visibleWhen: { property: "showOutline", equals: true } },
        value: { displayName: qsTr("Pressed"), type: "number", bindable: true, access: "readWrite", min: 0, max: 1, step: 1, order: 6 }
    }, textLayoutSchema("labelTop", root.labelTop, 0),
       textLayoutSchema("labelBottom", root.labelBottom, 1),
       textLayoutSchema("labelBottomRight", root.labelBottomRight, 1.1))

    function textLayoutSchema(field, text, order) {
        const hidden = !root.markingsVisible || text.length === 0
        return {
            [field + "FontSize"]: { displayName: "Font size", type: "number", bindable: false,
                hidden: hidden, min: 0, max: 48, step: 1, unit: "px", order: order + 0.01 },
            [field + "OffsetX"]: { displayName: "ΔX", type: "number", bindable: false,
                hidden: hidden, unit: "px", order: order + 0.02 },
            [field + "OffsetY"]: { displayName: "ΔY", type: "number", bindable: false,
                hidden: hidden, unit: "px", order: order + 0.03 }
        }
    }

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
            visible: root.markingsVisible
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

                function offsetInButtonAxes(x, y) {
                    // Undo the text rotation so X and Y still follow the button face.
                    const angle = -rotation * Math.PI / 180
                    const cosine = Math.cos(angle)
                    const sine = Math.sin(angle)
                    return Qt.point(x * cosine - y * sine, x * sine + y * cosine)
                }

                FaceText {
                    id: topText
                    singleLine: marking.singleText
                    height: marking.hasLowerRow ? marking.topRowHeight : (singleLine ? 13 : 9)
                    y: marking.hasLowerRow ? 0 : (marking.height - height) / 2
                    width: marking.width - (arrow.visible ? arrow.width + 3 : 0)
                    text: root.labelTop
                    customFontSize: root.labelTopFontSize
                    positionOffset: marking.offsetInButtonAxes(root.labelTopOffsetX, root.labelTopOffsetY)
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
                    customFontSize: root.labelBottomFontSize
                    positionOffset: marking.offsetInButtonAxes(root.labelBottomOffsetX, root.labelBottomOffsetY)
                }

                FaceText {
                    id: bottomRight
                    x: marking.width / 2
                    y: bottomText.y
                    width: marking.width / 2
                    height: bottomText.height
                    text: root.labelBottomRight
                    customFontSize: root.labelBottomRightFontSize
                    positionOffset: marking.offsetInButtonAxes(root.labelBottomRightOffsetX, root.labelBottomRightOffsetY)
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
        id: legend
        property bool singleLine: false
        property real customFontSize: 0
        property point positionOffset: Qt.point(0, 0)
        readonly property bool automaticSize: customFontSize <= 0

        visible: text.length > 0
        color: "#f3f0e8"
        font.family: "Arial"
        font.bold: true
        font.pixelSize: automaticSize ? (singleLine ? 12 : 9) : Math.max(1, Math.round(customFontSize))
        minimumPixelSize: 4
        fontSizeMode: automaticSize ? Text.Fit : Text.FixedSize
        textFormat: Text.PlainText
        elide: automaticSize ? Text.ElideRight : Text.ElideNone
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        transform: Translate {
            x: legend.positionOffset.x
            y: legend.positionOffset.y
        }
    }
}
