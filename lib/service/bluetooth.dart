// import 'dart:typed_data';
// import '../model/data_model.dart';
//
// void _onDataReceived(Uint8List data){
//
//   List<RadarData> radarData = List<RadarData>.empty(growable: true);
//   bool inProgress = false;
//
//     _connection.input!.listen((data) {
//       _buffer += data;
//
//       while (true) {
//         // If there is a sample, and it is full sent
//         int index = _buffer.indexOf('.'.codeUnitAt(0));
//         // if (index >= 0 && _buffer.length - index >= 7) {
//         //   final DataSample sample = DataSample(
//         //       temperature1: (_buffer[index + 1] + _buffer[index + 2] / 100),
//         //       temperature2: (_buffer[index + 3] + _buffer[index + 4] / 100),
//         //       waterpHlevel: (_buffer[index + 5] + _buffer[index + 6] / 100),
//         //       timestamp: DateTime.now());
//         //   _buffer.removeRange(0, index + 7);
//         //
//         //   samples.add(sample);
//         //   notifyListeners(); // Note: It shouldn't be invoked very often - in this example data comes at every second, but if there would be more data, it should update (including repaint of graphs) in some fixed interval instead of after every sample.
//         //   //debugPrint("${sample.timestamp.toString()} -> ${sample.temperature1} / ${sample.temperature2}");
//         // }
//         // Otherwise break
//         //angle min 15 to max 165
//         //distance min 0 to max 2250
//         //max length of message = 3angle + 4distance + 1comma = 8
//         if(index >= 0 && _buffer.length - index >= 4){
//           int separator = _buffer.indexOf(','.codeUnitAt(0));
//           if(separator >= 0 && _buffer.length - separator >= 2){
//             //print data
//             String angle=String.fromCharCodes(_buffer.sublist(0,separator));
//             String distance=String.fromCharCodes(_buffer.sublist(separator+1,index));
//             final RadarData sample = RadarData(
//               angle: angle,
//               distance: distance,
//             );
//             radarData.add(sample);
//             notifyListeners();
//             //remove data from buffer
//           }
//           _buffer.removeRange(0, index + 1);
//         }
//         else {
//           break;
//         }
//       }
//     }).onDone(() {
//       inProgress = false;
//       notifyListeners();
//     });
//
// }
