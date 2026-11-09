.pragma library

var artwork = {
    "channelBar": {
        "label": "Channel dial with bar",
        "source": "_art/channelBar/body.svg"
    },
    "broadPaddle": {
        "label": "Broad paddle",
        "source": "_art/broadPaddle/body.svg"
    },
    "twoSided": {
        "label": "Two-sided pointer",
        "source": "_art/twoSided/body.svg"
    },
    "narrowPointer": {
        "label": "Narrow pointer",
        "source": "_art/narrowPointer/body.svg"
    },
    "offsetPaddle": {
        "label": "Offset paddle",
        "source": "_art/offsetPaddle/body.svg"
    },
    "markedPaddle": {
        "label": "Paddle with white stripe",
        "source": "_art/markedPaddle/body.svg"
    },
    "roundedPaddle": {
        "label": "Rounded paddle",
        "source": "_art/roundedPaddle/body.svg"
    }
}

var entries = {
    "r862Channel": {
        "label": "R-862 channel · 20 positions",
        "width": 108.3199,
        "height": 108.3199,
        "appearance": "channelBar",
        "angles": [18.0, 36.0, 54.0, 72.0, 90.0, 108.0, 126.0, 144.0, 162.0, 180.0, 198.0, 216.0, 234.0, 252.0, 270.0, 288.0, 306.0, 324.0, 342.0, 360.0],
        "bodyRect": [0, 0, 1, 1],
        "regions": [],
        "stretch": false,
        "preview": "_art/r862Channel/preview.svg"
    },
    "arkChannel": {
        "label": "ARK channel · 9 positions",
        "width": 82.136165,
        "height": 100.42437,
        "appearance": "narrowPointer",
        "angles": [-210, -180, -150, -120, -90, -60, -30, 0, 30],
        "bodyRect": [0.3774406, 0.1679241, 0.4053872, 0.7993344],
        "regions": [[0.7189281, 0.8508891, 0.1828837, 0.1491109], [0.444384, 0.8508891, 0.1828837, 0.1486125], [0.2027122, 0.811556, 0.1828837, 0.1486125], [0.0523521, 0.6945526, 0.1828837, 0.1486125], [0.0, 0.4929083, 0.1828837, 0.1486125], [0.0767019, 0.2952471, 0.1828837, 0.1486125], [0.2288882, 0.1553408, 0.1828837, 0.1486125], [0.5521319, 0.0512824, 0.1828837, 0.1486125], [0.7432779, 0.0, 0.1828837, 0.2348068]],
        "stretch": true,
        "preview": "_art/arkChannel/preview.svg"
    },
    "asoMode": {
        "label": "ASO mode · 4 positions",
        "width": 96.515647,
        "height": 96.93915,
        "appearance": "roundedPaddle",
        "angles": [-120, -90, -60, -30],
        "bodyRect": [0.240864, 0.0, 0.4621603, 0.9485023],
        "regions": [[0.031083, 0.6645767, 0.3108431, 0.154774], [0.0, 0.4169987, 0.1554215, 0.154774], [0.0414441, 0.173547, 0.1554215, 0.154774], [0.1864983, 0.020874, 0.1554215, 0.154774]],
        "stretch": true,
        "preview": "_art/asoMode/preview.svg"
    },
    "asoReg": {
        "label": "ASO program · 9 positions",
        "width": 108.81354,
        "height": 102.41354,
        "appearance": "roundedPaddle",
        "angles": [-120, -90, -60, -30, 0, 30, 60, 90, 120],
        "bodyRect": [0.3261089, 0.0525142, 0.4101499, 0.898745],
        "regions": [[0.0298676, 0.6752037, 0.3198282, 0.1465008], [0.0, 0.4564826, 0.3198282, 0.1465008], [0.1176324, 0.2084685, 0.1378561, 0.1465008], [0.2462929, 0.040522, 0.1378561, 0.1465008], [0.4572041, 0.0, 0.1378561, 0.1465008], [0.6520328, 0.0678621, 0.1378561, 0.1465008], [0.7650702, 0.2348322, 0.1378561, 0.1465008], [0.7871263, 0.4179135, 0.1378561, 0.1465008], [0.7650702, 0.6009948, 0.1378561, 0.1465008]],
        "stretch": true,
        "preview": "_art/asoReg/preview.svg"
    },
    "emission": {
        "label": "Emission · 3 positions",
        "width": 112.96247,
        "height": 78.772689,
        "appearance": "offsetPaddle",
        "angles": [-60, -90, -120],
        "bodyRect": [0.3959543, 0.0786552, 0.4660314, 0.8429146],
        "regions": [[0.2921324, 0.075473, 0.1416378, 0.2793094], [0.0, 0.2265405, 0.1416378, 0.4568841], [0.2921324, 0.6848212, 0.1416378, 0.2031207]],
        "stretch": true,
        "preview": "_art/emission/preview.svg"
    },
    "navMode": {
        "label": "Navigation mode · 7 positions",
        "width": 106.49207,
        "height": 111.23096,
        "appearance": "twoSided",
        "angles": [-90, -125, -155, -170, 131, 90, 45],
        "bodyRect": [0.2999033, 0.0070154, 0.3871213, 0.8499372],
        "regions": [[0.0, 0.1676692, 0.1407811, 0.5102699], [0.1079893, 0.5511056, 0.1407811, 0.2627952], [0.2676256, 0.6922533, 0.1407811, 0.2627952], [0.4929945, 0.7372048, 0.1407811, 0.2627952], [0.7183634, 0.6041484, 0.2158628, 0.2627952], [0.8592189, 0.0, 0.1407811, 0.2627952], [0.6948875, 0.0, 0.1407811, 0.2627952]],
        "stretch": true,
        "preview": "_art/navMode/preview.svg"
    },
    "sauHeight": {
        "label": "SAU height · 5 positions",
        "width": 74.384879,
        "height": 92.702943,
        "appearance": "narrowPointer",
        "angles": [-150, -120, -90, -60, -30],
        "bodyRect": [0.3838351, 0.0317896, 0.4476306, 0.8659126],
        "regions": [[0.2554283, 0.8369024, 0.1742153, 0.1630976], [0.0457082, 0.640037, 0.1742153, 0.1630976], [0.0, 0.4215973, 0.1742153, 0.1630976], [0.059824, 0.1600091, 0.1742153, 0.1630976], [0.2547561, 0.0062923, 0.1742153, 0.1630976]],
        "stretch": true,
        "preview": "_art/sauHeight/preview.svg"
    },
    "sauMode": {
        "label": "SAU mode · 4 positions",
        "width": 72.729236,
        "height": 99.359156,
        "appearance": "narrowPointer",
        "angles": [-140, -110, -70, -40],
        "bodyRect": [0.3815732, 0.0912213, 0.4578207, 0.8079039],
        "regions": [[0.1374963, 0.760876, 0.1781812, 0.239124], [0.0, 0.5072507, 0.1781812, 0.239124], [0.0, 0.2536253, 0.1781812, 0.239124], [0.1374963, 0.0, 0.1781812, 0.239124]],
        "stretch": true,
        "preview": "_art/sauMode/preview.svg"
    },
    "spoMode": {
        "label": "SPO mode · 11 positions",
        "width": 129.49064,
        "height": 129.49064,
        "appearance": "broadPaddle",
        "angles": [-240, -210, -180, -150, -120, -90, -60, -30, 0, 30, 60],
        "bodyRect": [0.1339746, 0.1339746, 0.7320508, 0.7320508],
        "regions": [[0.7413302, 0.5810869, 0.1235592, 0.1158385], [0.6154524, 0.7158457, 0.1235592, 0.1158385], [0.4617733, 0.7652701, 0.1235592, 0.1158385], [0.2864711, 0.728588, 0.1235592, 0.1158385], [0.16291, 0.6127495, 0.1235592, 0.1158385], [0.1250694, 0.4409224, 0.1235592, 0.1158385], [0.1409007, 0.283382, 0.1235592, 0.1158385], [0.2644617, 0.1613655, 0.1235592, 0.1158385], [0.4443975, 0.1215943, 0.1235592, 0.1158385], [0.6154524, 0.1459204, 0.1235592, 0.1158385], [0.7390134, 0.277204, 0.1235592, 0.1158385]],
        "stretch": true,
        "preview": "_art/spoMode/preview.svg"
    },
    "sroRequest": {
        "label": "SRO request · 4 positions",
        "width": 69.076196,
        "height": 74.699275,
        "appearance": "narrowPointer",
        "angles": [-50, -20, 20, 50],
        "bodyRect": [0.2990811, 0.1044284, 0.4017216, 0.8955716],
        "regions": [[0.0851825, 0.1285153, 0.2170985, 0.2008378], [0.3139154, 0.0, 0.2170985, 0.2008378], [0.5426483, 0.0, 0.2170985, 0.2008378], [0.7713812, 0.1285153, 0.2170985, 0.2008378]],
        "stretch": true,
        "preview": "_art/sroRequest/preview.svg"
    },
    "srzo": {
        "label": "SRZO · 4 positions",
        "width": 85.151557,
        "height": 70.340369,
        "appearance": "markedPaddle",
        "angles": [15, 45, 72, 120],
        "bodyRect": [0.2542343, 0.3449259, 0.7457657, 0.4432102],
        "regions": [[0.0, 0.329114, 0.352227, 0.2132835], [0.1914234, 0.1343468, 0.234818, 0.2132835], [0.4063343, 0.0, 0.234818, 0.2132835], [0.6911207, 0.0, 0.234818, 0.2132835]],
        "stretch": true,
        "preview": "_art/srzo/preview.svg"
    },
    "tksMode": {
        "label": "TKS mode · 4 positions",
        "width": 96.739802,
        "height": 96.818891,
        "appearance": "markedPaddle",
        "angles": [-30, 0, 30, 60],
        "bodyRect": [0.2342386, 0.4448037, 0.7657614, 0.3756416],
        "regions": [[0.0542693, 0.7741258, 0.1552949, 0.1550923], [0.0, 0.5417331, 0.1552949, 0.155023], [0.0527187, 0.1368535, 0.1553075, 0.3336862], [0.2243131, 0.0, 0.1548469, 0.3033385]],
        "stretch": true,
        "preview": "_art/tksMode/preview.svg"
    },
    "tksRange": {
        "label": "TKS range · 3 positions",
        "width": 103.4898,
        "height": 103.552,
        "appearance": "markedPaddle",
        "angles": [-30, 0, 30],
        "bodyRect": [0.2841845, 0.398026, 0.7158155, 0.3511976],
        "regions": [[0.1304476, 0.7749729, 0.1306576, 0.2250271], [0.0, 0.3375116, 0.1306576, 0.4675892], [0.1328633, 0.0, 0.1451777, 0.5326902]],
        "stretch": true,
        "preview": "_art/tksRange/preview.svg"
    }
}
