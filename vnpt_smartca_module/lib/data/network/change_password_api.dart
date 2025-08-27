import 'dart:convert';

import 'package:injectable/injectable.dart';

import '../../configs/app_config.dart';
import '../../configs/injector/injector.dart';
import '../../core/models/response/profile_model.dart';
import '../../core/models/response/service_response.dart';
import '../../core/services/secure_local_storage.dart';
import '../../core/utils/constants.dart';
import 'smartca_api_gateway.dart';

@injectable
class ChangePasswordApi {
  final SmartCAApiGateway _httpClientService;

  ChangePasswordApi(this._httpClientService);

  final secureLocalDataSource = getIt<SecureLocalStorageService>();

  changePassword(String currentPassword, String newPassword) async {
    ProfileModel? userProfile;
    String? strProfile = await secureLocalDataSource.getLastData(LOCAL_USER_PROFILE);
    if (strProfile != null) {
      userProfile = ProfileModel.fromJson(json.decode(strProfile));
    }
    final result = await _httpClientService.post(
      '/${AppConfig.language}/identityapi/user/change_pass',
      {"uid": userProfile?.uid, "email": userProfile?.email, "password": currentPassword, "newpassword": newPassword},
    );
    return SmartCAApiResponse.fromMap(result);
  }
}
