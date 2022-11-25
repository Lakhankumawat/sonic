import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import '../model/data_model.dart';

class RadarController extends GetxController {
  late final BluetoothConnection _connection;
  List<int> _buffer = List<int>.empty(growable: true);
  RxList<RadarData> radarData = List<RadarData>.empty(growable: true).obs;

  RxBool inProgress = true.obs;
  RxBool isConnected = false.obs;
  RxBool isConnecting = true.obs;
  RxBool isDisconnecting = false.obs;
  RxDouble idistance = 0.0.obs;
  RxDouble iangle = 0.0.obs;
  final String? address;
  RxBool loading = true.obs;

  RadarController({required this.address});

  //-----------------InitState----------------//

  @override
  void onInit() async {
    //pass the address as parameter to onInit in the getx
    debugPrint("address is $address");
    if (address != null) {
      initData(address);
    }

    super.onInit();
  }

  @override
  void disposeId(Object id) {
    if (isConnected.value) {
      _connection.finish();
    }
    super.disposeId(id);
  }

  void initData(String? address) async {
    //connect to address and start listening
    BluetoothConnection.toAddress(address!).then((connection) {
      debugPrint('Connected to the device');
      _connection = connection;
      isConnected.value = true;
      connection.input!.listen(_processData).onDone(() {
        if (isDisconnecting.value) {
          debugPrint('Disconnecting locally!');
        } else {
          debugPrint('Disconnected remotely!');
        }
      });
    }).catchError((error) {
      debugPrint('Cannot connect, exception occured');
      debugPrint(error);
    });
  }

  void _processData(Uint8List data) {
    _buffer += data;

    while (true) {
      // If there is a sample, and it is full sent
      int index = _buffer.indexOf('.'.codeUnitAt(0));

      //angle min 15 to max 165
      //distance min 0 to max 2250
      //max length of message = 3angle + 4distance + 1comma = 8
      if (index >= 0 && _buffer.length - index >= 4) {
        int separator = _buffer.indexOf(','.codeUnitAt(0));
        if (separator >= 0 && _buffer.length - separator >= 2) {
          //print data
          String angle = String.fromCharCodes(_buffer.sublist(0, separator));
          String distance =
              String.fromCharCodes(_buffer.sublist(separator + 1, index));
          debugPrint("------angle : $angle , distance : $distance---------");
          iangle = double.parse(angle).obs;
          idistance = double.parse(distance).obs;
          //radarData.add(sample);
          //notifyListeners();
          //remove data from buffer
        }
        _buffer.removeRange(0, index + 1);
      } else {
        break;
      }
    }
  }
}
