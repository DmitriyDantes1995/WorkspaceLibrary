import QtQuick 2.15
import "../../Su27/Su27Selector" as Selectors

// Retain the component path used by scenes created before the shared selector.
Selectors.Su27Selector {
    my_type: "Su30TrainSelector"
    my_subtype: my_type
    componentPath: "elements/Controls/Su30/Su30TrainSelector/Su30TrainSelector.qml"
    profile: "training"
    handleObjectName: "trainKnob"
}
