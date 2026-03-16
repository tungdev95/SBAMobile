// ignore_for_file: unnecessary_overrides

import 'dart:io';

import 'package:dio/dio.dart';

import '../../configs/injector/injector.dart';
import '../../core/models/app/device_info.dart';
import '../../core/models/app/smartca_api_config.dart';
import '../../core/models/response/token_model.dart';
import '../../core/services/device_info.dart';
import '../../core/services/secure_local_storage.dart';
import '../../core/utils/constants.dart';
import '../repository/authen_repository.dart';

final ignoreList = [
  "/auth/token",
  "/auth/refresh_token",
  "https://econtract-api-demo.vnptit3.vn/sso/exchange-sso-token",
  "https://econtract-api-poc.vnptit3.vn/sso/exchange-sso-token",
  "https://api-hopdong.vnpt.vn/sso/exchange-sso-token",
];

class AuthInterceptor extends Interceptor {
  late SecureLocalStorageService _secureLocalDataSource;
  late Dio _dio;
  late SmartCAApiConfig _smartCAApiConfig;
  final _deviceInfoService = getIt<DeviceInfoService>();

  String? appversion;
  DeviceInfoModel? deviceInfo;

  AuthInterceptor(SecureLocalStorageService secureLocalDataSource, Dio dio,
      SmartCAApiConfig smartCAApiConfig) {
    _secureLocalDataSource = secureLocalDataSource;
    _dio = dio;
    _smartCAApiConfig = smartCAApiConfig;
  }

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (!ignoreList.contains(options.path)) {
      final tokenString =
          await _secureLocalDataSource.getLastData(LOCAL_ACCESS_TOKEN_AUTH);

      deviceInfo ??= await _deviceInfoService.getDeviceInfo();

      if (tokenString != null) {
        var token = TokenModel.fromJson(tokenString);

        options.headers["Authorization"] = "Bearer ${token.accessToken}";
        try {
          options.headers["clientID"] = _smartCAApiConfig.clientId;
          options.headers["clientName"] = "SDK";
          options.headers["deviceId"] = deviceInfo!.deviceId;
          // options.headers["deviceName"] = deviceInfo!.deviceName;
          options.headers["osName"] = deviceInfo!.osName;
          options.headers["osVersion"] = deviceInfo!.osVersion;
          options.headers["branch"] = deviceInfo!.branch;
          options.headers["deviceModel"] = deviceInfo!.deviceModel;
          options.headers["appVersion"] = "1.0";
        } catch (e) {
          print(e);
        }
      }
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // super.onError(err, handler);
    Future.delayed(
      const Duration(seconds: 1),
      () => refreshTokenHandler(err, handler),
    );
  }

  refreshTokenHandler(
      DioException error, ErrorInterceptorHandler handler) async {
    if (error.response?.statusCode == HttpStatus.unauthorized ||
        error.response?.statusCode == HttpStatus.forbidden) {
      try {
        final authenRepository = getIt<AuthenRepository>();

        final tokenJson = await authenRepository.refreshToken();
        return tokenJson.fold((l) => handler.reject(error), (token) async {
          //set bearer
          error.requestOptions.headers["Authorization"] =
              "Bearer ${token.accessToken}";
          //create request with new access token
          final opts = Options(
              method: error.requestOptions.method,
              headers: error.requestOptions.headers);
          final cloneReq = await _dio.request(error.requestOptions.path,
              options: opts,
              data: error.requestOptions.data,
              queryParameters: error.requestOptions.queryParameters);

          return handler.resolve(cloneReq);
        });
      } catch (e) {
        return handler.reject(error);
      }
    }

    return handler.reject(error);
  }
}
