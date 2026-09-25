import QtQuick 2.15

Rectangle {
    id: preview
    width: 1320
    height: 1288
    color: "#17262c"
    property var controls: [
        { id: "03", name: "Su30MfdButton", states: [0, 1] },
        { id: "08", name: "GrayTumbler2Position", states: [0, 1] },
        { id: "09", name: "Su30RedTipToggle", states: [0, 1] },
        { id: "10", name: "Su30YellowToggle3", states: [0, 1, 2] },
        { id: "12", name: "Su30RingToggle", states: [0, 1] },
        { id: "14", name: "Su30RudderTrimToggle", states: [0, 1, 2] },
        { id: "15", name: "Su30TrainSelector", states: [0, 1, 2, 3, 4] },
        { id: "17", name: "Su30RotaryKnob", states: [0, 0.1, 0.3, 0.6, 1] },
        { id: "26", name: "Su30Annunciator", states: [0, 1] },
        { id: "27", name: "Su30RoundLamp", states: [0, 1] },
        { id: "28", name: "Su30ResetButton", states: [0, 1] }
    ]
    property bool lampTest: true
    function componentUrl(control) {
        return Qt.resolvedUrl(control.id === "08"
            ? "ComponentLibrary/elements/Controls/simple/Tumblers/2Position/GrayTumbler2Position/GrayTumbler2Position.qml"
            : "ComponentLibrary/elements/Controls/Su30/" + control.name + "/" + control.name + ".qml")
    }
    Text { font.family: "Segoe UI";
        x: 28; y: 20
        text: "СУ-30  /  БАЗОВЫЕ КОМПОНЕНТЫ"
        color: "#f1f8f6"; font.pixelSize: 26; font.bold: true
    }
    Text { font.family: "Segoe UI";
        x: 28; y: 59
        text: "Слева — все состояния; справа — работающий экземпляр. Rotary: вращение мышью / колесо."
        color: "#a5bcc5"; font.pixelSize: 15
    }
    Text { font.family: "Segoe UI"; x: 365; y: 91; text: "VALUE / CURRENT STATE"; color: "#91aab4"; font.pixelSize: 12 }
    Text { font.family: "Segoe UI"; x: 1087; y: 91; text: "LIVE INPUT"; color: "#91aab4"; font.pixelSize: 12 }

    Column {
        x: 24; y: 116; spacing: 6
        Repeater {
            model: preview.controls
            delegate: Rectangle {
                id: row
                required property var modelData
                width: 1272; height: 96
                radius: 6; color: "#263b43"
                Text { font.family: "Segoe UI"; x: 16; y: 19; text: "ID " + row.modelData.id; color: "#82e1c1"; font.pixelSize: 16; font.bold: true }
                Text { font.family: "Segoe UI"; x: 16; y: 46; text: row.modelData.name; color: "#e4eeef"; font.pixelSize: 17 }
                Row {
                    x: 336
                    Repeater {
                        model: row.modelData.states
                        delegate: Item {
                            required property real modelData
                            width: 132; height: 96
                            Loader {
                                id: stateLoader
                                anchors.horizontalCenter: parent.horizontalCenter
                                y: 5
                                source: preview.componentUrl(row.modelData)
                                onLoaded: {
                                    var ratio = item.width / item.height
                                    item.height = Math.min(item.height, 66, 94 / ratio)
                                    item.width = item.height * ratio
                                    item.value = parent.modelData
                                }
                            }
                            Text { font.family: "Segoe UI";
                                anchors.horizontalCenter: parent.horizontalCenter
                                y: 76; text: parent.modelData
                                color: "#a8c3cc"; font.pixelSize: 13
                            }
                        }
                    }
                }
                Rectangle { x: 1031; y: 12; width: 1; height: 72; color: "#47616a" }
                Loader {
                    id: liveLoader
                    x: 1080; y: 5
                    source: preview.componentUrl(row.modelData)
                    onLoaded: {
                        var ratio = item.width / item.height
                        item.height = Math.min(item.height, 66, 90 / ratio)
                        item.width = item.height * ratio
                        item.runtimeMode = true
                        if (row.modelData.id === "26" || row.modelData.id === "27")
                            item.value = Qt.binding(function() { return preview.lampTest ? 1 : 0 })
                    }
                }
                Text { font.family: "Segoe UI";
                    x: 1188; y: 37
                    text: liveLoader.item ? Number(liveLoader.item.value.toFixed(2)) : "…"
                    color: "#82e1c1"; font.pixelSize: 19
                }
            }
        }
    }
    Rectangle {
        x: 24; y: 1244; width: 255; height: 30
        radius: 4; color: preview.lampTest ? "#3e7667" : "#354b53"
        Text { font.family: "Segoe UI"; anchors.centerIn: parent; text: "Проверка ламп: " + (preview.lampTest ? "ON" : "OFF"); color: "white"; font.pixelSize: 14 }
        MouseArea { anchors.fill: parent; onClicked: preview.lampTest = !preview.lampTest }
    }
    Text { font.family: "Segoe UI";
        x: 304; y: 1251
        text: "RUD TRIM: отпускание → нейтраль.    ID 17: аналоговый диапазон 0…1."
        color: "#a5bcc5"; font.pixelSize: 14
    }
}
