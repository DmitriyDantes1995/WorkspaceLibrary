import QtQuick 2.0
import QtQuick.Shapes 1.14

Item
{
  id: root
  height: stingLength + heelLength
  width: height * 0.03
  transform: Rotation { origin.x: width / 2; origin.y: stingLength; angle: rotationAngle }

  property real   posX: 100
  property real   posY: 100
  property real   stingLength: 100
  property real   heelLength: 80
  property color  fillingColor: "#d7e743" //"yellow"
  property color  borderColor: "#88aa00" //"black"
  property real   borderWidth: width * 0.05
  property real   rotationAngle: 0

  property real   figure_y:    stingLength * 0.25  // y центра фигурной детали
  property real   figureWidth: width * 1.8     // ширина фигурной детали
  property real   spineWidth:  width * 0.6     // ширина острия

  onHeightChanged: repos()
  onPosXChanged: repos()
  onPosYChanged: repos()

  function repos()  {
    var cnt_x = width / 2
    x = posX - cnt_x; y = posY - stingLength
  }

  // вместо border для фигурной детали
  Rectangle
  { width: root.figureWidth + root.borderWidth * 2
    height: width
    color: root.borderColor
    anchors.horizontalCenter: parent.horizontalCenter
    y: root.figure_y - height / 2
    rotation: 45
  }

  Shape
  { id: contour
    anchors.fill: parent
    antialiasing: true
    //containsMode: Shape.FillContains

    ShapePath
    { strokeColor: root.borderColor
      strokeWidth: root.borderWidth
      fillColor: root.fillingColor

      startX: (width - root.spineWidth) / 2; startY: 0
      PathLine { x: 0; y: root.figure_y }
      PathLine { x: 0; y: height - width / 2 }
      PathLine { x: width / 2; y: height }
      PathLine { x: width; y: height - width / 2 }
      PathLine { x: width; y: root.figure_y }
      PathLine { x: (width + root.spineWidth) / 2; y: 0 }
      PathLine { x: (width - root.spineWidth) / 2; y: 0 }
    }
  }

  Rectangle
  { width: root.figureWidth
    height: width
    color: root.fillingColor
    anchors.horizontalCenter: parent.horizontalCenter
    y: root.figure_y - height / 2
    rotation: 45
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

  // временно для обозначения центра фигуры
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
//    width: root.figureWidth * 1.8
//    y: root.figure_y - height / 2
//    border.width: 0
//    color: "green"
//  }
}
