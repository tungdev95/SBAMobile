import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/assets/enum.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/services/api/assets_api.dart';

class AssetsApiFake extends AssetsApi {
  AssetsApiFake() : super(Dio());

  //Lấy danh sách tài sản
  @override
  Future<ApiResponse<List<AssetsModel>?>> getListAssets({
    required int page,
    required int? assetLevelOneId,
    required int? assetLevelTwoId,
    required FileStatus? fileStatus,
    CancelToken? cancelToken,
  }) async {
    String data = await rootBundle.loadString('assets/json/list_assets.json');
    var jsonResult = jsonDecode(data);
    ServerResponseArray<AssetsModel> result = ServerResponseArray();
    result = result.parseJson(jsonResult, AssetsModel.fromJson);
    return ApiResponse.completed(result.data);
  }

  @override
  Future<ApiResponse<List<AssetsDetailModel<T>>?>> getAssetDetail<T>(
      {required int assetLevelTwoId,
      required List<String> assetCodes,
      CancelToken? cancelToken}) async {
    if (assetLevelTwoId == 2) {
      String data =
          await rootBundle.loadString('assets/json/asset_detail_chcc.json');
      var jsonResult = jsonDecode(data);
      ServerResponseArray<AssetsDetailModel<T>> result = ServerResponseArray();
      result = result.parseJson(jsonResult, AssetsDetailModel.fromJson);
      return ApiResponse.completed(result.data);
    } else if (assetLevelTwoId == 3) {
      String data =
          await rootBundle.loadString('assets/json/asset_detail_ptdb.json');
      var jsonResult = jsonDecode(data);
      ServerResponseArray<AssetsDetailModel<T>> result = ServerResponseArray();
      result = result.parseJson(jsonResult, AssetsDetailModel.fromJson);
      return ApiResponse.completed(result.data);
    }

    return super.getAssetDetail(
        assetLevelTwoId: assetLevelTwoId, assetCodes: assetCodes);
  }

  @override
  Future<ApiResponse<AssetsModel?>> getAssetDetailFromFileId({
    required String appraisalFileId,
    CancelToken? cancelToken,
  }) async {
    String data = await rootBundle.loadString('assets/json/detail_ptdb.json');
    var jsonResult = jsonDecode(data);
    ServerResponse<AssetsModel> result = ServerResponse();
    result = result.parseJson(jsonResult, AssetsModel.fromJson);
    return ApiResponse.completed(result.data);
  }
}
