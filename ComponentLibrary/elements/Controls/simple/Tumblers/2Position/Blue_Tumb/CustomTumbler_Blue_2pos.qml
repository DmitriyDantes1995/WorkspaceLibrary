import QtQuick 2.15
import "../UniversalToggleSwitch" as Switches

// Kept loadable for scenes saved with the original component path and oN binding.
Switches.UniversalToggleSwitch {
    my_type: "CustomTumbler_Blue_2pos"
    my_subtype: "CustomTumbler_Blue_2pos"
    appearance: "longLever"
    tipColor: "blue"
    valuePropertyName: "oN"
}
