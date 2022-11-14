import 'package:flutter/cupertino.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:sonic/src/screens/chats/chats.dart';

class HomeController extends GetxController {
  RxBool bluetoothState = false.obs;
  RxString address = "...".obs;
  RxString name = "...".obs;

  @override
  onInit() {
    super.onInit();
    init();
  }

  init() async {
    // Get current state
    FlutterBluetoothSerial serial = FlutterBluetoothSerial.instance;
    await serial.state.then((state) {
      bluetoothState.value = state.isEnabled;
    });

    // Get local device address
    List<BluetoothDevice> devices = await serial.getBondedDevices();
    if (devices.isNotEmpty) {
      address.value = devices[0].address ?? "...";
      name.value = devices[0].name ?? "UNKNOWN";
    } else {
      address.value = "NULL";
      name.value = "NULL";
    }
  }

  @override
  void dispose() {
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
    super.dispose();
  }

  void startChat(BuildContext context, BluetoothDevice server) {
    Navigator.of(context).pushNamed(ChatPage.routeName, arguments: server);
  }

  void bluetoothSwitch(bool value) async {
    if (value) {
      await FlutterBluetoothSerial.instance.requestEnable();
    } else {
      await FlutterBluetoothSerial.instance.requestDisable();
    }
    init();
  }
}
