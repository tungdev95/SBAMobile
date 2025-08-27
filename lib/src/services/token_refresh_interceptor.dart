import 'package:aad_oauth/aad_oauth.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sba/sba_app.dart';
import 'package:sba/src/models/base/base_api_model.dart';
import 'package:sba/src/screens/base/top_level_provider.dart';
import 'package:sba/src/services/api/user_api.dart';
import 'package:sba/src/utils/dialog_utils.dart';
import 'package:vnpt_smartca_module/core/extensions/either_data.dart';

class TokenRefreshInterceptor extends QueuedInterceptor {
  final Dio dio;
  final Ref ref;
  bool _isRefreshing = false;

  TokenRefreshInterceptor({
    required this.dio,
    required this.ref,
  });

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final userLogin = ref.read(appController).userLogin;
    var refreshToken = userLogin?.refreshToken;
    String? accessToken = null;
    final statusCode = err.response?.statusCode;
    if (statusCode == 401 || statusCode == 403 && refreshToken != null) {
      if (!_isRefreshing) {
        _isRefreshing = true;
        try {
          final newTokens = await _refreshTokens();
          if (newTokens != null) {
            accessToken = newTokens['access_token'];
            refreshToken = newTokens['refresh_token'];

            // Retry failed request with new token
            final response = await _retryRequest(
              err.requestOptions,
              accessToken,
            );
            return handler.resolve(response);
          }
        } catch (e) {
          // If refresh fails, clear tokens and proceed with error
          await _clearTokens();
        } finally {
          _isRefreshing = false;
        }
      } else {
        // Wait for refresh to complete and retry
        while (_isRefreshing) {
          await Future.delayed(const Duration(milliseconds: 100));
        }
        if (accessToken != null) {
          final response = await _retryRequest(
            err.requestOptions,
            accessToken,
          );
          return handler.resolve(response);
        }
      }
    }
    return handler.next(err);
  }

  Future<Map<String, String>?> _refreshTokens() async {
    try {
      final AadOAuth oauth = ref.read(appController.notifier).oauth;
      final result = await oauth.refreshToken();
      if (result.isRight()) {
        final newTokens = result.asRight();
        final logInResponse = await ref.read(userApiProvider).loginWithToken(
              newTokens.idToken ?? '',
              newTokens.accessToken,
              newTokens.refreshToken,
            );
        final data = logInResponse.data;
        if (data != null) {
          ref.read(appController.notifier).logIn(data);
          return {
            'access_token': data.accessToken ?? '',
            'refresh_token': newTokens.refreshToken ?? '',
          };
        }
      }
    } catch (e) {
      // Refresh failed
    }
    return null;
  }

  Future<void> _clearTokens() async {
    await DialogUtils.showMessageDialog(
      SBAApp.navigatorKey.currentState!.context,
      TokenExpiredException().message,
    );
    ref.read(appController.notifier).doLogout();
  }

  Future<Response> _retryRequest(
    RequestOptions requestOptions,
    String? accessToken,
  ) {
    // final options = Options(
    //   method: requestOptions.method,
    //   headers: {
    //     ...requestOptions.headers,
    //     'Authorization': 'Bearer $accessToken',
    //   },
    // );

    return dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
    );
  }
}
