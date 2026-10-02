import QtQuick 2.15
import common_qml 1.0
MomentaryButton {
    width:11.2;height:11.6
    AdaptiveSvgImage {anchors.fill:parent;source:Qt.resolvedUrl("button_"+root.currentState+".svg");fillMode:Image.Stretch}
    id:root
}
