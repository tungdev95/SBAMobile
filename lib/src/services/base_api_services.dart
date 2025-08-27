import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/services/api_manager.dart';

import '../models/base/base_api_model.dart';
import '../models/base/response_serialization.dart';

final dioProvider = StateProvider<Dio>((ref) {
  return APIManager().initApiManager(ref);
});

enum Method {
  get,
  post,
  put,
  delete,
}

abstract class BaseApi {
  final Dio dio;
  final Map<String, CancelToken?> mapCancelToken = {};
  CancelToken token = CancelToken();
  BaseApi(this.dio);

  Future<ApiResponse<T?>> createRequest<T>(
    String path, {
    Method? method = Method.post,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, Object?>)? instance,
    Options? options,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      Response responseResult;
      if (method == Method.post) {
        responseResult = await dio.post(
          path,
          data: json.encode(data),
          cancelToken: cancelToken,
          queryParameters: queryParameters,
          options: options,
          onReceiveProgress: onReceiveProgress,
        );
      } else if (method == Method.put) {
        responseResult = await dio.put(
          path,
          data: json.encode(data ?? {}),
          cancelToken: cancelToken,
          queryParameters: queryParameters,
          options: options,
          onReceiveProgress: onReceiveProgress,
        );
      } else if (method == Method.delete) {
        responseResult = await dio.delete(
          path,
          data: json.encode(data),
          queryParameters: queryParameters,
          cancelToken: cancelToken,
          options: options,
        );
      } else {
        responseResult = await dio.get(
          path,
          queryParameters: queryParameters ?? data,
          cancelToken: cancelToken,
          options: options,
        );
      }
      // log(jsonEncode(responseResult.data));

      if (instance == null) {
        return ApiResponse.completed(responseResult.data);
      }

      ServerResponse<T?> result = ServerResponse();
      // try {
      result = result.parseJson(responseResult.data, instance);
      if (result.data == null) {
        result = result.postResponseJson(responseResult.data, instance);
      }
      // } catch (e) {
      //   if (result.data == null) {
      //     result = result.postResponseJson(responseResult.data, instance);
      //   }
      // }

      return handleResponse<T?>(
        result,
        retry: () async {
          return createRequest(path, data: data, instance: instance);
        },
      );
    } on DioException catch (e) {
      return handleError<T?>(e);
    } on Error catch (e) {
      return ApiResponse.error(AppException(e.stackTrace.toString()));
    }
  }

  Future<ApiResponse<T?>> upload<T>(
    String path, {
    // required String filePath,
    Map<String, dynamic>? params,
    MultipartFile? multiPartFile,
    void Function(int, int)? onSendProgress,
    CancelToken? cancelToken,
    Map<String, dynamic>? data,
    required T Function(Map<String, Object?>)? instance,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var formData = FormData.fromMap(
        {
          'files': multiPartFile,
        },
      );
      final responseResult = await dio.post(
        path,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
        queryParameters: params,
        data: formData,
      );
      ServerResponse<T?> result = ServerResponse();
      result = result.parseJson(
          (responseResult.data['body'] as List).first, instance);
      return handleResponse<T?>(
        result,
        retry: () async {
          return createRequest(path, data: data, instance: instance);
        },
      );
    } on DioException catch (e) {
      return handleError<T?>(e);
    } on Exception catch (e) {
      return ApiResponse.error(AppException(e.toString()));
    }
  }

  Future<ApiResponse<List<T>?>> createRequestResponseArray<T>(
    String path, {
    Method? method = Method.post,
    Object? data,
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, Object?>)? instance,
    Options? options,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      Response responseResult;
      if (method == Method.post) {
        responseResult = await dio.post(
          path,
          data: json.encode(data),
          cancelToken: cancelToken,
          options: options,
          onReceiveProgress: onReceiveProgress,
        );
      } else if (method == Method.put) {
        responseResult = await dio.put(
          path,
          data: json.encode(data ?? {}),
          cancelToken: cancelToken,
          queryParameters: queryParameters,
          options: options,
          onReceiveProgress: onReceiveProgress,
        );
      } else if (method == Method.delete) {
        responseResult = await dio.delete(
          path,
          data: json.encode(data),
          cancelToken: cancelToken,
          options: options,
        );
      } else {
        responseResult = await dio.get(
          path,
          queryParameters: queryParameters,
          cancelToken: cancelToken,
          options: options,
        );
      }
      // if (responseResult.data is List) {
      //   log((responseResult.data as List)
      //       .map((e) => jsonEncode(e))
      //       .toList()
      //       .toString());
      // } else {
      //   log(jsonEncode(responseResult.data));
      // }
      ServerResponseArray<T> result = ServerResponseArray();
      result = result.parseJson(responseResult.data, instance);
      return handleResponseArray<T>(
        result,
      );
    } on DioException catch (e) {
      return handleError<List<T>?>(e);
    } on Exception catch (e) {
      return ApiResponse.error(AppException(e.toString()));
    }
  }

  Future<ApiResponse<T?>> handleError<T>(DioException e) async {
    try {
      if (e.type == DioExceptionType.cancel) {
        return ApiResponse.completed(null);
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return ApiResponse.error(ActionTimeoutException());
      } else if (e.type == DioExceptionType.badResponse) {
        if (e.response?.statusCode == StatusCode.kTokenExpired) {
          return ApiResponse.error(
            AppException('Phiên làm việc hết hạn, vui lòng đăng nhập lại!',
                StatusCode.kTokenExpired),
          );
        } else if (e.response?.statusCode == 404) {
          return ApiResponse.error(InvalidPathException());
        }
        return ApiResponse.error(
          AppException(
              e.response?.data['message'] ?? e.response?.data['error'] ?? '',
              e.response?.statusCode),
        );
      } else {
        return ApiResponse.error(AppException());
      }
    } catch (e) {
      return ApiResponse.error(AppException());
    }
  }

  Future<ApiResponse<T?>> handleResponse<T>(ServerResponse<T?>? serverResponse,
      {Future<ApiResponse<T?>> Function()? retry}) async {
    final code = serverResponse?.code;
    if (code != null && code > 200) {
      return ApiResponse.error(AppException(serverResponse?.message, code));
    }
    if (serverResponse != null) {
      return ApiResponse.completed(serverResponse.data);
    }
    if (retry != null) {
      return ApiResponse.completed(serverResponse?.data);
    }
    return ApiResponse.error(AppException(S.current.co_loi_xay_ra));
  }

  Future<ApiResponse<List<T>?>> handleResponseArray<T>(
      ServerResponseArray<T>? serverResponse,
      {Future<ApiResponse<List<T>?>> Function()? retry}) async {
    if (serverResponse != null) {
      // if (serverResponse.code == StatusCode.kTokenExpired) {
      //   return ApiResponse.error(TokenExpiredException());
      // } else if (serverResponse.code != 0) {
      //   return ApiResponse.error(
      //     AppException(
      //         serverResponse.message ?? "Có lỗi xảy ra, vui lòng thử lại sau!",
      //         serverResponse.code),
      //   );
      // }
      return ApiResponse.completed(serverResponse.data);
    }
    if (retry != null) {
      return ApiResponse.completed(serverResponse?.data);
    }
    return ApiResponse.error(AppException());
  }

  void dispose() {
    try {
      token.cancel();
    } catch (e) {
      log('Cancel token error: $e');
    }
  }
}
