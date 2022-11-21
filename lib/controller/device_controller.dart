import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';

import '../components/widgets.dart';

class DeviceController extends GetxController {
  Rx<BluetoothDevice> device =
      Rx<BluetoothDevice>(Get.arguments as BluetoothDevice);
  RxList<BluetoothService> services = RxList<BluetoothService>([]);
  RxList<BluetoothCharacteristic> characteristics =
      RxList<BluetoothCharacteristic>([]);
  RxList<BluetoothDescriptor> descriptors = RxList<BluetoothDescriptor>([]);

  //instead of big object set all the parameters manually

  List<int> getRandomBytes() {
    final math = Random();
    return [
      math.nextInt(255),
      math.nextInt(255),
      math.nextInt(255),
      math.nextInt(255)
    ];
  }

  @override
  void onInit() {
    super.onInit();
    device.value.discoverServices().then((value) {
      services.value = value;
    });
    listenToBluetoothData();
  }

  void onReadPressed(BluetoothCharacteristic characteristic) {
    characteristic.read();
  }

  void onWritePressed(BluetoothCharacteristic characteristic) {
    characteristic.write([1, 2, 3, 4], withoutResponse: true);
  }

  void onNotificationPressed(BluetoothCharacteristic characteristic) {
    characteristic.setNotifyValue(!characteristic.isNotifying);
  }

  void onReadDescriptorPressed(BluetoothDescriptor descriptor) {
    descriptor.read();
  }

  void onWriteDescriptorPressed(BluetoothDescriptor descriptor) {
    descriptor.write([1, 2, 3, 4]);
  }

  List<Widget> buildServiceTiles(List<BluetoothService> services) {
    return services
        .map(
          (s) => ServiceTile(
            service: s,
            characteristicTiles: s.characteristics
                .map(
                  (c) => CharacteristicTile(
                    characteristic: c,
                    onReadPressed: () => c.read(),
                    onWritePressed: () async {
                      await c.write(getRandomBytes(), withoutResponse: true);
                      await c.read();
                    },
                    onNotificationPressed: () async {
                      await c.setNotifyValue(!c.isNotifying);
                      await c.read();
                    },
                    descriptorTiles: c.descriptors
                        .map(
                          (d) => DescriptorTile(
                            descriptor: d,
                            onReadPressed: () => d.read(),
                            onWritePressed: () => d.write(getRandomBytes()),
                          ),
                        )
                        .toList(),
                  ),
                )
                .toList(),
          ),
        )
        .toList();
  }

  //Listen to bluetooth data and print it to the console
  void listenToBluetoothData() {
    device.value.state.listen((event) {
      debugPrint('/----------Bluetooth Device Data----------/');
      debugPrint('Device Name: ${device.value.name}');
      debugPrint('Device ID: ${device.value.id}');
      debugPrint('Device State: ${device.value.state}');
      debugPrint('Device Services: ${device.value.services}');
      debugPrint('Device MTU Size: ${device.value.mtu}');
      debugPrint(
          'Device isDiscoveringServices: ${device.value.isDiscoveringServices}');
      debugPrint('/----------Bluetooth Device Data----------/');
    });
  }
}
