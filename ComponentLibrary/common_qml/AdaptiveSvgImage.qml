pragma ComponentBehavior: Bound

import QtQuick 2.15
import QtQuick.Window 2.15

Item {
    id: root

    // Marker used by tests and diagnostics without exposing the inner Image.
    readonly property bool adaptiveSvgImage: true

    // A local url property preserves the caller's URL context. Aliasing the
    // inner Image.source would resolve "background.svg" relative to this
    // helper instead of relative to the component using it.
    property url source
    property alias fillMode: image.fillMode
    property alias mipmap: image.mipmap
    property alias cache: image.cache
    property alias asynchronous: image.asynchronous
    property alias autoTransform: image.autoTransform
    property alias horizontalAlignment: image.horizontalAlignment
    property alias verticalAlignment: image.verticalAlignment
    property alias mirror: image.mirror
    // Qt 6.11 can deadlock while reading qmlcache entries containing aliases
    // to these newer Image properties. Plain properties preserve the public
    // API while the bindings below avoid the broken alias metadata.
    property bool mirrorVertically: false
    property bool retainWhileLoading: false
    property alias sourceClipRect: image.sourceClipRect

    readonly property alias sourceSize: image.sourceSize
    readonly property alias paintedWidth: image.paintedWidth
    readonly property alias paintedHeight: image.paintedHeight
    readonly property alias status: image.status
    readonly property alias progress: image.progress

    // 32 px upward buckets avoid undersampling and greatly reduce SVG reloads
    // during a resize gesture. 4096 px keeps a single RGBA texture near 64 MiB
    // and is supported by the graphics backends targeted by this project.
    property int renderSizeBucket: 32
    property int renderDebounceInterval: 90
    property int maximumTextureSize: 4096

    property real _naturalImplicitWidth: 0
    property real _naturalImplicitHeight: 0

    // Image.sourceSize also changes Image.implicitWidth/implicitHeight. Keep
    // the first natural SVG size so replacing Image never changes a component
    // whose root geometry is based on image.implicitWidth/implicitHeight.
    implicitWidth: _naturalImplicitWidth > 0
                   ? _naturalImplicitWidth : image.implicitWidth
    implicitHeight: _naturalImplicitHeight > 0
                    ? _naturalImplicitHeight : image.implicitHeight

    property var _transformObservers: []

    function devicePixelRatio() {
        if (root.Screen.devicePixelRatio > 0)
            return root.Screen.devicePixelRatio
        return 1
    }

    function mappedRenderSize() {
        if (root.width <= 0 || root.height <= 0)
            return Qt.size(0, 0)

        // Mapping two local basis vectors into scene coordinates captures the
        // complete QQuickItem transform chain: component scale, visualRoot
        // Scale objects, Constructor scene zoom and qt_cab root zoom.
        var origin = root.mapToItem(null, 0, 0)
        var horizontal = root.mapToItem(null, root.width, 0)
        var vertical = root.mapToItem(null, 0, root.height)
        var horizontalX = horizontal.x - origin.x
        var horizontalY = horizontal.y - origin.y
        var verticalX = vertical.x - origin.x
        var verticalY = vertical.y - origin.y
        var ratio = devicePixelRatio()

        return Qt.size(Math.sqrt(horizontalX * horizontalX
                                 + horizontalY * horizontalY) * ratio,
                       Math.sqrt(verticalX * verticalX
                                 + verticalY * verticalY) * ratio)
    }

    function bucketedSize(value) {
        var bucket = Math.max(1, renderSizeBucket)
        return Math.ceil(Math.max(1, value) / bucket) * bucket
    }

    function captureNaturalImplicitSize() {
        if (_naturalImplicitWidth <= 0 && image.implicitWidth > 0)
            _naturalImplicitWidth = image.implicitWidth
        if (_naturalImplicitHeight <= 0 && image.implicitHeight > 0)
            _naturalImplicitHeight = image.implicitHeight
    }

    function updateSourceSize() {
        // Library previews may instantiate an item only to read its metadata.
        // Its natural dimensions are available without a screen-sized raster.
        if (!root.Window.window)
            return
        // Let the first load complete at the SVG's natural size. Besides
        // preserving Image-compatible implicit geometry, this only happens
        // once; all later renders use the adaptive target.
        if ((_naturalImplicitWidth <= 0 || _naturalImplicitHeight <= 0)
                && image.status !== Image.Ready)
            return
        captureNaturalImplicitSize()

        var mapped = mappedRenderSize()
        if (mapped.width <= 0 || mapped.height <= 0)
            return

        var limit = Math.max(1, maximumTextureSize)
        var targetWidth = Math.min(limit, bucketedSize(mapped.width))
        var targetHeight = Math.min(limit, bucketedSize(mapped.height))

        // Staying in the same bucket means the currently cached SVG raster is
        // already sufficient. Avoid assigning sourceSize and reloading it.
        if (image.sourceSize.width === targetWidth
                && image.sourceSize.height === targetHeight)
            return

        image.sourceSize = Qt.size(targetWidth, targetHeight)
    }

    function scheduleSourceSizeUpdate() {
        if (root.Window.window)
            renderSizeTimer.restart()
    }

    function rebuildTransformObservers() {
        var targets = new Set()
        if (root.Window.window) {
            targets.add(root.Window.window)
            for (var item = root; item; item = item.parent) {
                targets.add(item)
                for (var transform of item.transform)
                    targets.add(transform)
            }
        }

        var observers = []
        for (var observer of _transformObservers) {
            if (targets.delete(observer.observedObject))
                observers.push(observer)
            else
                observer.destroy()
        }
        for (var target of targets) {
            var added = transformObserverFactory.createObject(root, { observedObject: target })
            if (added)
                observers.push(added)
        }
        _transformObservers = observers
        scheduleSourceSizeUpdate()
    }

    function scheduleObserverRebuild() {
        if ((root.Window.window || _transformObservers.length) && !observerRebuildTimer.running)
            observerRebuildTimer.start()
    }

    Component {
        id: transformObserverFactory

        Connections {
            required property var observedObject
            target: observedObject
            ignoreUnknownSignals: true

            function changed() { root.scheduleSourceSizeUpdate() }

            function onWidthChanged() { changed() }
            function onHeightChanged() { changed() }
            function onScaleChanged() { changed() }
            function onRotationChanged() { changed() }
            function onTransformOriginChanged() { changed() }
            function onTransformChanged() { root.scheduleObserverRebuild() }
            function onXScaleChanged() { changed() }
            function onYScaleChanged() { changed() }
            function onZScaleChanged() { changed() }
            function onAngleChanged() { changed() }
            function onOriginChanged() { changed() }
            function onParentChanged() { root.scheduleObserverRebuild() }
            function onWindowChanged() { root.scheduleObserverRebuild() }
            function onScreenChanged() { changed() }
            function onDevicePixelRatioChanged() { changed() }
        }
    }

    Timer {
        id: observerRebuildTimer
        interval: 0
        onTriggered: root.rebuildTransformObservers()
    }

    Timer {
        id: renderSizeTimer
        interval: Math.max(0, root.renderDebounceInterval)
        repeat: false
        onTriggered: root.updateSourceSize()
    }

    Image {
        id: image
        anchors.fill: parent
        source: root.source
        smooth: root.smooth
        mirrorVertically: root.mirrorVertically
        retainWhileLoading: root.retainWhileLoading
        onStatusChanged: {
            if (status === Image.Ready) {
                root.captureNaturalImplicitSize()
                root.updateSourceSize()
            }
        }
    }

    onSourceChanged: scheduleSourceSizeUpdate()
    Window.onWindowChanged: scheduleObserverRebuild()
    Screen.onDevicePixelRatioChanged: scheduleSourceSizeUpdate()

    Component.onCompleted: {
        scheduleObserverRebuild()
        // Avoid one natural-size frame on initial creation. Later geometry
        // changes remain debounced.
        if (image.status === Image.Ready) {
            captureNaturalImplicitSize()
            updateSourceSize()
        }
    }
}
