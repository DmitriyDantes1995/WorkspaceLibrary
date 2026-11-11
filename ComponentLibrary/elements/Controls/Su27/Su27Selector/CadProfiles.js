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
