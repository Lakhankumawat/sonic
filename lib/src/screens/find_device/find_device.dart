import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:sonic/controller/find_device_controller.dart';
import '../radar/radar.dart';
import 'list_devices.dart';

class FindDevicesScreen extends StatelessWidget {
  static String routeName = '/find_devices';
  final FindDeviceController _dc = Get.put(FindDeviceController());

  FindDevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            _dc.isLoading.value ? 'Discovering Devices' : 'Discovered devices',
          ),
        ),
        actions: <Widget>[
          _dc.isLoading.value
              ? FittedBox(
                  child: Container(
                    margin: const EdgeInsets.all(16.0),
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                )
              : IconButton(
                  icon: const Icon(Icons.replay),
                  onPressed: _dc.restartDiscovery,
                )
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: _dc.results.length,
          itemBuilder: (BuildContext context, index) {
            BluetoothDiscoveryResult result = _dc.results[index];
            final device = result.device;
            final address = device.address;
            return BluetoothDeviceListEntry(
              device: device,
              rssi: result.rssi,
              onTap: () {
                Get.toNamed(RadarView.routeName, arguments: address);
              },
              onLongPress: () async {
                try {
                  bool bonded = false;
                  if (device.isBonded) {
                    debugPrint('Unbonding from ${device.address}...');
                    await FlutterBluetoothSerial.instance
                        .removeDeviceBondWithAddress(address);
                    debugPrint('Unbonding from ${device.address} has succed');
                  } else {
                    debugPrint('Bonding with ${device.address}...');
                    bonded = (await FlutterBluetoothSerial.instance
                        .bondDeviceAtAddress(address))!;
                    debugPrint(
                        'Bonding with ${device.address} has ${bonded ? 'succed' : 'failed'}.');
                  }

                  _dc.results[_dc.results.indexOf(result)] =
                      BluetoothDiscoveryResult(
                          device: BluetoothDevice(
                            name: device.name ?? '',
                            address: address,
                            type: device.type,
                            bondState: bonded
                                ? BluetoothBondState.bonded
                                : BluetoothBondState.none,
                          ),
                          rssi: result.rssi);
                } catch (ex) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error occured while bonding'),
                        content: Text(ex.toString()),
                        actions: <Widget>[
                          TextButton(
                            child: const Text("Close"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            );
          },
        ),
      ),
      // body: RefreshIndicator(
      //   onRefresh: () => _dc.,
      //   child: SingleChildScrollView(
      //     child: Column(
      //       children: <Widget>[
      //         StreamBuilder<List<BluetoothDevice>>(
      //           stream: Stream.periodic(const Duration(seconds: 2))
      //               .asyncMap((_) => FlutterBlue.instance.connectedDevices),
      //           initialData: const [],
      //           builder: (c, snapshot) => snapshot.hasData
      //               ? Column(
      //                   children: snapshot.data!
      //                       .map((d) => ListTile(
      //                             title: Text(d.name),
      //                             subtitle: Text(d.id.toString()),
      //                             trailing: StreamBuilder<BluetoothDeviceState>(
      //                               stream: d.state,
      //                               initialData:
      //                                   BluetoothDeviceState.disconnected,
      //                               builder: (c, snapshot) {
      //                                 if (snapshot.data ==
      //                                     BluetoothDeviceState.connected) {
      //                                   Navigator.of(context).pushNamed(
      //                                       DeviceScreen.routeName,
      //                                       arguments: d);
      //                                 }
      //                                 return Text(snapshot.data.toString());
      //                               },
      //                             ),
      //                           ))
      //                       .toList(),
      //                 )
      //               : const Text('No devices connected'),
      //         ),
      //         StreamBuilder<List<ScanResult>>(
      //           stream: FlutterBlue.instance.scanResults,
      //           initialData: const [],
      //           builder: (c, snapshot) => snapshot.hasData
      //               ? Column(
      //                   children: snapshot.data
      //                       ?.map(
      //                         (r) => ScanResultTile(
      //                           result: r,
      //                           onTap: () async {
      //                             debugPrint('Connecting to device...${r.device.name}');
      //                             await r.device.connect();
      //
      //                             Navigator.of(context).pushNamed(
      //                                 DeviceScreen.routeName,
      //                                 arguments: r.device);
      //                           },
      //                         ),
      //                       )
      //                       .toList() as List<Widget>,
      //                 )
      //               : const Text('No devices found'),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      // floatingActionButton: StreamBuilder<bool>(
      //   stream: FlutterBlue.instance.isScanning,
      //   initialData: false,
      //   builder: (c, snapshot) {
      //     if (snapshot.data!) {
      //       return FloatingActionButton(
      //         onPressed: () => FlutterBlue.instance.stopScan(),
      //         backgroundColor: Colors.red,
      //         child: const Icon(Icons.stop),
      //       );
      //     } else {
      //       return Obx(
      //         () => _deviceController.isLoading.value
      //             ? const Center(
      //                 child: CircularProgressIndicator(),
      //               )
      //             : FloatingActionButton(
      //                 child: const Icon(Icons.search),
      //                 onPressed: () => _deviceController.refresh(),
      //               ),
      //       );
      //     }
      //   },
      // ),
    );
  }
}
