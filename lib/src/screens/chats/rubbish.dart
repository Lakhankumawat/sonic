// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
//
// class RadarData{
//   String distance;
//   String angle;
//   RadarData({required this.distance, required this.angle});
// }
//
//
// class BackgroundCollectingTask extends Model {
//   static BackgroundCollectingTask of(
//     BuildContext context, {
//     bool rebuildOnChange = false,
//   }) =>
//       ScopedModel.of<BackgroundCollectingTask>(
//         context,
//         rebuildOnChange: rebuildOnChange,
//       );
//
//   final BluetoothConnection _connection;
//   List<int> _buffer = List<int>.empty(growable: true);
//
//   // @TODO , Such sample collection in real code should be delegated
//   // (via `Stream<DataSample>` preferably) and then saved for later
//   // displaying on chart (or even stright prepare for displaying).
//   // @TODO ? should be shrinked at some point, endless colleting data would cause memory shortage.
//   List<DataSample> samples = List<DataSample>.empty(growable: true);
//
//
//   static Future<BackgroundCollectingTask> connect(
//       BluetoothDevice server) async {
//     final BluetoothConnection connection =
//         await BluetoothConnection.toAddress(server.address);
//     return BackgroundCollectingTask._fromConnection(connection);
//   }
//
//   void dispose() {
//     _connection.dispose();
//   }
//
//   Future<void> start() async {
//     inProgress = true;
//     _buffer.clear();
//     samples.clear();
//     notifyListeners();
//     _connection.output.add(ascii.encode('start'));
//     await _connection.output.allSent;
//   }
//
//   Future<void> cancel() async {
//     inProgress = false;
//     notifyListeners();
//     _connection.output.add(ascii.encode('stop'));
//     await _connection.finish();
//   }
//
//   Future<void> pause() async {
//     inProgress = false;
//     notifyListeners();
//     _connection.output.add(ascii.encode('stop'));
//     await _connection.output.allSent;
//   }
//
//   Future<void> reasume() async {
//     inProgress = true;
//     notifyListeners();
//     _connection.output.add(ascii.encode('start'));
//     await _connection.output.allSent;
//   }
//
//   Iterable<DataSample> getLastOf(Duration duration) {
//     DateTime startingTime = DateTime.now().subtract(duration);
//     int i = samples.length;
//     do {
//       i -= 1;
//       if (i <= 0) {
//         break;
//       }
//     } while (samples[i].timestamp.isAfter(startingTime));
//     return samples.getRange(i, samples.length);
//   }
// }
