import 'package:flutter/material.dart';
import 'package:sonic/src/screens/radar/radar_view.dart';

class RadarPage extends StatelessWidget {
  static const String routeName = '/radarPage';

  const RadarPage({super.key});

  // final RadarController _controller =
  //     Get.put(RadarController(address: Get.arguments as String));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF0F1532),
        body: Stack(
          children: [
            Positioned.fill(
              left: 10,
              right: 10,
              child: Center(
                child: Stack(children: const [
                  Positioned.fill(
                    child: RadarView(),
                  ),
                  Positioned(
                    child: Center(
                      child: SizedBox(
                        height: 70.0,
                        width: 60.0,
                        child: Text(
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
                      child: SizedBox(
                        height: 210.0,
                        width: 60.0,
                        child: Text(
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
                      child: SizedBox(
                        height: 390.0,
                        width: 80.0,
                        child: Text(
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
