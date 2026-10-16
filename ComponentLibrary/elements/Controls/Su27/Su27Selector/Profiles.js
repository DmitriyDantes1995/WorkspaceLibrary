.pragma library

function range(first, last) {
    var result = []
    for (var i = first; i <= last; ++i) result.push(String(i))
    return result
}

// Index is always the native hardware value minus the profile minimum.
var profiles = {
    deltaH: { labels: ["+10", "+8", "+6", "+4", "+2", "0", "-2", "-4", "-6", "-8", "-10"], start: -150, end: 150, handle: "paddle" },
    radarMode: { labels: ["Ф0", "НАВИГ", "ОЛС", "РЛС", "ВЕРТ", "ОПТ", "ШЛЕМ"], start: -135, end: 135, handle: "paddle" },
    sauIndication: { labels: ["ВЗЛЕТ", "Н11", "Н5", "Н0.2", "Нмал", "ПОС"], start: -120, end: 120, handle: "arrow" },
    sduMode: { labels: ["АВТ", "ПОЛЕТ", "ПОС"], start: -65, end: 65, handle: "arrow" },
    literaRls: { labels: range(0, 5), start: -120, end: 120, handle: "bar" },
    litera27: { labels: range(0, 9), start: -150, end: 150, handle: "bar" },
    radarProgram: { labels: range(0, 4), start: -100, end: 100, handle: "bar" },
    radarRangeMode: { labels: ["ОТКЛ", "КАБР", "ГРУППА", "ОДИН"], start: -90, end: 90, handle: "bar" },
    radioChannel: { labels: range(1, 20), minimum: 1, start: -150, end: 150, handle: "fluted", labelEvery: 2 },
    aimWave: { labels: range(1, 40), minimum: 1, start: -165, end: 165, handle: "bar", labelEvery: 5 },
    aimCode: { labels: range(1, 20), minimum: 1, start: -150, end: 150, handle: "bar", labelEvery: 2 },
    aimCarry: { labels: range(1, 8), minimum: 1, start: -140, end: 140, handle: "bar" },
    fuelType: { labels: ["ТС1", "РТ", "ТС"], start: -55, end: 55, handle: "arrow" },
    fuelMode: { labels: ["АВТ", "РУЧ", "ОТКЛ", "I", "II", "-"], start: -125, end: 125, handle: "arrow" },
    intervalLtc: { labels: ["ОТКЛ", "ДО", "ДО1", "ДО2", "ДО3", "=", "ЛТЦ1", "ЛТЦ2", "ЛТЦ3"], start: -130, end: 130, handle: "bar" },
    salvoLtc: { labels: ["ОТКЛ", "1", "2", "4"], start: -90, end: 90, handle: "bar" },
    identificationKd: { labels: ["АВТ", "КД", "±15", "КП"], start: -65, end: 65, handle: "arrow" },
    identificationReply: { labels: ["ГОТОВ", "РСП", "УВД", "УВД-М", "П-35", "БАН"], start: -110, end: 110, handle: "arrow" },
    highCode: { labels: ["III-2", "III-1", "II", "I"], start: 65, end: -65, handle: "diamond" },
    guidance: { labels: ["ПАРА2", "ПАРА1", "ГД", "ОТКЛ"], start: -90, end: 90, handle: "arrow" },
    leader: { labels: ["КП", "ВЕДУЩ", "ВЕДОМ"], start: -65, end: 65, handle: "arrow" },
    pn187Program: { labels: ["ПРОГР", "НАВ", "ПОС", "ВСТР", "ИЗМ-РЕТР", "РЕТР", "ИЗМ"], start: -130, end: 130, handle: "arrow" },
    pn184Channels: { labels: ["1", "2", "3", "4", "5", "6", "7", "8", "ППН"], start: -140, end: 140, handle: "arrow" },
    pn188Range: { labels: ["4", "7", "11", "14", "17"], start: -110, end: 110, handle: "arrow" },
    pn188Mach: { labels: ["0.9", "1.3", "1.8", "2.16"], start: -100, end: 100, handle: "arrow" },
    warningMode: { labels: range(1, 9), start: -135, end: 135, handle: "paddle" },
    warningType: { labels: ["1.5", "8", "16", "30", "П", "З", "Х", "H", "F", "С", "1-6"], start: -150, end: 150, handle: "paddle" },
    heater: { labels: ["ОТКЛ", "30%", "100%", "ПРОБЛ", "60%"], angles: [0, 45, 135, 180, 90], handle: "arrow" },
    voltageTest: { labels: ["ОТКЛ", "ЛЕВ", "ПРАВ"], angles: [-60, 0, 60], handle: "arrow" },
    cockpitHeating: { labels: ["ОТКЛ", "АВТОМАТ", "ГОРЯЧ", "ХОЛОД"], start: -90, end: 90, handle: "arrow" }
}

function anglesFor(profile) {
    if (profile.angles) return profile.angles
    var result = []
    for (var i = 0; i < profile.labels.length; ++i)
        result.push(profile.start + i * (profile.end - profile.start) / Math.max(1, profile.labels.length - 1))
    return result
}

function choices() {
    return Object.keys(profiles).map(function(name) { return { label: name, value: name } })
}
