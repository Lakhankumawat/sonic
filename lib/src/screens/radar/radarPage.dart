import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sonic/controller/radar_controller.dart';
import 'package:sonic/src/screens/radar/radarView.dart';

class RadarPage extends StatelessWidget {
  static final String routeName = '/radarPage';
  final RadarController _controller =
      Get.put(RadarController(address: Get.arguments as String));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF0F1532),
        body: Stack(
          children: [
            Positioned.fill(
              left: 10,
              right: 10,
              child: Center(
                child: Stack(children: [
                  Positioned.fill(
                    child: RadarView(),
                  ),
                  Positioned(
                    child: Center(
                      child: Container(
                        height: 70.0,
                        width: 60.0,
                        child: const Text(
                          '0',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Center(
                      child: Container(
                        height: 210.0,
                        width: 60.0,
                        child: const Text(
                          '50',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Center(
                      child: Container(
                        height: 390.0,
                        width: 80.0,
                        child: const Text(
                          '100',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            )
          ],
        ));
  }
}
