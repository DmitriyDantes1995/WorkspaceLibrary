import QtQuick 2.15
import common_qml 1.0

Indicator {
    id: root

    required property url assetDirectory
    property bool testMode: false
    previewSource: Qt.resolvedUrl(assetDirectory + "state_1.svg")
    customProperties: ({ value: value, testMode: testMode })
    propertySchema: ({
        value: { displayName: "Illuminated", type: "number", bindable: true,
                 access: "readOnly", min: 0, max: 1 },
        testMode: { displayName: "Test mode", type: "bool", bindable: false, access: "readWrite" }
    })

    AdaptiveSvgImage {
        anchors.fill: parent
        source: root.assetDirectory + "state_" + root.currentState + ".svg"
        fillMode: Image.Stretch
    }

    MouseArea {
        anchors.fill: parent
        enabled: root.acceptsInput && root.testMode
        preventStealing: true
        cursorShape: Qt.PointingHandCursor
        onPressed: root.commitFromUser(1)
        onReleased: root.commitFromUser(0)
        onCanceled: root.commitFromUser(0)
    }
}
