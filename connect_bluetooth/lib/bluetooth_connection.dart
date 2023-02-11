import 'package:flutter/services.dart';

class BluetoothConnection {
  static const MethodChannel _channel = MethodChannel('com.example.flutter_bluetooth/connect_bluetooth');

  Future<void> connectDevice(String macAddress) async {
    await _channel.invokeMethod('CONNECT_BLUETOOTH', {"mac_address": macAddress});
  }
}
