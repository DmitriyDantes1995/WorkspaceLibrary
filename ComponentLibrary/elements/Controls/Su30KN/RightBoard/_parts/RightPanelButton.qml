import QtQuick 2.15
import common_qml 1.0

ControlState {
    id: root

    required property url assetDirectory
    required property rect hitRegion

    AdaptiveSvgImage {
        anchors.fill: parent
        source: root.assetDirectory + "state_" + root.currentState + ".svg"
        fillMode: Image.PreserveAspectFit
    }

    MomentaryButton {
        x: root.width * root.hitRegion.x
        y: root.height * root.hitRegion.y
        width: root.width * root.hitRegion.width
        height: root.height * root.hitRegion.height
        runtimeMode: root.acceptsInput
        onUserPropertyChanged: function(propertyName, value) { root.commitFromUser(value) }
    }
}
