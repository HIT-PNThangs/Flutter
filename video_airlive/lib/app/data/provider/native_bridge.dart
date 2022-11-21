import 'dart:io';
import 'package:flutter/services.dart';

import '../../util/app_validation.dart';

class NativeBridge {
  static final _instance = NativeBridge._internal();

  NativeBridge._internal();

  static NativeBridge getInstance() {
    return _instance;
  }

  static final platformFramework = MethodChannel('com.vietapps.airlive/framework');
  static final String tag = '--NativeBridge ${Platform.operatingSystem}--: ';

  Future<NativeResponseModel<String>> nativeEditPhoto(String inPath, String outPath) async {
    try {
      final String result =
          await platformFramework.invokeMethod('editPhoto', <String, dynamic>{'inPath': inPath, 'outPath': outPath});
      print('editPhoto:$result');
      if (!isNullEmpty(result)) {
        printMessage(result);
        return NativeResponseModel(true, result, null);
      } else {
        printMessage('null', isError: true);
        return NativeResponseModel(false, result, null);
      }
    } on PlatformException catch (e) {
      printMessage(e.message ?? '', isError: true);
      return NativeResponseModel(false, null, e);
    }
  }

  Future<NativeResponseModel<String>> nativeCheckIfWatchAvailable() async {
    try {
      final String result = await platformFramework.invokeMethod('checkIfWatchAvailable', <String, dynamic>{});
      print('checkIfWatchAvailable:$result');
      if (!isNullEmpty(result)) {
        printMessage(result);
        return NativeResponseModel(true, result, null);
      } else {
        printMessage('null', isError: true);
        return NativeResponseModel(false, result, null);
      }
    } on PlatformException catch (e) {
      printMessage(e.message ?? '', isError: true);
      return NativeResponseModel(false, null, e);
    }
  }

  Future<NativeResponseModel<String>> nativeSendImageToWatch(String path) async {
    try {
      final String result = await platformFramework.invokeMethod('sendImageToWatch', <String, dynamic>{'path': path});
      print('sendImageToWatch:$result');
      if (!isNullEmpty(result)) {
        printMessage(result);
        return NativeResponseModel(true, result, null);
      } else {
        printMessage('null', isError: true);
        return NativeResponseModel(false, result, null);
      }
    } on PlatformException catch (e) {
      printMessage(e.message ?? '', isError: true);
      return NativeResponseModel(false, null, e);
    }
  }

  printMessage(String message, {bool isError = false}) {
    if (isError) {
      print('ERROR$tag$message');
    } else {
      print(tag + message.toString());
    }
  }
}

class NativeResponseModel<T> {
  bool? isSuccess = false;
  T? data;
  PlatformException? error;

  NativeResponseModel(this.isSuccess, this.data, this.error);
}
