import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';

import '../../../controller/home_controller.dart';
import '../find_device/find_device.dart';

class Home extends StatelessWidget {
  static String routeName = '/home';

  Home({Key? key}) : super(key: key);

  final HomeController _hc = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    // return StreamBuilder<BluetoothState>(
    //     stream: FlutterBlue.instance.state,
    //     initialData: BluetoothState.unknown,
    //     builder: (c, snapshot) {
    //       final state = snapshot.data;
    //       if (state == BluetoothState.on) {
    //         return FindDevicesScreen();
    //       }
    //       return BluetoothOffScreen(state: state);
    //     });
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(child: Text('Sonic')),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            const Divider(),
            const ListTile(title: Text('General')),
            Obx(
              () => SwitchListTile(
                  title: const Text('Enable Bluetooth'),
                  value: _hc.bluetoothState.value,
                  onChanged: (bool value) => _hc.bluetoothSwitch(value)),
            ),
            ListTile(
              title: const Text('Bluetooth status'),
              subtitle: Obx(() =>
                  Text(_hc.bluetoothState.value ? 'enabled' : 'disabled')),
              trailing: ElevatedButton(
                onPressed: () {
                  FlutterBluetoothSerial.instance.openSettings();
                },
                child: const Text('Settings'),
              ),
            ),
            ListTile(
              title: const Text('Local adapter address'),
              subtitle: Obx(() => Text(_hc.address.value)),
            ),
            ListTile(
              title: const Text('Local adapter name'),
              subtitle: Obx(() => Text(_hc.name.value)),
              onLongPress: null,
            ),
            const Divider(),
            const ListTile(title: Text('Devices discovery and connection')),
            ListTile(
              title: ElevatedButton(
                onPressed: () async {
                  final BluetoothDevice? selectedDevice =
                      await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return FindDevicesScreen();
                      },
                    ),
                  );

                  if (selectedDevice != null) {
                    print('Connect -> selected ' + selectedDevice.address);
                  } else {
                    print('Connect -> no device selected');
                  }
                },
                child: const Text('Connect to paired device to chat'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
