.pragma library

// Engravings from LEV_PLT_27УБК and PRAV_PLT_10C.
// The array index remains the hardware value minus the profile minimum.
var angles = {
    deltaH: [-60, -30, 0, 30, 60, 90, 120, 150, 180, 210, 240],
    radarMode: [-150, -120, -90, -60, -30, 0, 30],
    sauIndication: [-60, -30, 0, 30, 60, 90],
    sduMode: [60, 90, 120],
    radioChannel: Array.from({ length: 20 }, function(_, index) { return -162 + index * 18 }),
    radarRangeMode: [-94, -63, -31, -1],
    literaRls: [-150, -90, -30, 30, 90, 150],
    litera27: [-150, -117, -83, -50, -17, 17, 50, 83, 117, 150],
    radarProgram: [-150, -75, 0, 75, 150],
    fuelType: [-112, -89, -66],
    fuelMode: [-110, -77, -10, 56, 90, 120],
    guidance: [-30, 0, 60, 90],
    leader: [-30, 0, 30],
    pn187Program: [11, -54, -84, -114, -144, -204, -234],
    pn184Channels: [-131, -92, -55, -22, 14, 44, 68, 91, 111],
    // Legacy value 4 remains available even though the drawing ends at 14.
    pn188Range: [-48, -18, 13, 44, 75],
    pn188Mach: [-47, -16, 15, 46],
    warningType: [-150, -120, -90, -60, -30, 0, 30, 60, 90, 120, 150],
    heater: [-45, 180, 0, -90, 90]
}

var names = {
    deltaH: "ΔН",
    radarMode: "Ближний бой",
    sauIndication: "Индикация САУ",
    sduMode: "Режим СДУ",
    radarRangeMode: "Замер дальности",
    literaRls: "Литера РЛС",
    litera27: "Литера 27 и 33",
    radarProgram: "Программа РЛС",
    fuelType: "Тип топлива",
    fuelMode: "Режим топлива",
    guidance: "Наведение · ПАРА",
    leader: "КП · ВЕДУЩ · ВОДОМ",
    pn187Program: "Программа ПН-187",
    pn184Channels: "Каналы ПН-184",
    pn188Range: "Высота ПН-188",
    pn188Mach: "Число М ПН-188",
    warningType: "СПО · тип / высота",
    heater: "Обогрев АНО"
}

// Bounds are normalized to the CAD face, including any transparent margins.
var legends = {
    radarMode: [
        { key: "su27.scale.radar", bounds: [0.123, 0.315, 0.159, 0.086] },
        { key: "su27.scale.opticalLocator", bounds: [0.090, 0.456, 0.171, 0.086] },
        { key: "su27.scale.navigation", bounds: [0.030, 0.588, 0.267, 0.083] },
        { key: "su27.scale.vertical", bounds: [0.268, 0.151, 0.208, 0.083] },
        { key: "su27.scale.optical", bounds: [0.433, 0.073, 0.168, 0.086] },
        { key: "su27.scale.helmet", bounds: [0.532, 0.151, 0.241, 0.084] }
    ],
    sauIndication: [
        { key: "su27.scale.takeoff", bounds: [0.065, 0.254, 0.275, 0.092] },
        { key: "su27.scale.low", bounds: [0.771, 0.258, 0.177, 0.090] },
        { key: "su27.scale.landing", bounds: [0.668, 0.597, 0.305, 0.111] }
    ],
    sduMode: [
        { key: "su27.scale.automatic", bounds: [0.735, 0.333, 0.143, 0.075] },
        { key: "su27.scale.flight", bounds: [0.743, 0.461, 0.248, 0.077] },
        { key: "su27.scale.land", bounds: [0.723, 0.591, 0.156, 0.077] }
    ],
    guidance: [
        { key: "su27.scale.pair", bounds: [0.329, 0.097, 0.213, 0.081] },
        { key: "su27.scale.groundGuidance", bounds: [0.739, 0.305, 0.120, 0.100] },
        { key: "su27.scale.off", bounds: [0.783, 0.459, 0.201, 0.084] }
    ],
    leader: [
        { key: "su27.scale.commandPost", bounds: [0.254, 0.163, 0.100, 0.106] },
        { key: "su27.scale.leader", bounds: [0.375, 0.084, 0.320, 0.118] },
        { key: "su27.scale.wingman", bounds: [0.659, 0.168, 0.330, 0.116] }
    ],
    pn187Program: [
        { key: "su27.scale.program", bounds: [0.346, 0.166, 0.415, 0.092] },
        { key: "su27.scale.navigation", bounds: [0.114, 0.256, 0.285, 0.088] },
        { key: "su27.scale.land", bounds: [0.120, 0.427, 0.185, 0.092] },
        { key: "su27.scale.rendezvous", bounds: [0.117, 0.605, 0.225, 0.091] },
        { key: "su27.scale.range", bounds: [0.192, 0.707, 0.176, 0.091] },
        { key: "su27.scale.relay", bounds: [0.189, 0.801, 0.219, 0.088] },
        { key: "su27.scale.range", bounds: [0.658, 0.665, 0.176, 0.091] },
        { key: "su27.scale.relay", bounds: [0.548, 0.763, 0.219, 0.088] }
    ],
    pn184Channels: [
        { key: "su27.scale.preset", bounds: [0.737, 0.597, 0.260, 0.090] },
        { key: "su27.scale.channels", bounds: [0.397, 0.666, 0.359, 0.091] }
    ],
    pn188Range: [
        { key: "su27.scale.altitudeKm", bounds: [0.420, 0.735, 0.210, 0.103] }
    ],
    warningType: [
        { key: "su27.scale.threatP", bounds: [0.265, 0.137, 0.071, 0.106] },
        { key: "su27.scale.threatZ", bounds: [0.476, 0.057, 0.071, 0.109] }
    ],
    heater: [
        { key: "su27.heater.flash", bounds: [0.022, 0.447, 0.32, 0.11] }
    ]
}
