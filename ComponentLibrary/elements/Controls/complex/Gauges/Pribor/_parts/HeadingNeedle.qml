import QtQuick 2.0
import QtQuick.Shapes 1.14

Item
{
  id: root
  height: stingLength + heelLength
  width: baseWidth * 1.4
  transform: Rotation { origin.x: width / 2; origin.y: stingLength; angle: rotationAngle }
  antialiasing: true

  property real   posX: 100 // x - координата оси вращения
  property real   posY: 100 // y - координата оси вращения
  property real   baseWidth: 16 // ширина основной части
  property real   stingLength: 100 // длина острого конца
  property real   heelLength: 80 // длина тупого конца
  property real   spinePart: 0.54 // часть, отведенная под острие
  property real   trapezePart: 0.3 // часть трапециевидной детали
  property real   transparentRadius: 50 // радиус прозрачной части
  property color  fillingColor: "white"
  property color  borderColor: "silver" //"#2b2b2b"
  property real   borderWidth: thin_line()
  property real   rotationAngle: 0

//  property real   figure_y:    stingLength * 0.25  // y центра фигурной детали
//  property real   figureWidth: width * 1.8     // ширина фигурной детали
//  property real   spineWidth:  width * 0.6     // ширина острия

  onHeightChanged: repos()
  onWidthChanged: repos()
  onPosXChanged: repos()
  onPosYChanged: repos()

  function repos()  {
    var cnt_x = width / 2
    x = posX - cnt_x; y = posY - stingLength
  }

  function thin_line()
  {
    var w = root.width * 0.01
    if (w > 1) w = 1;
    return w
  }

  Shape
  { id: contour
    anchors.fill: parent
    antialiasing: true
    //containsMode: Shape.FillContains

    property real dx: (width - baseWidth) / 2
    property real wlo: baseWidth * 0.2
    property real whi: baseWidth * 0.05
    property real dx1: dx + (baseWidth - wlo) / 2
    property real wx: baseWidth * 0.25
    property real y3: root.stingLength - root.transparentRadius
    property real y1: y3 * spinePart
    property real y2: y3 * (spinePart + trapezePart)
    property real y4: root.stingLength + root.transparentRadius
    property real wy: baseWidth * 0.08

    // острая часть
    ShapePath
    { strokeColor: root.borderColor
      strokeWidth: root.borderWidth
      fillColor: root.fillingColor

      startX: contour.dx; startY: contour.y3
      PathLine { x: contour.dx; y: contour.y2 }
      PathLine { x: 0; y: contour.y2 }
      PathLine { x: contour.dx; y: contour.y1 }
      PathLine { x: contour.dx1; y: contour.y1 }
      // острие
      PathLine { x: (contour.width - contour.whi) / 2; y: 0 }
      PathLine { x: (contour.width + contour.whi) / 2; y: 0 }
      PathLine { x: contour.width - contour.dx1; y: contour.y1 }

      PathLine { x: contour.width - contour.dx; y: contour.y1 }
      PathLine { x: contour.width; y: contour.y2 }
      PathLine { x: contour.width - contour.dx; y: contour.y2 }
      PathLine { x: contour.width - contour.dx; y: contour.y3 }
      PathLine { x: contour.width - contour.dx - contour.wx; y: contour.y3 }
      PathLine { x: contour.width - contour.dx - contour.wx; y: contour.y1 + contour.wy }
      PathLine { x: contour.dx + contour.wx; y: contour.y1 + contour.wy }
      PathLine { x: contour.dx + contour.wx; y: contour.y3 }
      PathLine { x: contour.dx; y: contour.y3 }
    }

//    // левое крыло тупой части
//    ShapePath
//    { strokeColor: root.borderColor
//      strokeWidth: root.borderWidth
//      fillColor: root.fillingColor

//      startX: contour.dx; startY: contour.y4
//      PathLine { x: contour.dx + contour.wx; y: contour.y4 }
//      PathLine { x: contour.dx + contour.wx; y: contour.height }
//      PathLine { x: contour.dx; y: contour.height }
//      PathLine { x: contour.dx; y: contour.y4 }
//    }
//    // правое крыло тупой части
//    ShapePath
//    { strokeColor: root.borderColor
//      strokeWidth: root.borderWidth
//      fillColor: root.fillingColor

//      startX: contour.width - contour.dx; startY: contour.y4
//      PathLine { x: contour.width - contour.dx - contour.wx; y: contour.y4 }
//      PathLine { x: contour.width - contour.dx - contour.wx; y: contour.height }
//      PathLine { x: contour.width - contour.dx; y: contour.height }
//      PathLine { x: contour.width - contour.dx; y: contour.y4 }
//    }
  }
//  Canvas
//  { anchors.fill: parent
//    onPaint:
//    { var ctx = getContext("2d");
//      ctx.reset();

//      ctx.beginPath();
//      ctx.strokeStyle = dial_circle.scaleColor
//      ctx.lineWidth = outerRadius * 0.02;

//      ctx.arc(outerRadius, outerRadius, outerRadius - middleMarkLength + ctx.lineWidth / 2,
//              degreesToRadians(valueToDegree(15) - 90), degreesToRadians(valueToDegree(20) - 90));
//      ctx.stroke();
//    }
//  }

  // левое крыло тупой части
  Rectangle
  { border.color: root.borderColor
    border.width: root.borderWidth
    color: root.fillingColor
    antialiasing: true
    x: contour.dx
    y: contour.y4
    width: contour.wx
    height: contour.height - contour.y4
  }
  // правое крыло тупой части
  Rectangle
  { border.color: root.borderColor
    border.width: root.borderWidth
    color: root.fillingColor
    antialiasing: true
    x: contour.width - contour.dx - contour.wx
    y: contour.y4
    width: contour.wx
    height: contour.height - contour.y4
  }

//  // временно для обозначения центра
//  Rectangle
//  { id: vert_line
//    anchors.horizontalCenter: parent.horizontalCenter
//    height: parent.height * 1.1
//    width: 1//field.inPixels(0.005)
//    y: (parent.height - height) / 2
//    border.width: 0
//    color: "green"
//  }
//  Rectangle
//  { anchors.horizontalCenter: parent.horizontalCenter
//    height: 1
//    width: parent.width * 1.2
//    y: parent.stingLength
//    border.width: 0
//    color: "green"
//  }
//  Rectangle
//  { anchors.fill: parent
//    border.width: 1
//    border.color: "green"
//    color: "transparent"
//  }

}
