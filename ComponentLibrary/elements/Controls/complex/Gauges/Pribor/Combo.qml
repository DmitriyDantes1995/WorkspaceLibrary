import QtQuick 2.14
import QtQuick.Shapes 1.14
import common_qml 1.0
import "_parts"
BaseSceneComponent
{
  id: gauge
  width: originalWidth
  height: originalHeight
  preserveAspectRatio: true
//  color: "#2b2b2b"

  property real  originalWidth: 690.45
  property real  originalHeight: 695.55
//  property real  posX: 100
//  property real  posY: 100

  property color fieldColor: "#2b2b2b"
  property color fieldShineColor: "#3b3b3b"
  property color outerMarkColor: "#b4e6b3"
  property color innerMarkColor: "white"
  property real  lightAngle: 20
  property string outerFontFamily: "Areal"

  // параметры для отображения
  property real thinNeedleAngle: 0 // угол поворота тонкой стрелки
  property real wideNeedleAngle: 0 // угол поворота толстой стрелки
  property real beakAngle: 0 // угол поворота клювика сверху
  property real trapezeAngle: 0 // угол поворота трапециевидного указателя
  property real rotaryDialAngle: 0 // угол поворота подвижного циферблата

  property string componentPath: ""

   my_type: "Su_25"
   my_subtype: "Pribor_1"
   previewSource: ""

  // Значения = переменные в Ranet?
   customProperties: {
    "thinNeedleAngle" : 0,
    "wideNeedleAngle" : 0,
    "beakAngle" : 0,
    "trapezeAngle" : 0,
    "rotaryDialAngle" : 0
  }
  propertySchema: ({
    "thinNeedleAngle": {
      displayName: "Thin needle", type: "number", bindable: true,
      min: 0, max: 360, step: 1, unit: "°"
    },
    "wideNeedleAngle": {
      displayName: "Wide needle", type: "number", bindable: true,
      min: 0, max: 360, step: 1, unit: "°"
    },
    "beakAngle": {
      displayName: "Top pointer", type: "number", bindable: true,
      min: 0, max: 360, step: 1, unit: "°"
    },
    "trapezeAngle": {
      displayName: "Trapeze pointer", type: "number", bindable: true,
      min: 0, max: 360, step: 1, unit: "°"
    },
    "rotaryDialAngle": {
      displayName: "Rotary dial", type: "number", bindable: true,
      min: 0, max: 360, step: 1, unit: "°"
    }
  })
  Component.onCompleted: {
      console.log("LOADED COMBO WITH componentPath PROPERTY")
  }

  Item {
    id: visualRoot
    objectName: "visualRoot"
    width: gauge.originalWidth
    height: gauge.originalHeight
    anchors.centerIn: parent
    scale: Math.min(gauge.width / gauge.originalWidth,
                    gauge.height / gauge.originalHeight)

  MouseArea {
      anchors.fill: parent
      onClicked: gauge.selected()
  }

  function setProperty(prop, val) {
       if (customProperties.hasOwnProperty(prop)) {
           customProperties[prop] = val;

       }
   }

  // внутреннее серое поле
  Rectangle
  { id: field
    width: visualRoot.width * 0.86
    height: width
    radius: width * 0.15
    color: gauge.fieldColor
    border.width: 0
    anchors.horizontalCenter: parent.horizontalCenter
    y: height * 0.092

    property real circle_radius:   field.width * 0.38
    property real circle_center_x: field.width / 2
    property real circle_center_y: field.height / 2
    property real outer_mark_length: inPixels(0.14)
    property real outer_mark_offset_y: inPixels(0.01)
    property real outer_text_offset_y: inPixels(0.02)
    property real outer_text_size: inPixels(0.15)

    function inPixels(percentage) {
      return circle_radius * percentage;
    }

    // внешний круг
    Rectangle
    {
      // кромка утопленного круга
      id: outer_circle
      width: field.circle_radius * 2
      height: width
      radius: width / 2
      anchors.horizontalCenter: parent.horizontalCenter
      y: height * 0.176
      gradient: Gradient
      { GradientStop { position: 0.0; color: "black" }
        GradientStop { position: 1.0; color: gauge.fieldShineColor }
      }
      rotation: gauge.lightAngle
      // утопленный круг
      Rectangle
      { width: parent.width * 0.99
        height: width
        radius: width / 2
        anchors.centerIn: parent
        color: gauge.fieldColor
        border.width: 0
      }
    }

    // заплнение внешнего круга
    Item
    { width: outer_circle.width
      height: outer_circle.height
      x: outer_circle.x
      y: outer_circle.y

      // крупные внешние метки
      Repeater
      {
        model:
        { const v = new Array(11)
          for (var i = 0; i < v.length; ++i) {
            v[i] = (i + 1) * 30
          }
          return v
        }
        Rectangle
        { id: outer_major_mark
          implicitWidth: field.inPixels(0.026)
          implicitHeight: field.outer_mark_length
          radius: implicitWidth * 0.5
          antialiasing: true
          color: gauge.outerMarkColor
          anchors.horizontalCenter: parent.horizontalCenter
          y: - height - field.outer_mark_offset_y
          transform: Rotation { origin.x: outer_major_mark.width / 2;
                                origin.y: field.circle_radius - outer_major_mark.y;
                                angle: modelData
                              }
          Rectangle
          { width: parent.width
            height: width
            color: parent.color
            anchors.bottom: parent.bottom
            antialiasing: true
            border.width: 0
          }
        }
      }

      // мелкие внешние метки
      Repeater
      {
        model:
        { const v = [10, 20, 160, 170, 190, 200, 340, 350]
          return v
        }
        Rectangle
        { id: outer_minor_mark
          implicitWidth: field.inPixels(0.016)
          implicitHeight: field.inPixels(0.08)
          antialiasing: true
          color: gauge.outerMarkColor
          anchors.horizontalCenter: parent.horizontalCenter
          y: - height - field.outer_mark_offset_y
          transform: Rotation { origin.x: outer_minor_mark.width / 2;
                                origin.y: outer_minor_mark.height + field.outer_mark_offset_y + field.circle_radius;
                                angle: modelData
                              }
        }
      }

      // оцифровка внешней шкалы
      Repeater
      {
        model:
        { const v = [60, 120, 240, 300]
          return v
        }
        Text
        { id: outer_text
          text: modelData / 10
          font.pixelSize: field.outer_text_size
          font.bold: true
          font.family: gauge.outerFontFamily
          antialiasing: true
          color: gauge.outerMarkColor
          anchors.horizontalCenter: parent.horizontalCenter
          y: -height - field.outer_mark_length - field.outer_text_offset_y - text_geom_offset()
          transform: [
            Rotation { origin.x: outer_text.width / 2; origin.y: outer_text.height / 2; angle: -modelData},
            Rotation { origin.x: outer_text.width / 2; origin.y: field.circle_radius - outer_text.y; angle: modelData}
          ]
          function text_geom_offset(){
            var px = Math.sqrt(width * width + height * height) / 2 - height / 2
            return px
          }
        }
      }

      // клювик сверху
      Item
      { id: beak
        width: field.inPixels(0.094)
        height: field.inPixels(0.166)
        anchors.horizontalCenter: parent.horizontalCenter
        y: -height
        transform: Rotation { origin.x: beak.width / 2;
                              origin.y: beak.height + outer_circle.height / 2
                              angle: gauge.beakAngle
                            }

        property real beakLineWidth: field.inPixels(0.01)

        Rectangle
        { id: stub
          width: field.inPixels(0.016)
          height: beak.height / 4 //field.inPixels(0.04)
          antialiasing: true
          anchors.horizontalCenter: parent.horizontalCenter
          y: parent.height - height * 0.8
          color: innerMarkColor
          //color: "transparent"
        }

        Canvas
        { anchors.fill: parent
          onPaint:
          {  var ctx = getContext("2d");
             ctx.reset();

             ctx.beginPath();
             ctx.strokeStyle = innerMarkColor
             ctx.lineWidth = beak.beakLineWidth;
             ctx.moveTo(beak.width / 2, stub.y + stub.height * 0.4)
             ctx.lineTo(beak.beakLineWidth * 0.75 , beak.beakLineWidth / 2);
             ctx.lineTo(beak.width - beak.beakLineWidth * 0.75, beak.beakLineWidth / 2);
             ctx.lineTo(beak.width / 2, stub.y + stub.height * 0.4)
             ctx.stroke();
          }
        }
      }

      // вращающийся циферблат
      Rectangle
      { id: rotary_dial
        width: outer_circle.width * 0.975
        height: width
        radius: width / 2
        color: "black"
        anchors.centerIn: parent//outer_circle
        rotation: gauge.rotaryDialAngle

        function mark_width(at_angle)
        { var w = field.inPixels(0.01) // ширина мелких меток
          if ((at_angle % 6) == 0) w = field.inPixels(0.045) // ширина крупных меток
          else if ((at_angle % 2) == 0) w = field.inPixels(0.025) // ширина средних меток
          return w
        }
        function mark_height(at_angle)
        { var h = field.inPixels(0.04) // длина мелких меток
          if ((at_angle % 6) == 0) h = field.inPixels(0.14) // длина крупных меток
          else if ((at_angle % 2) == 0) h = field.inPixels(0.08) // длина средних меток
          return h
        }
        // внутренние метки
        Repeater
        {
          model:
          { var v = new Array(72)
            for (var i = 0; i < v.length; ++i)
              v[i] = i * 5
            return v
          }
          Rectangle
          { id: inner_mark
            implicitWidth: rotary_dial.mark_width(modelData)
            implicitHeight: rotary_dial.mark_height(modelData)
            antialiasing: true
            color: gauge.innerMarkColor
            anchors.horizontalCenter: parent.horizontalCenter
            y: 0
            transform: Rotation { origin.x: inner_mark.width / 2;
                                  origin.y: rotary_dial.width / 2;
                                  angle: modelData
                                }
          }
        }
        // оцифровка внутренней шкалы
        Repeater
        { model:
          { var v = new Array(12)
            for (var i = 0; i < v.length; ++i)
              v[i] = i * 30
            return v
          }
          Text
          { id: inner_text
            text: modelData / 10
            font.family: "Areal"
            font.pixelSize: field.inPixels(0.18)
            font.bold: true
            antialiasing: true
            color: modelData == 0 ? "#ff6600" : gauge.innerMarkColor
            anchors.horizontalCenter: parent.horizontalCenter
            y: rotary_dial.mark_height(0)
            transform: Rotation { origin.x: inner_text.width / 2;
                                  origin.y: rotary_dial.height / 2 - inner_text.y;
                                  angle: modelData }
          }
        }
      }

      // трапециевидный указатель
      Item
      { id: trapeze
        width: field.inPixels(0.2)
        height: field.inPixels(0.114)
        anchors.horizontalCenter: parent.horizontalCenter
        y: -field.inPixels(0.026)
        transform: Rotation { origin.x: trapeze.width / 2;
                              origin.y: outer_circle.height / 2 - trapeze.y
                              angle: gauge.trapezeAngle
                            }

        property real flank_w: trapeze.width * 0.41
        property real flank_dx: trapeze.width * 0.14

        Canvas
        { anchors.fill: parent
          onPaint:
          {  var ctx = getContext("2d");
             ctx.reset();
             ctx.fillStyle = "#ff9900"

             ctx.beginPath();
             ctx.moveTo(0, 0)
             ctx.lineTo(trapeze.flank_w, 0);
             ctx.lineTo(trapeze.flank_w, trapeze.height);
             ctx.lineTo(trapeze.flank_dx, trapeze.height);
             ctx.lineTo(0, 0)
             ctx.fill();

             ctx.beginPath();
             ctx.moveTo(trapeze.width - trapeze.flank_w, 0)
             ctx.lineTo(trapeze.width, 0);
             ctx.lineTo(trapeze.width - trapeze.flank_dx, trapeze.height);
             ctx.lineTo(trapeze.width - trapeze.flank_w, trapeze.height);
             ctx.lineTo(trapeze.width - trapeze.flank_w, 0)
             ctx.fill();
          }
        }
      }

      // тонкая стрелка
      Needle
      { posX: parent.width / 2
        posY: parent.height / 2
        stingLength: parent.width * 0.48
        heelLength: parent.width * 0.46
        rotationAngle: gauge.thinNeedleAngle
      }

      // внутренний круг
      Rectangle
      { id: inner_circle
        width: field.inPixels(1.19)
        height: width
        radius: width / 2
        anchors.centerIn: parent
        //color: fieldColor
        gradient: Gradient
        { GradientStop { position: 0.0; color: "#171717" } //"#1e1e1e" }
          GradientStop { position: 1.0; color: "#393939" } //"#292929" }
        }
        rotation: gauge.lightAngle

        property color brightColor: "#393939"
        property color darkColor: "#171717"

        Shape
        { id: ball
          width: field.inPixels(1.0)
          height: width
          anchors.centerIn: parent
          antialiasing: true

          ShapePath
          {
            strokeWidth: -1

            fillGradient: RadialGradient
            { centerX: ball.width / 2; centerY: ball.height * 0.3
              centerRadius: ball.width / 2
              focalX: centerX; focalY: centerY
              GradientStop { position: 0.0; color: "#8f8f8f" }
              GradientStop { position: 1.0; color: "#000000" }
            }
            PathAngleArc
            { centerX: ball.width / 2; centerY: ball.height / 2
              radiusX: ball.width / 2; radiusY: ball.height / 2
              startAngle: 180
              sweepAngle: 360
            }
          }
        }
      }

      // толстая стрелка
      HeadingNeedle
      { posX: parent.width / 2
        posY: parent.height / 2
        stingLength: parent.width * 0.48
        heelLength: parent.width * 0.344
        baseWidth: parent.width * 0.086
        transparentRadius: parent.width *0.22
        rotationAngle: gauge.wideNeedleAngle
      }
    }
  }
  }
}
