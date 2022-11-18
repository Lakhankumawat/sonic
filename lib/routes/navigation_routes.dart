import 'package:flutter/cupertino.dart';
import 'package:sonic/src/screens/bluetooth_off/bluetooth_off.dart';
import 'package:sonic/src/screens/clockView/clock.dart';
import 'package:sonic/src/screens/device/devices.dart';
import 'package:sonic/src/screens/find_device/find_device.dart';
import 'package:sonic/src/screens/permission/permission.dart';
import 'package:sonic/src/screens/radar/radarPage.dart';

import '../src/screens/chats/chats.dart';
import '../src/screens/home/home.dart';

final Map<String, WidgetBuilder> routes = {
  Home.routeName: (context) => Home(),
  DeviceScreen.routeName: (context) => DeviceScreen(),
  FindDevicesScreen.routeName: (context) => FindDevicesScreen(),
  BluetoothOffScreen.routeName: (context) => const BluetoothOffScreen(),
  PermissionsPage.routeName: (context) => PermissionsPage(),
  ChatPage.routeName: (context) => ChatPage(),
  RadarPage.routeName: (context) => RadarPage(),
  RadarView.routeName: (context) => RadarView(),
};
