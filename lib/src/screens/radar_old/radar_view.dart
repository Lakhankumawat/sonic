import 'package:flutter/material.dart';
import 'package:sonic/src/screens/radar_old/radar_painter.dart';

class RadarView extends StatefulWidget {
  const RadarView({super.key});

  @override
  State<StatefulWidget> createState() => _RadarViewState();
}

class _RadarViewState extends State<RadarView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    //final radians = degrees * math.pi / 180;
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
