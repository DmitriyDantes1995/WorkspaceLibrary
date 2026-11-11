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
        artwork: "_parts/_art/purModeOriginal/",
        handleSource: "_parts/_art/deltaH/handle.svg",
        handleScale: 112 / 160
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
    identificationKd: { labels: ["АВТ", "КД", "±15", "КП"], start: -65, end: 65, handle: "arrow" },
    identificationReply: { labels: ["ГОТОВ", "РСП", "УВД", "УВД-М", "П-35", "БАН"], start: -110, end: 110, handle: "arrow" },
    highCode: { labels: ["III-2", "III-1", "II", "I"], start: 65, end: -65, handle: "diamond" },
    pn187Program: { labels: ["ПРОГР", "НАВ", "ПОС", "ВСТР", "ИЗМ-РЕТР", "РЕТР", "ИЗМ"], start: -130, end: 130, handle: "arrow" },
    pn184Channels: { labels: ["1", "2", "3", "4", "5", "6", "7", "8", "ППН"], start: -140, end: 140, handle: "arrow" },
    warningMode: { labels: range(1, 9), start: -135, end: 135, handle: "paddle" },
    heater: { labels: ["ОТКЛ", "30%", "100%", "ПРОБЛ", "60%"], angles: [0, 45, 135, 180, 90], handle: "arrow" },
    voltageTest: { labels: ["ОТКЛ", "ЛЕВ", "ПРАВ"], angles: [-60, 0, 60], handle: "arrow" },
    cockpitHeating: { labels: ["ОТКЛ", "АВТОМАТ", "ГОРЯЧ", "ХОЛОД"], start: -90, end: 90, handle: "arrow" }
}

Object.assign(profiles, Boards.profiles)
profiles.pn187Program.artwork = profiles.navModeOriginal.artwork
profiles.pn184Channels.artwork = profiles.arkSource.artwork
profiles.radarRangeMode.artwork = profiles.sauIndication.artwork
var literaProfiles = ["literaRls", "litera27", "radarProgram"]
literaProfiles.forEach(function(key) {
    profiles[key].artwork = profiles.deltaH.artwork
    profiles[key].handleScale = 0.86
})
Object.keys(Cad.angles).forEach(function(key) {
    profiles[key].cadScale = "_parts/_cad/" + key + ".svg"
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

function choices() {
    return Object.keys(profiles).map(function(name) {
        var profile = profiles[name]
        var label = Cad.names[name] || profile.label || name
        var sourceName = Cad.names[name] && profile.label ? profile.label.split(" · ").pop() : ""
        return { label: sourceName ? label + " · " + sourceName : label, value: name,
                 catalogHidden: legacyProfiles[name] !== undefined || profile.drumOnly === true
                    || (profile.artwork && !profile.cadScale && name !== "intervalLtc" && name !== "salvoLtc"),
                 previewSource: profile.artwork && !profile.cadScale ? profile.artwork + "preview.svg" : "" }
    })
}
