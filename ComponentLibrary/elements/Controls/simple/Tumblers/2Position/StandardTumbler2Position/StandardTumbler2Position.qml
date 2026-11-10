import QtQuick 2.15
import "../UniversalToggleSwitch" as Switches

// Kept loadable for scenes saved with the original component path and oN binding.
Switches.UniversalToggleSwitch {
    my_type: "StandardTumbler2Position"
    my_subtype: "StandardTumbler2Position"
    appearance: "metal"
    tipColor: "default"
    valuePropertyName: "oN"
}
