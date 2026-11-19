.pragma library
.import "BoardProfiles.js" as Boards
.import "CadProfiles.js" as Cad

function range(first, last) {
    var result = []
    for (var i = first; i <= last; ++i) result.push(String(i))
    return result
}

// Index is always the native hardware value minus the profile minimum.
var profiles = {
    deltaH: {
        label: "ΔH · tbl_purdeltah",
        // 1LeftBort.swf: hardware codes reverse Flash's detent indices.
        // The artwork is upright before the panel's 90° installation rotation.
        angles: [-60, -30, 0, 30, 60, 90, 120, 150, 180, 210, 240],
        artwork: "_parts/_art/deltaH/"
    },
    radarMode: {
        label: "Left · tbl_purmode",
        angles: [-150, -120, -90, -60, -30, 0, 30],
        artwork: "_parts/_art/purModeOriginal/"
    },
    guidance: {
        label: "Right · tbl_tks_mode",
        angles: [-30, 0, 30, 60],
        artwork: "_parts/_art/tksModeOriginal/"
    },
    literaRls: { labels: range(0, 5), start: -120, end: 120, handle: "bar" },
    litera27: { labels: range(0, 9), start: -150, end: 150, handle: "bar" },
    radarProgram: { labels: range(0, 4), start: -100, end: 100, handle: "bar" },
    radarRangeMode: { labels: ["ОТКЛ", "КАБР", "ГРУППА", "ОДИН"], start: -90, end: 90, handle: "bar" },
    aimWave: { labels: range(1, 40), minimum: 1, start: -165, end: 165, handle: "bar", labelEvery: 5 },
    aimCode: { labels: range(1, 20), minimum: 1, start: -150, end: 150, handle: "bar", labelEvery: 2 },
    aimCarry: { labels: range(1, 8), minimum: 1, start: -140, end: 140, handle: "bar" },
    fuelType: { labels: ["ТС1", "РТ", "ТС"], start: -55, end: 55, handle: "arrow" },
    fuelMode: { labels: ["АВТ", "РУЧ", "ОТКЛ", "I", "II", "-"], start: -125, end: 125, handle: "arrow" },
    identificationKd: {
        labels: [{ ru: "АВТ", en: "AUTO" }, { ru: "КД", en: "KD" }, "±15", { ru: "КП", en: "KP" }],
        start: -65, end: 65, handle: "arrow"
    },
    identificationReply: {
        labels: [{ ru: "ГОТОВ", en: "READY" }, { ru: "РСП", en: "GCA" },
                 { ru: "УВД", en: "ATC" }, { ru: "УВД-М", en: "ATC-I" },
                 { ru: "П-35", en: "P-35" }, { ru: "БАН", en: "BAN" }],
        start: -110, end: 110, handle: "arrow"
    },
    highCode: { labels: ["III-2", "III-1", "II", "I"], start: 65, end: -65, handle: "diamond" },
    pn187Program: { labels: ["ПРОГР", "НАВ", "ПОС", "ВСТР", "ИЗМ-РЕТР", "РЕТР", "ИЗМ"], start: -130, end: 130, handle: "arrow" },
    pn184Channels: { labels: ["1", "2", "3", "4", "5", "6", "7", "8", "ППН"], start: -140, end: 140, handle: "arrow" },
    warningMode: { labels: range(1, 9), start: -135, end: 135, handle: "paddle" },
    heater: { labels: ["ОТКЛ", "30%", "100%", "ПРОБЛ", "60%"], angles: [0, 45, 135, 180, 90], handle: "arrow" },
    voltageTest: {
        labels: [{ ru: "ОТКЛ", en: "OFF" }, { ru: "ЛЕВ", en: "LEFT" }, { ru: "ПРАВ", en: "RIGHT" }],
        angles: [-60, 0, 60], handle: "arrow"
    },
    cockpitHeating: { labels: ["ОТКЛ", "АВТОМАТ", "ГОРЯЧ", "ХОЛОД"], start: -90, end: 90, handle: "arrow" },
    training: {
        label: "TRAIN · Су-30",
        layout: { width: 106, height: 138, centerX: 66, centerY: 91 },
        angles: [[35.5, 110], [31, 90], [33, 71.5], [47.5, 55.5], [66.5, 48.5]].map(function(point) {
            return Math.atan2(point[0] - 66, 91 - point[1]) * 180 / Math.PI
        }),
        positions: [{ key: "su27.center.trainSingle" }, { key: "su27.center.trainPart" }, "0.1", "0.2", "0.4"],
        scaleSource: "../../Su30/Su30TrainSelector/_parts/scale.svg",
        scaleLegends: [
            { key: "su27.center.train", bounds: [0.18, 0.014, 0.49, 0.101], color: "#e0e5df" },
            { key: "su27.center.trainPart", bounds: [0.00, 0.521, 0.29, 0.100], color: "#e0e5df" },
            { key: "su27.center.trainSingle", bounds: [0.073, 0.846, 0.30, 0.100], color: "#e0e5df" }
        ],
        handle: "training"
    },
    targetType: {
        label: "TARGET TYPE · Су-30",
        layout: { width: 92.7, height: 92.9, centerX: 46.35, centerY: 53 },
        angles: [-151.34017782851353, 0, 151.34017782851353],
        positions: [{ key: "su27.center.targetSmall" }, { key: "su27.center.targetMedium" },
                    { key: "su27.center.targetLarge" }],
        scaleSource: "../../Su30/Su30TargetType/scale.svg",
        scaleLegends: [
            { key: "su27.center.targetType", bounds: [0.10, 0.00, 0.80, 0.109], bold: true },
            { key: "su27.center.targetSmall", bounds: [0.18, 0.765, 0.11, 0.101], bold: true },
            { key: "su27.center.targetMedium", bounds: [0.445, 0.125, 0.11, 0.101], bold: true },
            { key: "su27.center.targetLarge", bounds: [0.71, 0.765, 0.11, 0.101], bold: true }
        ],
        handle: "targetType"
    },
    gain: {
        label: "AMPLFCN HDF",
        layout: { width: 92.7, height: 92.9, centerX: 36, centerY: 53 },
        angles: [-143.88065915052024, -34.6079454105833, 33.66468171483053,
                 87.49099180556927, 106.52674504266514, 126.58007006028659, 147.4468004471465],
        positions: ["0.4", "0.5", "0.6", "0.7", "0.8", "0.9", "1.0"],
        scaleSource: "../../Other/TpGain/_parts/scale.svg",
        scaleLegends: [{ key: "su27.center.gain", bounds: [0.042, 0.012, 0.82, 0.113],
                         bold: true, alignLeft: true }],
        handle: "targetType"
    }
}

Object.assign(profiles, Boards.profiles)
profiles.pn187Program.artwork = profiles.navModeOriginal.artwork
profiles.pn184Channels.artwork = profiles.arkSource.artwork
profiles.radarRangeMode.artwork = profiles.sauIndication.artwork
var literaProfiles = ["literaRls", "litera27", "radarProgram"]
literaProfiles.forEach(function(key) {
    profiles[key].artwork = profiles.deltaH.artwork
})

var defaultHandles = {
    deltaH: ["deltaH", "radarMode", "literaRls", "litera27", "radarProgram"],
    sau: ["sauIndication", "sduMode", "radarRangeMode", "arkSource", "pn184Channels",
          "pn188Range", "pn188Mach", "sroSource"],
    guidance: ["guidance", "leader", "srzoSource"],
    countermeasures: ["intervalLtc", "salvoLtc"],
    navigation: ["navModeOriginal", "pn187Program"],
    radio: ["radioChannel"],
    warning: ["warningType"],
    emission: ["emissionSource"]
}
Object.keys(defaultHandles).forEach(function(handle) {
    for (var key of defaultHandles[handle])
        profiles[key].handle = handle
})

Object.keys(Cad.angles).forEach(function(key) {
    profiles[key].cadScale = "_parts/_cad/" + key + ".svg"
    profiles[key].scaleLegends = Cad.legends[key] || []
    profiles[key].angles = Cad.angles[key]
})

// These controls display their selection on the drum above the handle.
var drumProfiles = ["aimWave", "aimCode", "aimCarry"]
drumProfiles.forEach(function(key) {
    profiles[key].scaleMarks = false
    profiles[key].drumOnly = true
})
profiles.radioChannel.drumOnly = true

// Keep the profile keys used by scenes saved with the first import.
var legacyProfiles = { purModeOriginal: "radarMode", tksModeOriginal: "guidance" }
Object.keys(legacyProfiles).forEach(function(key) {
    profiles[key] = profiles[legacyProfiles[key]]
})

function anglesFor(profile) {
    if (profile.angles) return profile.angles
    var result = []
    for (var i = 0; i < profile.labels.length; ++i)
        result.push(profile.start + i * (profile.end - profile.start) / Math.max(1, profile.labels.length - 1))
    return result
}

function choices(currentProfile) {
    return Object.keys(profiles).filter(function(name) {
        const profile = profiles[name]
        return name === currentProfile || (!legacyProfiles[name] && !profile.drumOnly
                && (!profile.artwork || profile.cadScale || name === "intervalLtc" || name === "salvoLtc"))
    }).map(function(name) {
        var profile = profiles[name]
        var label = Cad.names[name] || profile.label || name
        var sourceName = Cad.names[name] && profile.label ? profile.label.split(" · ").pop() : ""
        return { label: sourceName ? label + " · " + sourceName : label, value: name }
    })
}
