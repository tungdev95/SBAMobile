// import '../../utils/styles.dart';

import 'dart:developer';

import 'package:sba/src/models/base/base.dart';

mixin ResponseSerializable<T> {
  // ResponseSerializable();
  T? fromJson(json);
  List<T?>? arrayFromJson(jsonArray) {
    List<T?> arr = [];
    if (jsonArray is List<dynamic>) {
      jsonArray.forEach((json) {
        arr.add(fromJson(json));
      });
    }
    return arr;
  }
}

// int parseInt(dynamic value) => convertToInt(value);

class ServerResponse<T> {
  T? data;
  int? code;
  String? message;
  ServerResponse({this.data, this.code, this.message});

  ServerResponse<T> parseJson(
      json, T Function(Map<String, Object?>)? instance) {
    try {
      var data;
      var code = 200;
      if (json == null) {
        data = null;
      } else {
        if (instance != null) {
          data = instance.call(json?['data'] ?? json);
        } else {
          data = json;
        }
      }
      return ServerResponse(
        data: data,
        code: (json['code'] as int?) ?? 200,
        message: json['message'] as String? ?? '',
      );
    } catch (e) {
      log('Lỗi parse json', error: e);
      return ServerResponse(
        data: null,
      );
    }
  }

  ServerResponse<T> postResponseJson(
      json, T Function(Map<String, Object?>)? instance) {
    try {
      return ServerResponse(
        data: json?['data'],
        code: json['code'] as int? ?? 200,
        message: json['message'] as String? ?? '',
      );
    } catch (e) {
      log('Lỗi parse json', error: e);
      return ServerResponse(
        data: null,
        code: 201,
        message: e.toString(),
      );
    }
  }
}

class ServerResponseArray<T> {
  List<T>? data;
  int? code;

  ServerResponseArray({this.data, this.code});

  ServerResponseArray<T> parseJson(
      json, T Function(Map<String, Object?>)? instance) {
    try {
      List<T>? result;
      if (instance == null) {
        return ServerResponseArray(
          data: json,
        );
      }
      if (json is List) {
        //Handle riêng trường hợp list item
        return ServerResponseArray(
          data: json.map<T>((e) => instance.call(e)).toList(),
        );
      } else if (json?['data'] is List) {
        return ServerResponseArray(
          data: (json?['data'] ?? []).map<T>((e) => instance.call(e)).toList(),
        );
      }
      var dataResponse = json?['data'];
      int? itemSize = json?['size'] as int?;
      if (json == null) {
        result = null;
      } else {
        if (dataResponse is List) {
          result = dataResponse.map<T>((e) => instance.call(e)).toList();
        }
      }
      return ServerResponseArray(
        data: result,
      );
    } on TypeError catch (e) {
      print(e.stackTrace.toString());
      throw AppException('Lỗi parse json: ${e.toString()}');
      // return ServerResponseArray(
      //   data: null,
      // );
    }
  }
}
