import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/base/top_level_provider.dart';

import '../../models/base/base_api_model.dart';
import '../../models/login/user_model.dart';
import '../base_api_services.dart';

final userApiProvider = Provider((ref) => UserApi(ref, ref.read(dioProvider)));

class UserApi extends BaseApi {
  static const String path = 'authentication/api/v1';
  final String _logOut = '$path/logout';
  ProviderRef<Object?> ref;
  UserApi(this.ref, super.dio);

  Future<ApiResponse<UserModel?>> login(String userName, String pass) async {
    try {
      var response = await createRequest<UserModel>(
        '$path/login',
        method: Method.post,
        data: {'username': userName, 'password': pass},
        instance: UserModel.fromJson,
      );
      if (response.status == Status.complete) {
        response.data = response.data?.copyWith(
          pass: pass,
          loginName: userName,
        );
      }
      return response;
    } catch (error) {
      return ApiResponse.error(AppException(error.toString()));
    }
  }

  Future<ApiResponse<UserModel?>> loginWithToken(
      String idToken, String? accessToken, String? refreshToken) async {
    try {
      var response = await dio.post(
        '$path/loginToken',
        data: {
          'tokenId': idToken,
          'accessToken': accessToken,
          'refreshToken': refreshToken,
        },
      );
      ServerResponse<UserModel?> result = ServerResponse();
      result = result.parseJson(response.data, UserModel.fromJson);
      if (result.data == null) {
        result = result.postResponseJson(result.data, UserModel.fromJson);
      }
      result.data = result.data?.copyWith(
        loginName: result.data?.username,
        refreshToken: refreshToken,
      );
      return ApiResponse.completed(result.data);
    } catch (error) {
      return ApiResponse.error(AppException(error.toString()));
    }
  }

  Future<ApiResponse<UserModel?>> logOut() async {
    try {
      final response = await createRequest<UserModel>(
        _logOut,
        method: Method.post,
        data: {},
        instance: (json) => UserModel.fromJson(json),
      );
      return response;
    } catch (error) {
      return ApiResponse.error(
        AppException(
          error.toString(),
        ),
      );
    }
  }

  Future<ApiResponse<UserModel?>> getUserProfile() async {
    try {
      final response = await createRequest(
        'admin/api/v1/staff',
        method: Method.get,
        queryParameters: {
          'username': ref.read(appController).userLogin?.loginName,
        },
        // instance: (json) => UserModel.fromJson(json),
      );
      final body = response.data['body'];
      if (body != null) {
        return ApiResponse.completed(UserModel.fromJson(body));
      }
      return ApiResponse.completed(null);
    } catch (error) {
      return ApiResponse.error(
        AppException(
          error.toString(),
        ),
      );
    }
  }
}
