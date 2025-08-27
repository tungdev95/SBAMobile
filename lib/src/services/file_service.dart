import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/models/base/base_api_model.dart';
import 'base_api_services.dart';

const String defaultPath = '/Minute/UploadFile';
final fileServiceProvider = Provider<FileService>((ref) {
  var fileService = FileService(ref.read(dioProvider));
  ref.onDispose(() {
    fileService.dispose();
  });
  return fileService;
});

class FileService extends BaseApi {
  final String baseURL = 'file_composite';
  String fakeServerName = '';
  String uploadUrl = '';
  String fileUploadUrl = '';

  FileService(super.dio);

  Future<Attachment?> sendImage(
    AttachmentFile? file, {
    String? code,
    ProgressCallback? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    final multiPartFile = await file?.toMultipartFile();
    final response = await upload<Attachment>(
      'bussiness/api/v1/uploadMultiFiles/assetImage/sv',
      multiPartFile: multiPartFile,
      onSendProgress: onSendProgress,
      cancelToken: cancelToken,
      params: code != null ? {'code': code} : null,
      instance: Attachment.fromJson,
    );
    if (response.status == Status.error || response.data == null) {
      throw AppException(response.exception?.message ?? 'Lỗi upload tài liệu');
    }
    return response.data;
  }

  Future<ApiResponse<Attachment?>> sendFile(
    AttachmentFile? file, {
    String fileType = 'legalDocument',
    ProgressCallback? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      final multiPartFile = await file?.toMultipartFile();
      var formData = FormData.fromMap(
        {
          'file': multiPartFile,
        },
      );
      final responseResult = await dio.post(
        'bussiness/api/v1/uploadECMFile?fileType=$fileType',
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
        data: formData,
      );
      ServerResponse<Attachment?> result = ServerResponse();
      result =
          result.parseJson(responseResult.data['body'], Attachment.fromJson);
      return handleResponse<Attachment?>(
        result,
      );
    } catch (e) {
      return ApiResponse.error(AppException());
    }
  }

  Future deleteImage(
    String url,
    String channelId,
    String channelType, {
    CancelToken? cancelToken,
    Map<String, Object?>? extraData,
  }) async {
    return;
    // EmptyResponse.fromJson({});
  }

  Future deleteFile(
    String url,
    String channelId,
    String channelType, {
    CancelToken? cancelToken,
    Map<String, Object?>? extraData,
  }) async {
    // return EmptyResponse.fromJson({});
  }
}

class UploadParamsModel {
  Uint8List? fileData;
  String? fileName;
  String? minutesID;
  String? locateLatLong;
  String? locationCheckIn;
  String? fileType;
  int? photoOrientation;
  String path;
  UploadParamsModel(
    this.fileData,
    this.fileName,
    this.minutesID, {
    this.locateLatLong,
    this.locationCheckIn,
    this.fileType,
    this.photoOrientation,
    this.path = defaultPath,
  });
}
