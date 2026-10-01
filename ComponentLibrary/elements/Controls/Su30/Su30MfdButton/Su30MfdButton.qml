import QtQuick 2.15
import "../Su30Mfd/_parts"

// Legacy entry point; the complete instrument owns the artwork.
MfdButton {
    my_type: "Su30MfdButton"
    my_subtype: "Su30MfdButton"
    implicitWidth: 64
    implicitHeight: 64
    previewSource: "../Su30Mfd/_parts/state_0.svg"
}
