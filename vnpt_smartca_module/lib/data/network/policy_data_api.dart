import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:vnpt_smartca_module/configs/app_config.dart';
import 'package:vnpt_smartca_module/core/models/response/policy_data_response.dart';
import 'package:vnpt_smartca_module/core/models/response/service_response.dart';

import 'smartca_api_gateway.dart';

@injectable
class PolicyDataApi {
  final SmartCAApiGateway _httpClientService;

  PolicyDataApi(this._httpClientService);

  Future<SmartCAApiResponse> getPolicy(String uid) async {
    final result = await _httpClientService.post(
        '/${AppConfig.language}/thirdpartyapi/cmms/getND13', {"uid": uid},
        // options: Options(headers: {
        //   "authorization": "Bearer $accessToken",
        // })
        );
    return SmartCAApiResponse.fromMap(result);
  }

  Future<SmartCAApiResponse> updatePolicy(
      String uid, List<ND13Content> nD13content) async {
    final result = await _httpClientService.post(
        '/${AppConfig.language}/thirdpartyapi/cmms/updateND13',
        {"uid": uid, "nd13Content": nD13content},
        // options: Options(headers: {
        //   "authorization": "Bearer $accessToken",
        // })
        );
    return SmartCAApiResponse.fromMap(result);
  }
}
