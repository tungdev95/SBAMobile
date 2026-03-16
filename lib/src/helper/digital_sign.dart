import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:vnpt_smartca_module/core/models/app/smartca_message_result.dart';

class DigitalSign {
  static const platform = MethodChannel('com.vnpt.flutter/partner');
  static const platformOld = MethodChannel('com.sacombank.cmv/digitalSign');

  DigitalSign._instance() {
    platform.setMethodCallHandler(_methodCallHandler);
    platformOld.setMethodCallHandler(_methodCallHandler);
  }
  static final DigitalSign instance = DigitalSign._instance();
  bool initialized = false;

  Future<void> _methodCallHandler(MethodCall call) async {
    switch (call.method) {
      case "getAuthenticationResult":
        print("getAuthenticationResult: ${call.arguments}");
        break;
      case "getWaitingTransactionResult":
        print("getWaitingTransactionResult: ${call.arguments}");
        break;
      case "getMainInfoResult":
        print("getMainInfoResult: ${call.arguments}");
        break;
      default:
        print("Unknown method: ${call.method}");
    }
  }

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

  Future<SmartCaResult?> getWaitingTransaction(String transId) async {
    try {
      if (!initialized) {
        initialized = await initSDK();
      }
      final result = await platform.invokeMethod<dynamic>(
        'getWaitingTransaction',
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

  Future<void> toMainPage() async {
    await platform.invokeMethod('getMainInfo');
  }

  Future<void> createAccount() async {
    await platform.invokeMethod('createAccount');
  }

  Future<void> signOut() async {
    await platform.invokeMethod('signOut');
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
