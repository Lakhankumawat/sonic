import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sonic/src/screens/radar/radarPainter.dart';

class RadarView extends StatefulWidget {
  @override
  _RadarViewState createState() => _RadarViewState();
}

class _RadarViewState extends State<RadarView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    //final radians = degrees * math.pi / 180;
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animation = Tween(begin: .0, end: 2 * pi).animate(_controller);
    //_controller.reverse(from:pi);
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final BackgroundCollectingTask task =
    // BackgroundCollectingTask.of(context, rebuildOnChange: true);
    return CustomPaint(
      painter: RadarPainter(
          //task: task,
          ),
    );
  }
}
