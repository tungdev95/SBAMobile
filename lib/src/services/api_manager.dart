import 'dart:io' show Platform;

import 'package:device_info/device_info.dart';
import 'package:diacritic/diacritic.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sba/src/models/base/request_header_model.dart';
import 'package:sba/src/screens/base/top_level_provider.dart';
import 'package:sba/src/services/token_refresh_interceptor.dart';
import 'package:sba/src/utils/app_constants.dart';

import '../models/login/user_model.dart';

class APIManager {
  APIManager();

  Dio initApiManager(Ref ref) {
    var baseUrl = AppConstants.kProUrl;

    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
      validateStatus: (status) {
        if ((status ?? 0) < 300) return true;
        return false;
      },
      contentType: 'application/json',
    );
    Dio dio = Dio(options);
    dio.interceptors
      ..add(AppInterceptor(ref))
      ..add(
        TokenRefreshInterceptor(
          dio: dio,
          ref: ref,
        ),
      )
      ..add(
        LogInterceptor(
          responseBody: false,
          requestBody: false,
          responseHeader: false,
          requestHeader: false,
        ),
      );

    return dio;
  }
}

class AppInterceptor extends Interceptor {
  RequestHeaderModel? header;
  Ref ref;

  AppInterceptor(this.ref);

  Future<void> getDeviceInfo() async {
    header ??= RequestHeaderModel();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      header
        ?..oS = 'android'
        ..deviceId = androidInfo.androidId
        ..deviceName = removeDiacritics(androidInfo.model);
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      header
        ?..oS = 'ios'
        ..deviceId = iosInfo.identifierForVendor
        ..deviceName = removeDiacritics(iosInfo.name);
    }
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options = await customRQ(options);
    super.onRequest(options, handler);
  }

  Future<RequestOptions> customRQ(RequestOptions options) async {
    if (header == null) await getDeviceInfo();
    var headers = options.headers;
    try {
      headers['OS'] = header?.oS ?? '';
      headers['DeviceId'] = header?.deviceId ?? '';
      headers['DeviceName'] = header?.deviceName ?? '';
      UserModel? userLogin = ref.read(appController).userLogin;
      if (userLogin != null) {
        headers['Authorization'] = 'Bearer ${userLogin.accessToken}';
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    options.headers = headers;
    return options;
  }
}
