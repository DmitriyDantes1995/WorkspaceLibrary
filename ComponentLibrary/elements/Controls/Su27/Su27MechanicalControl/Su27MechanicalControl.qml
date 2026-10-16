import QtQuick 2.15
import common_qml 1.0

Toggle3Position {
    id: root
    my_type: "Su27MechanicalControl"
    my_subtype: "Su27MechanicalControl"
    implicitWidth: artworkBounds.w
    implicitHeight: artworkBounds.h
    clip: true
    previewSource: "preview.svg"
    property string profile: "protectedToggle"
    property string labelText: ""
    property bool guardOpen: false
    property bool mirror: false
    property bool threePosition: false
    property alias oxygen100: oxygen.value
    property alias emergencyOn: emergency.value
    property alias firePressed: fire.value
    readonly property bool hasGuard: ["fireControl", "conditioner", "wingNose", "protectedToggle", "guardedButton", "pyroToggle", "sduTestToggle"].indexOf(profile) >= 0
    readonly property var artworkBounds: {
        if (profile === "oxygenValve") return {x:14, y:35, w:72, h:72}
        if (profile === "suitVent") return {x:19, y:39, w:62, h:62}
        if (profile === "depressurization") return {x:8, y:32, w:78, h:86}
        if (profile === "ventilationSlider") return {x:24, y:8, w:52, h:124}
        if (profile === "rdk52") return {x:4, y:17, w:92, h:107}
        if (profile === "ad5a") return {x:14, y:40, w:72, h:72}
        if (profile === "fireControl") return {x:mirror ? 14 : 4, y:5, w:82, h:120}
        if (profile === "reserveIntake" || profile === "engineStart") return {x:36, y:58, w:28, h:70}
        if (profile === "wingNose" || profile === "pyroToggle" || profile === "sduTestToggle")
            return {x:18, y:5, w:64, h:126}
        return {x:24, y:5, w:52, h:122}
    }
    readonly property real artworkScale: Math.min(width / artworkBounds.w, height / artworkBounds.h)
    maximumValue: profile === "ventilationSlider" || profile === "wingNose"
                  || profile === "reserveIntake" || profile === "engineStart"
                  || profile === "ad5a" || (profile === "sduTestToggle" && threePosition) ? 2 : 1

    customProperties: ({profile: profile, value: value, labelText: labelText,
        guardOpen: guardOpen, mirror: mirror, threePosition: threePosition,
        oxygen100: oxygen100, emergencyOn: emergencyOn, firePressed: firePressed})
    propertySchema: {
        var schema = {
            profile: {displayName: "Mechanism", type: "enum", bindable: false,
                values: ["oxygenValve", "ventilationSlider", "suitVent", "depressurization", "rdk52", "fireControl", "conditioner", "wingNose", "protectedToggle", "guardedButton", "pyroToggle", "sduTestToggle", "ad5a", "reserveIntake", "engineStart"].map(function(name) { return {label: name, value: name} })},
            labelText: {displayName: "Cover label", type: "string", bindable: false}
        }
        if (profile !== "rdk52")
            schema.value = {displayName: profile === "fireControl" ? "Fuel shutoff" : "Value", type: "number", bindable: true, access: "readWrite", min: 0, max: maximumValue, step: 1}
        if (hasGuard)
            schema.guardOpen = {displayName: "Guard open", type: "bool", bindable: true, access: "readWrite"}
        if (profile === "rdk52") {
            schema.oxygen100 = {displayName: "100% oxygen", type: "number", bindable: true, access: "readWrite", min: 0, max: 1, step: 1}
            schema.emergencyOn = {displayName: "Emergency oxygen", type: "number", bindable: true, access: "readWrite", min: 0, max: 1, step: 1}
        }
        if (profile === "fireControl") {
            schema.firePressed = {displayName: "Extinguisher pressed", type: "number", bindable: true, access: "readWrite", min: 0, max: 1, step: 1}
            schema.mirror = {displayName: "Mirror L guard", type: "bool", bindable: false}
        }
        if (profile === "sduTestToggle")
            schema.threePosition = {displayName: "Check 1 (three positions)", type: "bool", bindable: false}
        return schema
    }

    function synchronize(name, next) {
        if (customProperties[name] !== next) {
            customProperties[name] = next
            customPropertiesChanged()
        }
    }
    function selectAt(x, y) {
        if (!acceptsInput || (hasGuard && !guardOpen) || profile === "rdk52" || profile === "guardedButton") return
        var localX = x - artwork.x
        var localY = y - artwork.y
        if (localX < 0 || localY < 0 || localX > artwork.width || localY > artwork.height) return
        var mechanismX = profile === "fireControl" && mirror ? artwork.width - localX : localX
        if (profile === "fireControl" && (mechanismX < artwork.width * 0.43 || localY < artwork.height * 0.45)) return
        if (maximumValue === 1) {
            // Toggle once on press; pointer movement must not toggle again.
            if (!pressSelected) {
                commitFromUser(value === 0 ? 1 : 0)
                pressSelected = true
            }
        } else {
            var fraction = hasGuard ? (localY / artwork.height - 0.35) / 0.65
                                    : (localY / artworkScale - artworkBounds.y) / artworkBounds.h
            var position = Math.max(0, Math.min(2, Math.floor(fraction * 3)))
            if (profile === "sduTestToggle") position = [1, 0, 2][position]
            if (profile === "wingNose" || profile === "reserveIntake" || profile === "engineStart")
                position = [1, 2, 0][position]
            commitFromUser(position)
        }
    }
    property bool pressSelected: false
    onHeldChanged: if (!held) pressSelected = false
    onProfileChanged: { synchronize("profile", profile); artwork.requestPaint() }
    onLabelTextChanged: { synchronize("labelText", labelText); artwork.requestPaint() }
    onGuardOpenChanged: { synchronize("guardOpen", guardOpen); artwork.requestPaint() }
    onMirrorChanged: { synchronize("mirror", mirror); artwork.requestPaint() }
    onThreePositionChanged: { synchronize("threePosition", threePosition); artwork.requestPaint() }
    onOxygen100Changed: { synchronize("oxygen100", oxygen100); artwork.requestPaint() }
    onEmergencyOnChanged: { synchronize("emergencyOn", emergencyOn); artwork.requestPaint() }
    onFirePressedChanged: { synchronize("firePressed", firePressed); artwork.requestPaint() }
    Connections {
        target: root
        function onValueChanged() { artwork.requestPaint() }
    }

    MechanismArtwork {
        id: artwork
        x: (root.width - root.artworkBounds.w * root.artworkScale) / 2 - root.artworkBounds.x * root.artworkScale
        y: (root.height - root.artworkBounds.h * root.artworkScale) / 2 - root.artworkBounds.y * root.artworkScale
        width: root.artworkScale * 100
        height: root.artworkScale * 140
        mechanism: root
    }
    Toggle2Position {
        id: emergency
        x: artwork.x + artwork.width * 0.03
        y: artwork.y + artwork.height * 0.35
        width: artwork.width * 0.44
        height: artwork.height * 0.6
        visible: root.profile === "rdk52"
        runtimeMode: root.runtimeMode
        onUserPropertyChanged: function(name, next) { root.userPropertyChanged("emergencyOn", next) }
    }
    Toggle2Position {
        id: oxygen
        x: artwork.x + artwork.width * 0.53
        y: artwork.y + artwork.height * 0.35
        width: artwork.width * 0.44
        height: artwork.height * 0.6
        visible: root.profile === "rdk52"
        runtimeMode: root.runtimeMode
        onUserPropertyChanged: function(name, next) { root.userPropertyChanged("oxygen100", next) }
    }
    MomentaryButton {
        id: fire
        x: artwork.x + artwork.width * (root.mirror ? 0.61 : 0.07)
        y: artwork.y + artwork.height * 0.12
        width: artwork.width * 0.32
        height: artwork.height * 0.32
        visible: root.profile === "fireControl"
        enabled: root.guardOpen
        runtimeMode: root.runtimeMode
        onUserPropertyChanged: function(name, next) { root.userPropertyChanged("firePressed", next) }
    }
    MomentaryButton {
        id: guardedButton
        x: artwork.x + artwork.width * 0.3
        y: artwork.y + artwork.height * 0.4
        width: artwork.width * 0.4
        height: artwork.height * 0.5
        visible: root.profile === "guardedButton"
        enabled: root.guardOpen
        runtimeMode: root.runtimeMode
        onUserPropertyChanged: function(name, next) { root.commitFromUser(next) }
    }
    Binding {
        target: guardedButton
        property: "value"
        value: root.value
        when: root.profile === "guardedButton"
    }
    MouseArea {
        x: artwork.x + artwork.width * (root.profile === "fireControl" ? (root.mirror ? 0.02 : 0.48) : 0.2)
        y: artwork.y + artwork.height * 0.01
        width: artwork.width * (root.profile === "fireControl" ? 0.5 : 0.6)
        height: artwork.height * 0.32
        enabled: root.hasGuard && root.acceptsInput
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            root.guardOpen = !root.guardOpen
            root.userPropertyChanged("guardOpen", root.guardOpen)
        }
    }
}
