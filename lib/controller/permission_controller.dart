import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sonic/src/screens/home/home.dart';

class PermissionController extends GetxController {

  onInit() {
    super.onInit();
    getPermission();
  }

  Future<void> getPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
      Permission.bluetoothAdvertise,
    ].request();
    if (await Permission.bluetoothConnect
        .request()
        .isGranted) {
      Fluttertoast.showToast(msg: "Permission Granted!");
      //loading.value = false;
      Get.offAndToNamed(Home.routeName);
    } else {
      Fluttertoast.showToast(msg: "Permission Not Granted!");
    }
  }
}
