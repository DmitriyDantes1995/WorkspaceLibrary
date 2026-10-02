import QtQuick 2.15
import common_qml 1.0
MomentaryButton {
    width:44; height:18
    Rectangle { anchors.fill:parent; radius:4; color:parent.value ? "#929f9f" : "#ffffff"; border.color:parent.value ? "#111e22" : "#c9d7d7"; border.width:0.7 }
}
