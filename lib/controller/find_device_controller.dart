import 'dart:async';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class FindDeviceController extends GetxController {
  Rx<bool> isLoading = false.obs;
  StreamSubscription<BluetoothDiscoveryResult>? _streamSubscription;
  RxList<BluetoothDiscoveryResult> results = RxList<BluetoothDiscoveryResult>.empty(growable: true);


  init() async {
    if (await Permission.location.request().isGranted) {
       setLoading();
        _startDiscovery();
    }
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _streamSubscription?.cancel();
  // }

  void setLoading() {
    isLoading.value = !isLoading.value;
  }

  void _startDiscovery() {
    _streamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {

            final existingIndex = results.indexWhere(
                    (element) => element.device.address == r.device.address);
            if (existingIndex >= 0) {
              results[existingIndex] = r;
            } else {
              results.add(r);
            }

        });

    _streamSubscription!.onDone(() {
      isLoading.value = false;
    });
  }

 void restartDiscovery() {
      results.clear();
      setLoading();
      _startDiscovery();
  }


  //for checking the status before scanning and connecting
  Future<bool> checkStatus() async {
    var scanStatus = await Permission.bluetoothScan.request().isGranted;

    var bluetoothConnectStatus =
        await Permission.bluetoothConnect.request().isGranted;

    if (scanStatus && bluetoothConnectStatus) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> refresh() async {
    //start loading animation
    setLoading();
    bool check = await checkStatus();
    if (check) {
      print('Scanning...');
      //update these results in a list
      FlutterBlue.instance.startScan(timeout: const Duration(seconds: 4));
    } else {
      print("Permission not granted");
    }
//stop loading animation
    setLoading();
  }
}
