import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sonic/controller/painter_controller.dart';
import '../../../controller/radar_controller.dart';

class RadarPainter extends CustomPainter {
  final RadarController _rc = Get.find();
  final PainterController _pc = Get.put(PainterController());
  final Paint _bgPaint = Paint()
    ..color = Colors.white
    ..strokeWidth = 1
    ..style = PaintingStyle.stroke;

  final Paint _paint = Paint()..style = PaintingStyle.fill;

  //point for points
  final Paint _points = Paint()
    ..color = const Color(0xff63aa65)
    ..strokeCap = StrokeCap.round //rounded points
    ..strokeWidth = 10;

  int circleCount = 3;
  int counter = 1;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(Offset(size.width / 2, size.height / 2 - _pc.radius),
        Offset(size.width / 2, size.height / 2 + _pc.radius), _bgPaint);
    canvas.drawLine(Offset(size.width / 2 + _pc.radius, size.height / 2),
        Offset(size.width / 2 - _pc.radius, size.height / 2), _bgPaint);

    //draws the circles of the radar
    for (var i = 1; i <= circleCount; ++i) {
      canvas.drawArc(
          Rect.fromCenter(
            center: Offset(size.width / 2, size.height / 2),
            height: 2 * _pc.radius * i / circleCount,
            width: 2 * _pc.radius * i / circleCount,
          ),
          pi,
          2 * pi,
          false,
          _bgPaint);
      // canvas.drawCircle(Offset(size.width / 2, size.height / 2),
      //     _pc.radius * i / circleCount, _bgPaint);
    }

    _paint.shader = ui.Gradient.sweep(
        Offset(size.width / 2, size.height / 2),
        [Colors.white.withOpacity(0.5), Colors.white.withOpacity(.5)],
        [.0, 1.0],
        TileMode.clamp,
        .0,
        pi / 12);

    //draw radar line at angle provided by task object
    // final int  rangle = int.parse(task.radarData.last.angle);
    // final int distance = int.parse(task.radarData.last.distance);
    // debugPrint("rangle: $rangle"+" distance: $distance");

    // canvas.save();
    // double r = sqrt(pow(size.width, 2) + pow(size.height, 2));
    // double startAngle = atan(size.height / size.width);
    // Point p0 = Point(r * cos(startAngle), r * sin(startAngle));
    // Point px = Point(r * cos(angle + startAngle), r * sin(angle + startAngle));
    // canvas.translate((p0.x - px.x) / 2, (p0.y - px.y) / 2);
    // canvas.rotate(angle);
    //
    // canvas.drawArc(
    //     Rect.fromCircle(
    //         center: Offset(size.width / 2, size.height / 2), _pc.radius: _pc.radius),
    //     0,
    //     0.1,
    //     true,
    //     _paint);
    // canvas.restore();
    //drawLine(canvas, size);
    drawObject(canvas, size);

    var outer = _pc.radius;
    var inner = _pc.radius * 0.9;
    for (var i = 0; i < 360; i += 12) {
      var x1 = _pc.centerX + outer * cos(i * pi / 180);
      var y1 = _pc.centerY + outer * sin(i * pi / 180);

      var x2 = _pc.centerX + inner * cos(i * pi / 180);
      var y2 = _pc.centerY + inner * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), _pc.dashBrush);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

//--------------------------Utiliy functions-----------------------------//
  void drawObject(Canvas canvas, Size size) {
    double pixelDistance =
        _rc.idistance.value * ((size.height - size.height * 0.1666) * 0.025);
    debugPrint("pixelDistance: $pixelDistance");
    if (pixelDistance < 40) {
      //draw a point on the radar
      canvas.drawPoints(
          ui.PointMode.points,
          [
            Offset(
              pixelDistance *
                  cos(
                    _rc.iangle.value * 180 / pi,
                  ),
              pixelDistance *
                  sin(
                    _rc.iangle.value * 180 / pi,
                  ),
            ),
          ],
          _points);
    }
    // translate(width/2,height-height*0.074); // moves the starting coordinats to new location
    // strokeWeight(9);
    // stroke(255,10,10); // red color
    // pixsDistance = iDistance*((height-height*0.1666)*0.025); // covers the distance from the sensor from cm to pixels
    // // limiting the range to 40 cms
    // if(iDistance<40) {
    //   // draws the object according to the angle and the distance
    //   line(pixsDistance * cos(radians(iAngle)),
    //       -pixsDistance * sin(radians(iAngle)),
    //       (width - width * 0.505) * cos(radians(iAngle)),
    //       -(width - width * 0.505) * sin(radians(iAngle)));
    // }
  }

  void drawText() {
    // pushMatrix();
    // if(iDistance>40) {
    //   noObject = "Out of Range";
    // }
    // else {
    //   noObject = "In Range";
    // }
    // fill(0,0,0);
    // noStroke();
    // rect(0, height-height*0.0648, width, height);
    // fill(98,245,31);
    // textSize(25);
    //
    // text("10cm",width-width*0.3854,height-height*0.0833);
    // text("20cm",width-width*0.281,height-height*0.0833);
    // text("30cm",width-width*0.177,height-height*0.0833);
    // text("40cm",width-width*0.0729,height-height*0.0833);
    // textSize(40);
    // text("Lakhan Kumawat 's Radar", width-width*0.800, height-height*0.0200);
    // text("Angle: " + iAngle +" °", width-width*0.48, height-height*0.0277);
    // text("Distance: ", width-width*0.26, height-height*0.0277);
    // if(iDistance<40) {
    //   text("        " + iDistance +" cm", width-width*0.225, height-height*0.0277);
    // }
    // textSize(25);
    // fill(98,245,60);
    // translate((width-width*0.4994)+width/2*cos(radians(30)),(height-height*0.0907)-width/2*sin(radians(30)));
    // rotate(-radians(-60));
    // text("30°",0,0);
    // resetMatrix();
    // translate((width-width*0.503)+width/2*cos(radians(60)),(height-height*0.0888)-width/2*sin(radians(60)));
    // rotate(-radians(-30));
    // text("60°",0,0);
    // resetMatrix();
    // translate((width-width*0.507)+width/2*cos(radians(90)),(height-height*0.0833)-width/2*sin(radians(90)));
    // rotate(radians(0));
    // text("90°",0,0);
    // resetMatrix();
    // translate(width-width*0.513+width/2*cos(radians(120)),(height-height*0.07129)-width/2*sin(radians(120)));
    // rotate(radians(-30));
    // text("120°",0,0);
    // resetMatrix();
    // translate((width-width*0.5104)+width/2*cos(radians(150)),(height-height*0.0574)-width/2*sin(radians(150)));
    // rotate(radians(-60));
    // text("150°",0,0);
    // popMatrix();
  }

  void drawLine(Canvas canvas, Size size) {
    // pushMatrix();
    // strokeWeight(9);
    // stroke(30,250,60);
    // translate(width/2,height-height*0.074); // moves the starting coordinats to new location
    // line(0,0,(height-height*0.12)*cos(radians(iAngle)),-(height-height*0.12)*sin(radians(iAngle))); // draws the line according to the angle
    // popMatrix();

    //draw the radar line using the angle
    canvas.drawLine(
        Offset(size.width / 2, size.height - size.height * 0.074),
        Offset(
            (size.height - size.height * 0.12) *
                cos(_rc.iangle.value * 180 / pi),
            -(size.height - size.height * 0.12) *
                sin(_rc.iangle.value * 180 / pi)),
        _pc.outlineBrush);
  }

  void drawRadar() {
    // pushMatrix();
    // translate(width/2,height-height*0.074); // moves the starting coordinats to new location
    // noFill();
    // strokeWeight(2);
    // stroke(98,245,31);
    // // draws the arc lines
    // arc(0,0,(width-width*0.0625),(width-width*0.0625),PI,TWO_PI);
    // arc(0,0,(width-width*0.27),(width-width*0.27),PI,TWO_PI);
    // arc(0,0,(width-width*0.479),(width-width*0.479),PI,TWO_PI);
    // arc(0,0,(width-width*0.687),(width-width*0.687),PI,TWO_PI);
    // // draws the angle lines
    // line(-width/2,0,width/2,0);
    // line(0,0,(-width/2)*cos(radians(30)),(-width/2)*sin(radians(30)));
    // line(0,0,(-width/2)*cos(radians(60)),(-width/2)*sin(radians(60)));
    // line(0,0,(-width/2)*cos(radians(90)),(-width/2)*sin(radians(90)));
    // line(0,0,(-width/2)*cos(radians(120)),(-width/2)*sin(radians(120)));
    // line(0,0,(-width/2)*cos(radians(150)),(-width/2)*sin(radians(150)));
    // line((-width/2)*cos(radians(30)),0,width/2,0);
    // popMatrix();
  }
}
