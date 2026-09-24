import QtQuick 2.0
import QtQuick.Layouts 1.3
import common_qml 1.0
import "_parts"
BaseSceneComponent {
    id: root
    readonly property real designWidth: 130
    readonly property real designHeight: 211

    width: designWidth
    height: designHeight
    preserveAspectRatio: true
    property bool runtimeMode: false
    my_type: "Type_panel_1"
    my_subtype: "SubType_panel_1"
    property real control_tumb_3pos
    property real control_tumb_Blue_2pos
    customProperties: ({
        "control_tumb_3pos": control_tumb_3pos,
        "control_tumb_Blue_2pos": control_tumb_Blue_2pos
    })
    propertySchema: ({
        "control_tumb_3pos": {
            displayName: "Main switch", type: "enum", bindable: true,
            access: "readWrite",
            values: [
                { label: "Down", value: 0 },
                { label: "Center", value: 1 },
                { label: "Left", value: 2 },
                { label: "Right", value: 3 }
            ]
        },
        "control_tumb_Blue_2pos": {
            displayName: "Blue switch", type: "enum", bindable: true,
            access: "readWrite",
            values: [
                { label: "Down", value: 0 },
                { label: "Up", value: 1 }
            ]
        }
    })

    function advanceMainSwitchFromUser() {
        root.control_tumb_3pos =
                (Math.round(root.control_tumb_3pos) + 1) % 4
        root.userPropertyChanged(
                    "control_tumb_3pos", root.control_tumb_3pos)
    }

    function toggleBlueSwitchFromUser() {
        root.control_tumb_Blue_2pos =
                root.control_tumb_Blue_2pos === 1 ? 0 : 1
        root.userPropertyChanged(
                    "control_tumb_Blue_2pos", root.control_tumb_Blue_2pos)
    }

    Item {
        id: visualRoot
        objectName: "visualRoot"
        width: root.designWidth
        height: root.designHeight
        anchors.centerIn: parent
        scale: Math.min(root.width / root.designWidth,
                        root.height / root.designHeight)

        Rectangle {
            anchors.fill: parent
            color: "#87CEEB"

            RowLayout {
                anchors.fill: parent
                spacing: 0
                CustomTumbler_3pos {
                    id: tumb_3pos
                    m_state: root.control_tumb_3pos

                    MouseArea {
                        anchors.fill: parent
                        enabled: root.runtimeMode
                        onClicked: root.advanceMainSwitchFromUser()
                    }
                }
                CustomTumbler_Blue_2pos {
                    id: tumb_blue_2pos
                    m_state: root.control_tumb_Blue_2pos

                    MouseArea {
                        anchors.fill: parent
                        enabled: root.runtimeMode
                        onClicked: root.toggleBlueSwitchFromUser()
                    }
                }
            }
        }
    }
}
