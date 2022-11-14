import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController extends GetxController {
  Future<void> getPermission(BuildContext context) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
      Permission.bluetoothAdvertise,
    ].request();
    if (await Permission.bluetoothConnect.request().isGranted) {
      Fluttertoast.showToast(msg: "Permission Granted!");
    } else {
      Fluttertoast.showToast(msg: "Permission Not Granted!");
    }
  }
}
