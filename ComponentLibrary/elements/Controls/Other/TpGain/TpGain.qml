import QtQuick 2.15
import "../../Su27/Su27Selector" as Selectors

// Retain the component path used by scenes created before the shared selector.
Selectors.Su27Selector {
    my_type: "TpGain"
    my_subtype: my_type
    componentPath: "elements/Controls/Other/TpGain/TpGain.qml"
    profile: "gain"
    handleObjectName: "gainKnob"
}
