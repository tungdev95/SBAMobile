import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sba/src/services/base_api_services.dart';

final pdfApiProvider = Provider<PdfApi>((ref) {
  var result = PdfApi(ref.read(dioProvider));
  ref.onDispose(result.dispose);
  return result;
});

class PdfApi extends BaseApi {
  PdfApi(super.dio);

  ///Lấy pdf biên bản khảo sát
  Future<Response<Uint8List?>> getSurveyDetail({
    required String appraisalFileId,
    List<int>? typeExport,
  }) async {
    final Response<Uint8List?> result = await dio.post(
      'assets/api/v1/surveyReport/surveyReport',
      data: {
        'appraisalFileId': appraisalFileId,
        'typeExport': typeExport ?? [0],
      },
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );
    return result;
  }

  ///Lấy pdf trình ký
  Future<Response<Uint8List?>> getSubmissionPdf({
    required String appraisalFileId,
  }) async {
    try {
      final Response<Uint8List?> result = await dio.get(
        'report/api/v1/report/$appraisalFileId',
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );
      return result;
    } catch (e) {
      return Response(
        requestOptions: RequestOptions(),
        data: null,
      );
    }
  }

  ///Lấy pdf kết quả
  Future<Response<Uint8List?>> getSignPdf({
    required String appraisalFileId,
    int? page,
  }) async {
    try {
      final Response<Uint8List?> result = await dio.get(
        'report/api/v1/signature/appraisal',
        options: Options(
          responseType: ResponseType.bytes,
        ),
        queryParameters: {
          'appraisalFileId': appraisalFileId,
          'page': page ?? 1,
        },
      );
      return result;
    } catch (e) {
      return Response(
        requestOptions: RequestOptions(),
        data: null,
      );
    }
  }
}
