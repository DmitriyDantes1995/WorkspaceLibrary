import QtQuick 2.15

Item {
    id: root

    property string componentPath: ""

    property string my_type: ""
    property string my_subtype: ""
    property string my_id: ""
    property string my_steps: ""
    property string propertyObj: ""
    property string previewSource: ""
    property var customProperties: ({})
    property var propertySchema: ({})

    // Scene stacking contract. userZ is the value edited and serialized by
    // scene hosts; z is the deterministic visual value used by Qt Quick.
    // The type/subtype fallback keeps panels generated before sceneLayer was
    // introduced on the background layer.
    property string sceneLayer: (my_type === "Substrate"
                                 || my_subtype === "ContourPanel")
                                ? "background" : "content"
    readonly property real baseLayerZ: sceneLayer === "background" ? -100 : 0
    property real userZ: 0
    z: baseLayerZ + userZ

    // Host-facing interaction contract. Components emit this explicitly only
    // from user gesture handlers; programmatic property updates stay silent.
    signal userPropertyChanged(string propertyName, var value)

    property bool locked: false
    property bool preserveAspectRatio: false
    property real preservedAspectRatio: 0

    // Transient editor state. These properties are deliberately not included
    // in customProperties and therefore never become part of a saved scene.
    property bool supportsGaugeCalibration: false
    property bool editorCalibrationActive: false
    property real editorCalibrationAngle: 0
    property string editorCalibrationChannelId: ""
    property bool gaugeInstanceOverride: false
    property bool gaugeComponentProfileAvailable: false
    property string gaugeScaleSource: "Legacy Default"
    property var gaugeLegacyProfile: null
    // Optional descriptors for multi-needle gauges. An empty list preserves
    // the original single-channel value/valueMappingPoints contract.
    property var gaugeCalibrationChannels: []
    property real gaugeCalibrationCenterX: width / 2
    property real gaugeCalibrationCenterY: height / 2
    // atan2 is 0 degrees to the right. A conventional upward-pointing needle
    // uses +90 so a mouse position above the pivot produces rotation 0.
    property real gaugeCalibrationAngleOffset: 90

    function capturePreservedAspectRatio() {
        if (preserveAspectRatio && preservedAspectRatio <= 0 && height > 0)
            preservedAspectRatio = width / height
    }

    Component.onCompleted: Qt.callLater(capturePreservedAspectRatio)
    onWidthChanged: {
        if (preserveAspectRatio && preservedAspectRatio <= 0)
            Qt.callLater(capturePreservedAspectRatio)
    }
    onHeightChanged: {
        if (preserveAspectRatio && preservedAspectRatio <= 0)
            Qt.callLater(capturePreservedAspectRatio)
    }

    function setCustomProperty(name, value) {
        customProperties[name] = value

        if (root.hasOwnProperty(name)) {
            root[name] = value
        }
    }

    function mapLinearValue(value, inputMin, inputMax,
                            outputMin, outputMax, clamp) {
        var numericValue = Number(value)
        var numericInputMin = Number(inputMin)
        var numericInputMax = Number(inputMax)
        var numericOutputMin = Number(outputMin)
        var numericOutputMax = Number(outputMax)

        if (!isFinite(numericValue) || !isFinite(numericInputMin)
                || !isFinite(numericInputMax) || !isFinite(numericOutputMin)
                || !isFinite(numericOutputMax))
            return 0

        var inputSpan = numericInputMax - numericInputMin
        if (inputSpan === 0)
            return numericOutputMin

        var position = (numericValue - numericInputMin) / inputSpan
        if (clamp === true)
            position = Math.max(0, Math.min(1, position))

        return numericOutputMin
                + position * (numericOutputMax - numericOutputMin)
    }

    // Preferred point format is { input, output }. The legacy
    // { value, visual } format remains supported. Invalid points are ignored,
    // duplicate inputs use the last point, and a sorted copy is used so QML
    // property arrays are never mutated by a binding evaluation.
    function mapValueByPoints(value, points, clamp) {
        if (!points || points.length === 0)
            return 0

        function pointValue(point) {
            if (!point)
                return NaN
            return Number(point.input !== undefined ? point.input : point.value)
        }
        function pointVisual(point) {
            if (!point)
                return NaN
            return Number(point.output !== undefined ? point.output : point.visual)
        }
        function interpolate(numericValue, first, second) {
            var firstValue = pointValue(first)
            var secondValue = pointValue(second)
            var firstVisual = pointVisual(first)
            var secondVisual = pointVisual(second)
            if (!isFinite(firstValue) || !isFinite(secondValue)
                    || !isFinite(firstVisual) || !isFinite(secondVisual))
                return 0
            if (firstValue === secondValue)
                return secondVisual
            return firstVisual + (numericValue - firstValue)
                    / (secondValue - firstValue)
                    * (secondVisual - firstVisual)
        }

        var normalized = []
        for (var sourceIndex = 0; sourceIndex < points.length; sourceIndex++) {
            var sourcePoint = points[sourceIndex]
            var sourceValue = pointValue(sourcePoint)
            var sourceVisual = pointVisual(sourcePoint)
            if (isFinite(sourceValue) && isFinite(sourceVisual))
                normalized.push({ value: sourceValue, visual: sourceVisual,
                                  order: sourceIndex })
        }
        normalized.sort(function(firstPoint, secondPoint) {
            if (firstPoint.value === secondPoint.value)
                return firstPoint.order - secondPoint.order
            return firstPoint.value - secondPoint.value
        })

        var unique = []
        for (var normalizedIndex = 0; normalizedIndex < normalized.length;
             normalizedIndex++) {
            var normalizedPoint = normalized[normalizedIndex]
            if (unique.length > 0
                    && unique[unique.length - 1].value === normalizedPoint.value)
                unique[unique.length - 1] = normalizedPoint
            else
                unique.push(normalizedPoint)
        }
        if (unique.length === 0)
            return 0

        var numericValue = Number(value)
        var first = unique[0]
        var last = unique[unique.length - 1]
        var firstValue = pointValue(first)
        var lastValue = pointValue(last)
        var firstVisual = pointVisual(first)
        var lastVisual = pointVisual(last)

        if (!isFinite(numericValue) || !isFinite(firstValue)
                || !isFinite(lastValue) || !isFinite(firstVisual)
                || !isFinite(lastVisual))
            return 0
        if (unique.length === 1)
            return firstVisual

        if (numericValue <= firstValue) {
            if (clamp === true)
                return firstVisual
            for (var lowIndex = 1; lowIndex < unique.length; lowIndex++) {
                if (pointValue(unique[lowIndex]) !== firstValue)
                    return interpolate(numericValue, first, unique[lowIndex])
            }
            return firstVisual
        }

        if (numericValue >= lastValue) {
            if (clamp === true)
                return lastVisual
            for (var highIndex = unique.length - 2; highIndex >= 0; highIndex--) {
                if (pointValue(unique[highIndex]) !== lastValue)
                    return interpolate(numericValue, unique[highIndex], last)
            }
            return lastVisual
        }

        for (var index = 0; index < unique.length - 1; index++) {
            var left = unique[index]
            var right = unique[index + 1]
            if (numericValue <= pointValue(right))
                return interpolate(numericValue, left, right)
        }

        return lastVisual
    }

    // Gauge outputs are angles. Build a sorted, local continuous copy before
    // using the generic piecewise mapper; the saved calibration points remain
    // untouched. Set preserveAngularDelta on a point when a segment is
    // intentionally meant to travel more than 180 degrees.
    function continuousGaugeMappingPoints(points) {
        if (!points || points.length === 0)
            return []

        var normalized = []
        for (var sourceIndex = 0; sourceIndex < points.length; sourceIndex++) {
            var sourcePoint = points[sourceIndex]
            if (!sourcePoint)
                continue
            var sourceValue = Number(sourcePoint.input !== undefined
                                     ? sourcePoint.input : sourcePoint.value)
            var sourceAngle = Number(sourcePoint.output !== undefined
                                     ? sourcePoint.output : sourcePoint.visual)
            if (isFinite(sourceValue) && isFinite(sourceAngle)) {
                normalized.push({ input: sourceValue, output: sourceAngle,
                                  order: sourceIndex,
                                  preserveAngularDelta:
                                      sourcePoint.preserveAngularDelta === true })
            }
        }
        normalized.sort(function(firstPoint, secondPoint) {
            if (firstPoint.input === secondPoint.input)
                return firstPoint.order - secondPoint.order
            return firstPoint.input - secondPoint.input
        })

        var unique = []
        for (var normalizedIndex = 0; normalizedIndex < normalized.length;
             normalizedIndex++) {
            var normalizedPoint = normalized[normalizedIndex]
            if (unique.length > 0
                    && unique[unique.length - 1].input === normalizedPoint.input)
                unique[unique.length - 1] = normalizedPoint
            else
                unique.push(normalizedPoint)
        }
        if (unique.length === 0)
            return []

        var firstContinuous = { input: unique[0].input,
                                output: unique[0].output }
        if (unique[0].preserveAngularDelta)
            firstContinuous.preserveAngularDelta = true
        var continuous = [firstContinuous]
        for (var index = 1; index < unique.length; index++) {
            var point = unique[index]
            var angle = point.output
            var previousAngle = continuous[index - 1].output
            if (!point.preserveAngularDelta) {
                while (angle - previousAngle > 180)
                    angle -= 360
                while (angle - previousAngle < -180)
                    angle += 360
            }
            var continuousPoint = { input: point.input, output: angle }
            if (point.preserveAngularDelta)
                continuousPoint.preserveAngularDelta = true
            continuous.push(continuousPoint)
        }

        return continuous
    }

    function mapAngleByPoints(value, points, clamp) {
        return mapValueByPoints(
                    value, continuousGaugeMappingPoints(points), clamp)
    }

    function mapGaugeValue(value, mode, points, inputMin, inputMax,
                           outputMin, outputMax, clamp) {
        if (String(mode) === "ByPoints")
            return mapAngleByPoints(value, points, clamp)
        return mapLinearValue(value, inputMin, inputMax,
                              outputMin, outputMax, clamp)
    }

    function gaugeCalibrationChannel(channelId) {
        var requestedId = String(channelId || editorCalibrationChannelId || "")
        for (var index = 0; gaugeCalibrationChannels
             && index < gaugeCalibrationChannels.length; index++) {
            var channel = gaugeCalibrationChannels[index]
            if (channel && String(channel.id) === requestedId)
                return channel
        }
        return null
    }

    function gaugeChannelPropertyName(channelId, descriptorKey,
                                      singleChannelName) {
        var channel = gaugeCalibrationChannel(channelId)
        return channel && channel[descriptorKey]
                ? String(channel[descriptorKey]) : singleChannelName
    }

    function gaugeChannelPropertyValue(channelId, descriptorKey,
                                       singleChannelName, fallbackValue) {
        var propertyName = gaugeChannelPropertyName(
                    channelId, descriptorKey, singleChannelName)
        return propertyName && root.hasOwnProperty(propertyName)
                ? root[propertyName] : fallbackValue
    }

    function gaugeCalibrationModeForChannel(channelId) {
        return String(gaugeChannelPropertyValue(
                          channelId, "mappingModeProperty",
                          "valueMappingMode", "Linear"))
    }

    function gaugeCalibrationValueForChannel(channelId) {
        return Number(gaugeChannelPropertyValue(
                          channelId, "valueProperty", "value", 0))
    }

    function gaugeCalibrationPointsPropertyForChannel(channelId) {
        return gaugeChannelPropertyName(
                    channelId, "pointsProperty", "valueMappingPoints")
    }

    function gaugeProfileChannelDescriptors() {
        if (gaugeCalibrationChannels && gaugeCalibrationChannels.length > 0)
            return gaugeCalibrationChannels
        return [{ id: "value",
                  mappingModeProperty: "valueMappingMode",
                  inputMinProperty: "inputMin",
                  inputMaxProperty: "inputMax",
                  outputMinProperty: "outputMinAngle",
                  outputMaxProperty: "outputMaxAngle",
                  pointsProperty: "valueMappingPoints" }]
    }

    function gaugeMappingPropertyNames() {
        var names = []
        var descriptors = gaugeProfileChannelDescriptors()
        var descriptorKeys = ["mappingModeProperty", "inputMinProperty",
                              "inputMaxProperty", "outputMinProperty",
                              "outputMaxProperty", "pointsProperty"]
        for (var channelIndex = 0; channelIndex < descriptors.length;
             channelIndex++) {
            var descriptor = descriptors[channelIndex] || ({})
            for (var keyIndex = 0; keyIndex < descriptorKeys.length;
                 keyIndex++) {
                var name = descriptor[descriptorKeys[keyIndex]]
                if (name && names.indexOf(String(name)) < 0)
                    names.push(String(name))
            }
        }
        return names
    }

    function isGaugeMappingProperty(propertyName) {
        return supportsGaugeCalibration
                && gaugeMappingPropertyNames().indexOf(String(propertyName)) >= 0
    }

    function gaugeProfileData(unwrapAngles) {
        var channels = ({})
        var descriptors = gaugeProfileChannelDescriptors()
        for (var index = 0; index < descriptors.length; index++) {
            var descriptor = descriptors[index] || ({})
            var channelId = String(descriptor.id || "value")
            var points = gaugeChannelPropertyValue(
                        channelId, "pointsProperty", "valueMappingPoints", [])
            channels[channelId] = {
                "mappingMode": String(gaugeChannelPropertyValue(
                    channelId, "mappingModeProperty", "valueMappingMode",
                    "Linear")),
                "inputMin": Number(gaugeChannelPropertyValue(
                    channelId, "inputMinProperty", "inputMin", 0)),
                "inputMax": Number(gaugeChannelPropertyValue(
                    channelId, "inputMaxProperty", "inputMax", 360)),
                "outputMinAngle": Number(gaugeChannelPropertyValue(
                    channelId, "outputMinProperty", "outputMinAngle", 0)),
                "outputMaxAngle": Number(gaugeChannelPropertyValue(
                    channelId, "outputMaxProperty", "outputMaxAngle", 360)),
                "mappingPoints": unwrapAngles === false
                    ? points : continuousGaugeMappingPoints(points)
            }
        }
        return { "version": 1, "channels": channels }
    }

    function gaugeComponentProfileData() {
        return gaugeProfileData(true)
    }

    function captureGaugeLegacyProfile() {
        gaugeLegacyProfile = gaugeProfileData(false)
        return gaugeLegacyProfile
    }

    function applyGaugeProfileProperty(channelId, descriptorKey,
                                       fallbackName, value) {
        var propertyName = gaugeChannelPropertyName(
                    channelId, descriptorKey, fallbackName)
        if (!propertyName || !root.hasOwnProperty(propertyName))
            return
        root[propertyName] = value
        if (customProperties && customProperties.hasOwnProperty(propertyName))
            customProperties[propertyName] = value
    }

    function applyGaugeComponentProfile(profile) {
        if (!supportsGaugeCalibration || !profile || !profile.channels)
            return false
        var applied = false
        var descriptors = gaugeProfileChannelDescriptors()
        for (var index = 0; index < descriptors.length; index++) {
            var descriptor = descriptors[index] || ({})
            var channelId = String(descriptor.id || "value")
            var channel = profile.channels[channelId]
            if (!channel)
                continue
            if (channel.mappingMode !== undefined)
                applyGaugeProfileProperty(channelId, "mappingModeProperty",
                                          "valueMappingMode",
                                          String(channel.mappingMode))
            if (channel.inputMin !== undefined)
                applyGaugeProfileProperty(channelId, "inputMinProperty",
                                          "inputMin", Number(channel.inputMin))
            if (channel.inputMax !== undefined)
                applyGaugeProfileProperty(channelId, "inputMaxProperty",
                                          "inputMax", Number(channel.inputMax))
            if (channel.outputMinAngle !== undefined)
                applyGaugeProfileProperty(channelId, "outputMinProperty",
                                          "outputMinAngle",
                                          Number(channel.outputMinAngle))
            if (channel.outputMaxAngle !== undefined)
                applyGaugeProfileProperty(channelId, "outputMaxProperty",
                                          "outputMaxAngle",
                                          Number(channel.outputMaxAngle))
            if (channel.mappingPoints !== undefined)
                applyGaugeProfileProperty(channelId, "pointsProperty",
                                          "valueMappingPoints",
                                          channel.mappingPoints)
            applied = true
        }
        return applied
    }

    function setGaugeScaleState(source, hasProfile, isOverride) {
        gaugeScaleSource = String(source || "Legacy Default")
        gaugeComponentProfileAvailable = hasProfile === true
        gaugeInstanceOverride = isOverride === true
    }

    function mapGaugeChannelValue(channelId) {
        return mapGaugeValue(
                    gaugeCalibrationValueForChannel(channelId),
                    gaugeCalibrationModeForChannel(channelId),
                    gaugeChannelPropertyValue(channelId, "pointsProperty",
                                              "valueMappingPoints", []),
                    gaugeChannelPropertyValue(channelId, "inputMinProperty",
                                              "inputMin", 0),
                    gaugeChannelPropertyValue(channelId, "inputMaxProperty",
                                              "inputMax", 360),
                    gaugeChannelPropertyValue(channelId, "outputMinProperty",
                                              "outputMinAngle", 0),
                    gaugeChannelPropertyValue(channelId, "outputMaxProperty",
                                              "outputMaxAngle", 360), true)
    }

    function gaugeNeedleVisualAngle(channelId) {
        return editorCalibrationActive
                && String(editorCalibrationChannelId) === String(channelId || "")
                ? editorCalibrationAngle : mapGaugeChannelValue(channelId)
    }

    function gaugeCalibrationAngleFromPoint(localX, localY, channelId) {
        var channel = gaugeCalibrationChannel(channelId)
        var centerX = channel && isFinite(Number(channel.centerX))
                ? Number(channel.centerX) : gaugeCalibrationCenterX
        var centerY = channel && isFinite(Number(channel.centerY))
                ? Number(channel.centerY) : gaugeCalibrationCenterY
        var angleOffset = channel && isFinite(Number(channel.angleOffset))
                ? Number(channel.angleOffset) : gaugeCalibrationAngleOffset
        var deltaX = Number(localX) - centerX
        var deltaY = Number(localY) - centerY
        if (!isFinite(deltaX) || !isFinite(deltaY)
                || (deltaX === 0 && deltaY === 0))
            return editorCalibrationAngle
        return Math.atan2(deltaY, deltaX) * 180 / Math.PI
                + angleOffset
    }

    function gaugeCalibrationAngleForValue(inputValue, channelId) {
        var numericInput = Number(inputValue)
        if (!isFinite(numericInput))
            return 0
        var points = gaugeChannelPropertyValue(
                    channelId, "pointsProperty", "valueMappingPoints", [])
        var exactOutput = NaN
        for (var index = 0; points && index < points.length; index++) {
            var pointInput = Number(points[index].input)
            var pointOutput = Number(points[index].output)
            if (isFinite(pointInput)
                    && isFinite(pointOutput)
                    && Math.abs(pointInput - numericInput) <= 0.000000001)
                exactOutput = pointOutput
        }
        if (isFinite(exactOutput))
            return exactOutput
        return mapAngleByPoints(numericInput, points, true)
    }

    function beginGaugeCalibration(inputValue, channelId) {
        if (!supportsGaugeCalibration)
            return false
        var channel = gaugeCalibrationChannel(channelId)
        editorCalibrationChannelId = channel ? String(channel.id) : ""
        editorCalibrationAngle = gaugeCalibrationAngleForValue(
                    inputValue, editorCalibrationChannelId)
        editorCalibrationActive = true
        return true
    }

    function cancelGaugeCalibration() {
        editorCalibrationActive = false
        editorCalibrationChannelId = ""
    }

    function gaugeCalibrationPointsWithPoint(inputValue, outputAngle, channelId) {
        var numericInput = Number(inputValue)
        var numericOutput = Number(outputAngle)
        if (!isFinite(numericInput) || !isFinite(numericOutput))
            return null

        var source = gaugeChannelPropertyValue(
                    channelId, "pointsProperty", "valueMappingPoints", [])
        var result = []
        var updated = false
        function calibrationPoint(input, output, preserveAngularDelta) {
            var resultPoint = { input: input, output: output }
            if (preserveAngularDelta === true)
                resultPoint.preserveAngularDelta = true
            return resultPoint
        }
        for (var index = 0; source && index < source.length; index++) {
            var point = source[index] || ({})
            var pointInput = Number(point.input)
            var pointOutput = Number(point.output)
            if (!isFinite(pointInput) || !isFinite(pointOutput))
                continue
            if (Math.abs(pointInput - numericInput) <= 0.000000001) {
                if (!updated) {
                    result.push(calibrationPoint(
                                    numericInput, numericOutput,
                                    point.preserveAngularDelta))
                    updated = true
                }
            } else {
                result.push(calibrationPoint(
                                pointInput, pointOutput,
                                point.preserveAngularDelta))
            }
        }
        if (!updated)
            result.push(calibrationPoint(numericInput, numericOutput, false))
        result.sort(function(first, second) { return first.input - second.input })
        return result
    }
}

