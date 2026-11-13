.pragma library

var redFrames = [
    "_art/red/close_lid.svg",
    "_art/red/open_lid_down.svg",
    "_art/red/open_lid_up.svg"
]

var entries = {
    "red": {
        "label": "Red",
        "width": 0,
        "height": 0,
        "frames": redFrames
    },
    "numbered": {
        "label": "Numbered",
        "width": 0,
        "height": 0,
        "frames": [
            "_art/numbered/close_lid.svg",
            "_art/numbered/open_lid_down.svg",
            "_art/numbered/open_lid_up.svg"
        ]
    },
    "long": {
        "label": "Long red guard",
        "positionThreshold": 0.5,
        "width": 157.7,
        "height": 306,
        "frames": redFrames
    },
    "compact": {
        "label": "Compact red guard",
        "positionThreshold": 0.5,
        "width": 38.8,
        "height": 84.4,
        "frames": [
            "_art/compact/closed.svg",
            "_art/compact/position_0.svg",
            "_art/compact/position_1.svg"
        ]
    }
}
