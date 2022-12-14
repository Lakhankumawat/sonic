import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant/constant.dart';
import '../../../controller/radar_controller.dart';

class RadarView extends StatefulWidget {
  static const String routeName = '/radarView';

  const RadarView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RadarViewState();
}

class _RadarViewState extends State<RadarView> {
  late Timer timer;
  double angle = 0;
  double distance = 0;
  final RadarController _controller =
      Get.put(RadarController(address: Get.arguments as String));

  @override
  void initState() {
    timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {
        angle = _controller.iangle.value;
        distance = _controller.idistance.value;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'angle: $angle',
          style: const TextStyle(
            fontSize: 20,
            color: Colors.greenAccent,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'distance:',
              style: TextStyle(fontSize: 20),
            ),
            distance < 40
                ? Text(
                    ' $distance',
                    style: const TextStyle(fontSize: 20, color: Colors.red),
                  )
                : //else infinity icon
                const Icon(
                    Icons.dangerous_sharp, //infinity icon
                    color: Colors.green,
                    size: 20,
                  ),
          ],
        ),
        Align(
          alignment: Alignment.center,
          child: Transform.scale(
            scale: 0.8,
            child: SizedBox(
              width: Get.size.width,
              height: Get.size.height / 1.5,
              child: CustomPaint(
                painter: ClockPainter(angle: angle, distance: distance),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ClockPainter extends CustomPainter {
  final double angle;
  final double distance;

  //create a list of points
  List<Offset> points = [];

  ClockPainter({this.angle = 0, this.distance = 0});

  final Paint _bgPaint = Paint()
    ..color = Colors.white
    ..strokeWidth = 1
    ..style = PaintingStyle.stroke;

  final double centerX = Get.size.width / 2;
  final double centerY = Get.size.height / 2;

  int circleCount = 4;

  var dashBrush = Paint()
    ..color = CustomColors.clockOutline
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  final Paint _points = Paint()
    ..color = Colors.red
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.0)
    ..strokeWidth = 10;

  var fillBrush = Paint()..color = CustomColors.clockBG;
  var outlineBrush = Paint()
    ..color = CustomColors.clockOutline
    ..style = PaintingStyle.stroke
    ..strokeWidth = 20;
  var centerDotBrush = Paint()..color = CustomColors.clockOutline;

  var secHandBrush = Paint()
    ..color = CustomColors.secHandColor!
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 15;

  var radarLineBrush = Paint()
    ..color = CustomColors.minHandEndColor
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 14;

  int counter = 1;

  @override
  void paint(Canvas canvas, Size size) {
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    final double radians = angle * pi / 180;
    final double x = cos(radians);
    final double y = sin(radians);

    // vertical axis
    canvas.drawLine(
        Offset(centerX, centerY - radius), Offset(centerX, centerY), _bgPaint);
    // horizontal axis
    canvas.drawLine(Offset(centerX + radius, centerY - sin(pi + 0.12)),
        Offset(centerX - radius, centerY), _bgPaint);

    for (var i = 1; i <= circleCount; ++i) {
      canvas.drawArc(
          Rect.fromCenter(
            center: Offset(centerX, centerY),
            height: 2 * radius * i / circleCount,
            width: 2 * radius * i / circleCount,
          ),
          pi,
          pi,
          false,
          _bgPaint);
    }

    var hourHandX = centerX + radius * 0.9 * x;
    var hourHandY = centerY - radius * 0.9 * y;
    canvas.drawLine(center, Offset(hourHandX, hourHandY), radarLineBrush);

    //make a center dot inside circle at a distance
    if (distance < 40) {
      double pixelDistance =
          distance * ((size.height - size.height * 0.166) * 0.025);
      points.add(
          Offset(centerX + pixelDistance * x, centerY - pixelDistance * y));
    }

    canvas.drawPoints(ui.PointMode.points, points, _points);

    canvas.drawCircle(center, radius * 0.10, centerDotBrush);

    var outer = radius;
    var inner = radius * 0.9;
    for (var i = 180; i < 360; i += 12) {
      var x1 = centerX + outer * cos(i * pi / 180);
      var y1 = centerY + outer * sin(i * pi / 180);

      var x2 = centerX + inner * cos(i * pi / 180);
      var y2 = centerY + inner * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }

    counter++;
    if (counter == 100) {
      points.clear();
      counter = 0;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
