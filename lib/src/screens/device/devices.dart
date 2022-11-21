import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:sonic/controller/device_controller.dart';

class DeviceScreen extends StatelessWidget {
  static String routeName = '/device';

  DeviceScreen({Key? key}) : super(key: key);
  final BluetoothDevice device = Get.arguments as BluetoothDevice;
  final DeviceController deviceControl = Get.put(DeviceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(deviceControl.device.value.name),
        actions: <Widget>[
          StreamBuilder<BluetoothDeviceState>(
            stream: deviceControl.device.value.state,
            initialData: BluetoothDeviceState.connecting,
            builder: (c, snapshot) {
              VoidCallback onPressed;
              String text;
              switch (snapshot.data) {
                case BluetoothDeviceState.connected:
                  onPressed = () => deviceControl.device.value.disconnect();
                  text = 'DISCONNECT';
                  break;
                case BluetoothDeviceState.disconnected:
                  onPressed = () => deviceControl.device.value.connect();
                  text = 'CONNECT';
                  break;
                default:
                  onPressed = () {};
                  text = snapshot.data.toString().substring(21).toUpperCase();
                  break;
              }
              return ElevatedButton(
                  onPressed: onPressed,
                  child: Text(
                    text,
                  ));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder<BluetoothDeviceState>(
              stream: deviceControl.device.value.state,
              initialData: BluetoothDeviceState.connecting,
              builder: (c, snapshot) => ListTile(
                leading: (snapshot.data == BluetoothDeviceState.connected)
                    ? const Icon(Icons.bluetooth_connected)
                    : const Icon(Icons.bluetooth_disabled),
                title: Text(
                    'Device is ${snapshot.data.toString().split('.')[1]}.'),
                subtitle: Text('${deviceControl.device.value.id}'),
                trailing: StreamBuilder<bool>(
                  stream: deviceControl.device.value.isDiscoveringServices,
                  initialData: false,
                  builder: (c, snapshot) => IndexedStack(
                    index: snapshot.data! ? 1 : 0,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: () =>
                            deviceControl.device.value.discoverServices(),
                      ),
                      const IconButton(
                        icon: SizedBox(
                          width: 18.0,
                          height: 18.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.grey),
                          ),
                        ),
                        onPressed: null,
                      )
                    ],
                  ),
                ),
              ),
            ),
            StreamBuilder<int>(
              stream: deviceControl.device.value.mtu,
              initialData: 0,
              builder: (c, snapshot) => ListTile(
                title: const Text('MTU Size'),
                subtitle: Text('${snapshot.data} bytes'),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => deviceControl.device.value.requestMtu(223),
                ),
              ),
            ),
            StreamBuilder<List<BluetoothService>>(
              stream: deviceControl.device.value.services,
              initialData: const [],
              builder: (c, snapshot) {
                return Column(
                  children: deviceControl.buildServiceTiles(
                      snapshot.data as List<BluetoothService>),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
