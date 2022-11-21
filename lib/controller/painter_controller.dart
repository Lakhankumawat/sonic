import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/constant.dart';

class PainterController extends GetxController{
 late double centerX;
 late double centerY;

 //default constructor to initialize the centerX and centerY
  PainterController(){
     centerX= Get.size.width / 2;
    centerY = Get.size.height / 2;
  }

  Paint bgPaint = Paint()
    ..color = Colors.white
    ..strokeWidth = 1
    ..style = PaintingStyle.stroke;

  Paint paint = Paint()..style = PaintingStyle.fill;

  //point for points
  final Paint points = Paint()
    ..color = const Color(0xff63aa65)
    ..strokeCap = StrokeCap.round //rounded points
    ..strokeWidth = 10;

  int circleCount = 3;
  int counter=1;

late double radius = min(centerX, centerY);
late Offset center = Offset(centerX, centerY);

  var fillBrush = Paint()..color = CustomColors.clockBG;
  var outlineBrush = Paint()
    ..color = CustomColors.clockOutline
    ..style = PaintingStyle.stroke
    ..strokeWidth = Get.size.width / 20;
  var centerDotBrush = Paint()..color = CustomColors.clockOutline;

  var dashBrush = Paint()
    ..color = CustomColors.clockOutline
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

}