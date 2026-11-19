.pragma library

var entries = {
    arrow: { name: { ru: "Указатель", en: "Pointer" }, size: 55 },
    bar: { name: { ru: "Планка", en: "Bar" }, size: 63 },
    diamond: { name: { ru: "Ромб", en: "Diamond" }, size: 52 },
    paddle: { name: { ru: "Лопатка", en: "Paddle" }, size: 60 },
    deltaH: { name: { ru: "Диск с риской", en: "Marked dial" }, size: 100,
        source: "_parts/_art/deltaH/handle.svg" },
    sau: { name: { ru: "Рукоятка САУ", en: "Flight control knob" }, size: 130,
        source: "_parts/_art/sau-sdu-handle.svg" },
    guidance: { name: { ru: "Рукоятка наведения", en: "Guidance knob" }, size: 59,
        source: "_parts/_art/tksRangeOriginal/handle.svg" },
    countermeasures: { name: { ru: "Рукоятка ЛТЦ", en: "Countermeasures knob" }, size: 65,
        source: "_parts/_art/asoModeSource/handle.svg" },
    navigation: { name: { ru: "Рукоятка ПН-187", en: "PN-187 knob" }, size: 64,
        source: "_parts/_art/navModeOriginal/handle.svg" },
    radio: { name: { ru: "Ручка канала радио", en: "Radio channel knob" }, size: 55,
        source: "_parts/_art/radioChannelSource/handle.svg" },
    warning: { name: { ru: "Рукоятка СПО", en: "Warning receiver knob" }, size: 60,
        source: "_parts/_art/spoSource/handle.svg" },
    emission: { name: { ru: "Рукоятка излучения", en: "Emission knob" }, size: 148,
        source: "_parts/_art/emissionSource/handle.svg" },
    training: { name: { ru: "Рукоятка TRAIN", en: "TRAIN knob" }, size: 540 / 7,
        source: "../../Su30/Su30TrainSelector/_parts/knob.svg",
        pointerAngle: Math.atan2(7, 38) * 180 / Math.PI },
    targetType: { name: { ru: "Рукоятка TARGET TYPE", en: "TARGET TYPE knob" }, size: 43.2,
        gain: true }
}
