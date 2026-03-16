// ignore_for_file: prefer_const_constructors

import 'package:flutter/services.dart';
import 'package:vnpt_smartca_module/method_channel_handler.dart';

import '../../configs/injector/injector.dart';
import '../models/app/econtract_api_config.dart';

class ContractService {
  final eContractApiGWConfig = getIt<EContractApiGWConfig>();
  final MethodChannel _channel =
      const MethodChannel('com.vnpt.smartca/econtract');
  final hostMethodChannelHandler = MethodChannelHandler();

  Map<String, dynamic>? data;

  ContractService() {
    activeEContract();
  }

  activeEContract() async {
    await hostMethodChannelHandler.send(
        method: MethodChannelNames.activeEContract);
    return;
  }

  signContract(String token, String orderId) async {
    try {
      data = {
        "tokenKey": eContractApiGWConfig.tokenKey,
        "tokenId": eContractApiGWConfig.tokenId,
        "domain": eContractApiGWConfig.domain,
        "access_token": token,
        "orderId": orderId
      };
      _channel.invokeMethod('configContract', data);
      await Future.delayed(Duration(milliseconds: 100));
      var dataReturn = await _channel.invokeMethod('showContract', data);
      return dataReturn;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
