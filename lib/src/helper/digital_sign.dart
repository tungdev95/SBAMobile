import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:vnpt_smartca_module/core/models/app/smartca_message_result.dart';

class DigitalSign {
  static const platform = MethodChannel('com.sacombank.cmv/digitalSign');
  DigitalSign._instance();
  static final DigitalSign instance = DigitalSign._instance();
  bool initialized = false;

  Future<bool> initSDK() async {
    try {
      final result = await platform.invokeMethod<bool>('initSmartCa');
      initialized = true;
      return result ?? false;
    } on PlatformException catch (_) {
      return false;
    } on Exception catch (_) {
      return false;
    }
  }

  Future<String?> getAuthentication() async {
    try {
      if (!initialized) {
        initialized = await initSDK();
      }
      final result = await platform.invokeMethod<dynamic>('getAuthentication');
      if (result is Map) {
        final authenResult =
            SmartCaResult.fromMap((result as Map<Object?, Object?>).cast());
        final data = jsonDecode(authenResult.data);
        return data['accessToken'];
      }
      return null;
    } on PlatformException catch (_) {
      return null;
    } on Exception catch (_) {
      return null;
    }
  }

  Future<SmartCaResult?> startSign(String transId) async {
    try {
      if (!initialized) {
        initialized = await initSDK();
      }
      final result = await platform.invokeMethod<dynamic>(
        'startSign',
        {'transId': transId},
      );
      if (result is Map) {
        final signResult =
            SmartCaResult.fromMap((result as Map<Object?, Object?>).cast());
        return signResult;
      }
      return null;
    } on PlatformException catch (_) {
      return null;
    } on Exception catch (_) {
      return null;
    }
  }

  Future<SmartCaResult?> getMainInfo() async {
    try {
      if (!initialized) {
        initialized = await initSDK();
      }
      final result = await platform.invokeMethod<dynamic>(
        'getMainInfo',
      );
      // if (result is Map) {
      //   final mainInfoResult =
      //       SmartCaResult.fromMap(result as Map<String, dynamic>);
      //   final data = jsonDecode(mainInfoResult.data);
      //   return data;
      // }
      if (result is Map) {
        final signResult =
            SmartCaResult.fromMap((result as Map<Object?, Object?>).cast());
        return signResult;
      }
      return null;
    } on PlatformException catch (_) {
      return null;
    } on Exception catch (_) {
      return null;
    }
  }

  Future<bool?> destroySDK() async {
    try {
      if (!initialized) {
        initialized = await initSDK();
      }
      final result = await platform.invokeMethod<bool?>(
        'destroySDK',
      );
      return result;
    } on PlatformException catch (_) {
      return false;
    } on Exception catch (_) {
      return false;
    }
  }
}
