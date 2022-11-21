import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../components/custom_button.dart';
import '../../../controller/permission_controller.dart';

class PermissionsPage extends StatelessWidget {
  static String routeName = '/permissions';

  PermissionsPage({Key? key}) : super(key: key);

  final PermissionController pc = Get.put(PermissionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment(0.6, 0.7),
              end: Alignment(-0.7, 0.6),
              colors: [
                Color.fromRGBO(34, 52, 60, 1),
                Color.fromRGBO(31, 46, 53, 1)
              ]),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 0.1.sw,
            vertical: 0.1.sh,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Enable Bluetooth',
              ),
              const Text(
                'We need to enable bluetooth in order to scan and connect to nearby devices',
                textAlign: TextAlign.center,
              ),
              CustomButton(
                buttonText: 'Enable',
                textColor: Colors.white,
                buttonColor: const Color.fromRGBO(63, 223, 158, 1),
                leading: true,
                onTap: () {
                  pc.getPermission();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
