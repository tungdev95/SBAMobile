import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:vnpt_smartca_module/configs/app_config.dart';
import 'package:vnpt_smartca_module/core/models/response/service_response.dart';
import 'package:vnpt_smartca_module/data/network/smartca_api_gateway.dart';

class ForgotPasswordApi {
  final SmartCAApiGateway _httpClientService;

  ForgotPasswordApi(this._httpClientService);

  Future<SmartCAApiResponse> resetPasswordWithOtp(dynamic param) async {
    String url = "/${AppConfig.language}/identityapi/user/reset-password-with-otp";
    final result = await _httpClientService.post(url, param);
    return SmartCAApiResponse.fromMap(result);
  }

  Future<SmartCAApiResponse> getInfo(dynamic param) async {
    String url = "/${AppConfig.language}/identityapi/userinfo/info_by_anonymous";
    final result = await _httpClientService.post(url, param);
    return SmartCAApiResponse.fromMap(result);
  }

  Future<SmartCAApiResponse> getOTP(dynamic param) async {
    String url = "/verify/otp/send_otp";
    final result = await _httpClientService.post(url, param);
    return SmartCAApiResponse.fromMap(result);
  }
}