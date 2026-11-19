import QtQuick 2.15
import "../../Su27/Su27Selector" as Selectors

// Retain the component path used by scenes created before the shared selector.
Selectors.Su27Selector {
    my_type: "Su30TargetType"
    my_subtype: my_type
    componentPath: "elements/Controls/Su30/Su30TargetType/Su30TargetType.qml"
    profile: "targetType"
    handleObjectName: "targetKnob"
}
