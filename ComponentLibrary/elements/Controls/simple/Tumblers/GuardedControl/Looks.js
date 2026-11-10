.pragma library

var labels = {
    "horizontal": "Horizontal cover",
    "box": "Box cover",
    "fire": "Fuel cutoff and fire button",
    "lever": "Guarded three-position lever",
    "redBar": "Red bar cover",
    "yellowSquares": "Cover with yellow squares",
    "redU": "Red U-shaped cover",
    "off": "Covered OFF button",
    "redButton": "Red covered button"
}

var entries = {
    "horizontal": {
        "conditioning": {
            "label": "CONDING OFF",
            "width": 105.0468,
            "height": 52.10026,
            "maximum": 1,
            "closed": ["_art/horizontal-conditioning/closed_0.svg", "_art/horizontal-conditioning/closed_1.svg"],
            "open": ["_art/horizontal-conditioning/open_0.svg", "_art/horizontal-conditioning/open_1.svg"],
            "regions": [{"x": 0, "y": 0.261559, "width": 0.659074, "height": 0.590632, "action": "open"}, {"x": 0.66965, "y": 0.261494, "width": 0.219687, "height": 0.590679, "action": "close"}, {"x": 0.086984, "y": 0.49114, "width": 0.29299, "height": 0.354495, "action": "switch", "state": 0}, {"x": 0.395122, "y": 0.49114, "width": 0.292949, "height": 0.3544, "action": "switch", "state": 1}]
        },
        "reheat": {
            "label": "REHEAT OFF",
            "width": 105.0468,
            "height": 52.10026,
            "maximum": 1,
            "closed": ["_art/horizontal-reheat/closed_0.svg", "_art/horizontal-reheat/closed_1.svg"],
            "open": ["_art/horizontal-reheat/open_0.svg", "_art/horizontal-reheat/open_1.svg"],
            "regions": [{"x": 0, "y": 0.261559, "width": 0.659074, "height": 0.590632, "action": "open"}, {"x": 0.66965, "y": 0.261494, "width": 0.219687, "height": 0.590679, "action": "close"}, {"x": 0.086984, "y": 0.49114, "width": 0.29299, "height": 0.354495, "action": "switch", "state": 0}, {"x": 0.395122, "y": 0.49114, "width": 0.292949, "height": 0.3544, "action": "switch", "state": 1}]
        },
        "airRelight": {
            "label": "AIR RELIGHT",
            "width": 105.0468,
            "height": 52.10026,
            "maximum": 1,
            "closed": ["_art/horizontal-airRelight/closed_0.svg", "_art/horizontal-airRelight/closed_1.svg"],
            "open": ["_art/horizontal-airRelight/open_0.svg", "_art/horizontal-airRelight/open_1.svg"],
            "regions": [{"x": 0, "y": 0.261559, "width": 0.659074, "height": 0.590632, "action": "open"}, {"x": 0.66965, "y": 0.261494, "width": 0.219687, "height": 0.590679, "action": "close"}, {"x": 0.086984, "y": 0.49114, "width": 0.29299, "height": 0.354495, "action": "switch", "state": 0}, {"x": 0.395122, "y": 0.49114, "width": 0.292949, "height": 0.3544, "action": "switch", "state": 1}]
        },
        "ass": {
            "label": "ASS OFF",
            "width": 105.0468,
            "height": 52.10026,
            "maximum": 1,
            "closed": ["_art/horizontal-ass/closed_0.svg", "_art/horizontal-ass/closed_1.svg"],
            "open": ["_art/horizontal-reheat/open_0.svg", "_art/horizontal-reheat/open_1.svg"],
            "regions": [{"x": 0, "y": 0.261559, "width": 0.659074, "height": 0.590632, "action": "open"}, {"x": 0.66965, "y": 0.261494, "width": 0.219687, "height": 0.590679, "action": "close"}, {"x": 0.086984, "y": 0.49114, "width": 0.29299, "height": 0.354495, "action": "switch", "state": 0}, {"x": 0.395122, "y": 0.49114, "width": 0.292949, "height": 0.3544, "action": "switch", "state": 1}]
        }
    },
    "box": {
        "striped": {
            "label": "Striped",
            "width": 90.66581,
            "height": 61.36625,
            "maximum": 1,
            "closed": ["_art/box-striped/closed_0.svg", "_art/box-striped/closed_0.svg"],
            "open": ["_art/box-striped/open_0.svg", "_art/box-striped/open_1.svg"],
            "regions": [{"x": 0.00017, "y": 0.180675, "width": 0.705642, "height": 0.799704, "action": "open"}, {"x": 0.723741, "y": 0.180709, "width": 0.23543, "height": 0.799038, "action": "close"}, {"x": 0.015332, "y": 0.351949, "width": 0.29416, "height": 0.434559, "action": "switch", "state": 0}, {"x": 0.335279, "y": 0.351746, "width": 0.294151, "height": 0.434559, "action": "switch", "state": 1}]
        },
        "gain": {
            "label": "GAIN MAN",
            "width": 90.66581,
            "height": 61.36625,
            "maximum": 1,
            "closed": ["_art/box-gain/closed_0.svg", "_art/box-gain/closed_0.svg"],
            "open": ["_art/box-gain/open_0.svg", "_art/box-gain/open_1.svg"],
            "regions": [{"x": 0.00017, "y": 0.180675, "width": 0.705642, "height": 0.799704, "action": "open"}, {"x": 0.723741, "y": 0.180709, "width": 0.23543, "height": 0.799038, "action": "close"}, {"x": 0.015332, "y": 0.351949, "width": 0.29416, "height": 0.434559, "action": "switch", "state": 0}, {"x": 0.335279, "y": 0.351746, "width": 0.294151, "height": 0.434559, "action": "switch", "state": 1}]
        }
    },
    "fire": {
        "left": {
            "label": "LH ENG FIRE",
            "width": 103.55931,
            "height": 84.87585,
            "maximum": 1,
            "closed": ["_art/fire-left/closed_0.svg", "_art/fire-left/closed_1.svg"],
            "open": ["_art/fire-left/open_0.svg", "_art/fire-left/open_1.svg"],
            "regions": [{"x": 0, "y": 0.5439964, "width": 0.6686729, "height": 0.398883, "action": "open"}, {"x": 0.6794026, "y": 0.5439565, "width": 0.222886, "height": 0.3989193, "action": "close"}, {"x": 0.0882509, "y": 0.6875793, "width": 0.2972567, "height": 0.2176464, "action": "switch", "state": 0}, {"x": 0.4008768, "y": 0.6875793, "width": 0.297215, "height": 0.2175884, "action": "switch", "state": 1}],
            "preview": "_art/fire-left/preview.svg",
            "fire": [0.10693103, 0.23899164, 0.22587665, 0.27559819, 89.995703]
        },
        "right": {
            "label": "RH ENG FIRE",
            "width": 109.73839,
            "height": 88.731045,
            "maximum": 1,
            "closed": ["_art/fire-right/closed_0.svg", "_art/fire-right/closed_1.svg"],
            "open": ["_art/fire-right/open_0.svg", "_art/fire-right/open_1.svg"],
            "regions": [{"x": 0, "y": 0.1873454, "width": 0.6310217, "height": 0.3815523, "action": "open"}, {"x": 0.6411472, "y": 0.1873073, "width": 0.2103359, "height": 0.381587, "action": "close"}, {"x": 0.0832817, "y": 0.32469, "width": 0.2805189, "height": 0.2081901, "action": "switch", "state": 0}, {"x": 0.3783045, "y": 0.32469, "width": 0.2804796, "height": 0.2081346, "action": "switch", "state": 1}],
            "preview": "_art/fire-right/preview.svg",
            "fire": [0.10848312, 0.6399339, 0.21315812, 0.26362397, 89.995703]
        }
    },
    "lever": {
        "default": {
            "label": "Leading edge",
            "width": 93.26674,
            "height": 81.96561,
            "maximum": 2,
            "closed": ["_art/lever-default/closed_0.svg", "_art/lever-default/closed_1.svg", "_art/lever-default/closed_2.svg"],
            "open": ["_art/lever-default/open_0.svg", "_art/lever-default/open_1.svg", "_art/lever-default/open_2.svg"],
            "regions": [{"x": 0.293908, "y": 0.28589, "width": 0.418385, "height": 0.713897, "action": "open"}, {"x": 0.293684, "y": 0.036592, "width": 0.418241, "height": 0.2381, "action": "close"}, {"x": 0.000178, "y": 0.310269, "width": 0.323432, "height": 0.352374, "action": "switch", "state": 0}, {"x": 0.676421, "y": 0.309727, "width": 0.323432, "height": 0.352374, "action": "switch", "state": 1}, {"x": 0.338299, "y": 0.309998, "width": 0.323432, "height": 0.352374, "action": "switch", "state": 2}]
        }
    },
    "redBar": {
        "default": {
            "label": "Red bar",
            "width": 38.788555,
            "height": 112.64542,
            "maximum": 1,
            "closed": ["_art/redBar-default/closed_0.svg", "_art/redBar-default/closed_0.svg"],
            "open": ["_art/redBar-default/open_0.svg", "_art/redBar-default/open_1.svg"],
            "regions": [{"x": 0.121426, "y": 0.3040401, "width": 0.7114938, "height": 0.6959146, "action": "open", "state": 0}, {"x": 0.121426, "y": 0.1285277, "width": 0.7113569, "height": 0.1632231, "action": "close", "state": 0}],
            "button": [0.0, 0.4687762, 0.9543732, 0.3287592]
        }
    },
    "yellowSquares": {
        "default": {
            "label": "Yellow squares",
            "width": 36.002565,
            "height": 86.426485,
            "maximum": 1,
            "closed": ["_art/yellowSquares-default/closed_0.svg", "_art/yellowSquares-default/closed_0.svg"],
            "open": ["_art/yellowSquares-default/open_0.svg", "_art/yellowSquares-default/open_1.svg"],
            "regions": [{"x": 0.0, "y": 0.2814508, "width": 0.9999135, "height": 0.7185306, "action": "open", "state": 0}, {"x": 0.0, "y": 0.0090204, "width": 1.0, "height": 0.2499136, "action": "close", "state": 0}, {"x": 0.140401, "y": 0.4824629, "width": 0.7499517, "height": 0.2061849, "action": "set", "state": 0}, {"x": 0.140401, "y": 0.2613612, "width": 0.7499974, "height": 0.2061785, "action": "set", "state": 1}]
        }
    },
    "redU": {
        "default": {
            "label": "Red U-shaped guard",
            "width": 51.348991,
            "height": 87.86101,
            "maximum": 1,
            "closed": ["_art/redU-default/closed_0.svg", "_art/redU-default/closed_1.svg"],
            "open": ["_art/redU-default/open_0.svg", "_art/redU-default/open_1.svg"],
            "regions": [{"x": 0.014918, "y": 0.3502608, "width": 0.8303482, "height": 0.6402994, "action": "open", "state": 0}, {"x": 0.0151666, "y": 0.1205491, "width": 0.8301874, "height": 0.2134302, "action": "close", "state": 0}, {"x": 0.1335051, "y": 0.6769072, "width": 0.6107127, "height": 0.2824789, "action": "set", "state": 0}, {"x": 0.1332565, "y": 0.3867411, "width": 0.6107127, "height": 0.2824789, "action": "set", "state": 1}]
        }
    },
    "off": {
        "default": {
            "label": "OFF",
            "width": 76.876482,
            "height": 77.604381,
            "maximum": 1,
            "closed": ["_art/off-default/closed_0.svg", "_art/off-default/closed_0.svg"],
            "open": ["_art/off-default/open_0.svg", "_art/off-default/open_1.svg"],
            "regions": [{"x": 0.31132187206734185, "y": 0.09183610585623345, "width": 0.687725927406999, "height": 0.8375006958867091, "action": "open"}, {"x": 0.03332335364119536, "y": 0.09190034358022826, "width": 0.25376196580296906, "height": 0.8375892645455639, "action": "close"}],
            "button": [0.4745431, 0.43303639, 0.39235458, 0.38867444]
        }
    },
    "redButton": {
        "default": {
            "label": "Red covered button",
            "width": 45.612061,
            "height": 83.669995,
            "maximum": 1,
            "closed": ["_art/redButton-default/closed_0.svg", "_art/redButton-default/closed_0.svg"],
            "open": ["_art/redButton-default/open_0.svg", "_art/redButton-default/open_1.svg"],
            "regions": [{"x": 0.01710526315789475, "y": 0.33142944191965085, "width": 0.9274573280736843, "height": 0.6685086020141793, "action": "open"}, {"x": 0.017434210526315806, "y": 0.09184570078167606, "width": 0.927284654394737, "height": 0.2228332354344301, "action": "close"}],
            "button": [0.1309172, 0.42446615, 0.66579718, 0.36793736]
        }
    }
}
