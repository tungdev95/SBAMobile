import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/assets/enum.dart';
import 'package:sba/src/models/assets/ptdb_dropdown_model.dart';
import 'package:sba/src/models/assets/save_asset.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/models/login/user_model.dart';
import 'package:sba/src/services/base_api_services.dart';
import 'package:sba/src/utils/utils.dart';

final assetsApiProvider = Provider<AssetsApi>((ref) {
  var result = AssetsApi(ref.read(dioProvider));
  ref.onDispose(result.dispose);
  return result;
});

class AssetsApi extends BaseApi {
  final String path = 'bussiness/api/v1/mobile';
  AssetsApi(super.dio);

  //Lấy danh sách tài sản
  Future<ApiResponse<List<AssetsModel>?>> getListAssets({
    required int page,
    required int? assetLevelOneId,
    required int? assetLevelTwoId,
    required FileStatus? fileStatus,
    CancelToken? cancelToken,
  }) async {
    String path = 'bussiness/api/v1/appraisalFiless/staff/receive';
    if (fileStatus == FileStatus.daGuiKQThamDinh ||
        fileStatus == FileStatus.daGuiThongBao) {
      path = 'bussiness/api/v1/appraisalFiless/staff/send';
    }
    //send
    final result = await createRequestResponseArray<AssetsModel>(
      path,
      queryParameters: {
        'limit': kDefaultPageSize,
        'page': page,
        if (assetLevelOneId != null) 'assetLevelOneId': assetLevelOneId,
        if (assetLevelTwoId != null) 'assetLevelTwoId': assetLevelTwoId,
        if (fileStatus != null) 'fileStatusId': fileStatus.id,
        if (fileStatus == FileStatus.daGuiKQThamDinh) 'sendToEmail': 1,
      },
      method: Method.get,
      instance: AssetsModel.fromJson,
      cancelToken: cancelToken,
    );
    return result;
  }

  //Lấy danh sách hồ sơ đi
  Future<ApiResponse<List<AssetsModel>?>> getListAssetsSend({
    required int page,
    required int? assetLevelOneId,
    required int? assetLevelTwoId,
    required FileStatus? fileStatus,
    CancelToken? cancelToken,
  }) async {
    String path = 'bussiness/api/v1/appraisalFiless/staff/send';
    //send
    final result = await createRequestResponseArray<AssetsModel>(
      path,
      queryParameters: {
        'limit': kDefaultPageSize,
        'page': page,
        if (assetLevelOneId != null) 'assetLevelOneId': assetLevelOneId,
        if (assetLevelTwoId != null) 'assetLevelTwoId': assetLevelTwoId,
        if (fileStatus != null) 'fileStatusId': fileStatus.id,
      },
      method: Method.get,
      instance: AssetsModel.fromJson,
      cancelToken: cancelToken,
    );
    return result;
  }

  //Lấy chi tiết tài sản
  Future<ApiResponse<List<AssetsDetailModel<T>>?>> getAssetDetail<T>(
      {required int assetLevelTwoId,
      required List<String> assetCodes,
      CancelToken? cancelToken}) async {
    final result = await createRequestResponseArray<AssetsDetailModel<T>>(
      'assets/api/v1/entire/$assetLevelTwoId',
      data: assetCodes.map((e) => {'assetCode': e}).toList(),
      method: Method.post,
      instance: AssetsDetailModel.fromJson,
      cancelToken: cancelToken,
    );
    return result;
  }

  Future<Response<dynamic>> getAssetDetailRaw(
      {required int assetLevelTwoId, required List<String> assetCodes}) async {
    final result = await dio.post(
      'assets/api/v1/entire/$assetLevelTwoId',
      data: assetCodes.map((e) => {'assetCode': e}).toList(),
    );
    return result;
  }

  Future<ApiResponse<dynamic>> updateSurveyInfo({AssetsModel? data}) async {
    final result = await createRequest(
      'bussiness/api/v1/appraisalFiles',
      data: data,
      method: Method.put,
    );
    return result;
  }

  //Lấy danh sách hồ sơ pháp lý
  Future<ApiResponse<List<KeyValueModel>>> getListLegals(
      int? assetLevelTwoId) async {
    final result = await createRequestResponseArray<LegalInformationType>(
      'bussiness/api/v1/legalDocumentTypes',
      method: Method.get,
      instance: LegalInformationType.fromJson,
      queryParameters: {
        'assetLevelTwoId':
            (assetLevelTwoId == AssetsTypeEnum.ptdb.assetsLevel2Id ||
                    assetLevelTwoId == AssetsTypeEnum.mmtb.assetsLevel2Id ||
                    assetLevelTwoId == AssetsTypeEnum.ptdt.assetsLevel2Id)
                ? assetLevelTwoId
                : AssetsTypeEnum.bds.assetsLevel2Id,
      },
    );
    if (result.status == Status.complete) {
      return ApiResponse.completed(
        (result.data ?? [])
            .map(
              (e) => KeyValueModel(
                key: e.legalDocumentTypeId.toString(),
                title: e.name,
              ),
            )
            .toList(),
      );
    }
    return ApiResponse.error(result.exception);
  }

  ///Tỉnh
  Future<ApiResponse<List<KeyValueModel>>> getListProvince() async {
    final result = await createRequestResponseArray<ProvinceModel>(
      'bussiness/api/v1/provinces?limit=100',
      method: Method.get,
      instance: ProvinceModel.fromJson,
    );
    if (result.status == Status.complete) {
      return ApiResponse.completed(
        (result.data ?? [])
            .map(
              (e) => KeyValueModel(
                key: e.code.toString(),
                title: e.name,
              ),
            )
            .toList(),
      );
    }
    return ApiResponse.error(result.exception);
  }

  //Quận / Huyện
  Future<ApiResponse<List<KeyValueModel>>> getListDistrict(
      {required String provinceCode}) async {
    final result = await createRequestResponseArray<ProvinceModel>(
      'bussiness/api/v1/district/$provinceCode',
      method: Method.get,
      instance: ProvinceModel.fromJson,
    );
    if (result.status == Status.complete) {
      return ApiResponse.completed(
        (result.data ?? [])
            .map(
              (e) => KeyValueModel(
                key: e.code.toString(),
                title: e.fullName,
              ),
            )
            .toList(),
      );
    }
    return ApiResponse.error(result.exception);
  }

  //Xã / Phường / Thị trấn
  Future<ApiResponse<List<KeyValueModel>>> getListAddress(
      {required String districtCode}) async {
    final result = await createRequestResponseArray<ProvinceModel>(
      '/bussiness/api/v1/wards/$districtCode',
      method: Method.get,
      instance: ProvinceModel.fromJson,
    );
    if (result.status == Status.complete) {
      return ApiResponse.completed(
        (result.data ?? [])
            .map(
              (e) => KeyValueModel(
                key: e.code.toString(),
                title: e.fullName,
              ),
            )
            .toList(),
      );
    }
    return ApiResponse.error(result.exception);
  }

  Future<ApiResponse<List<KeyValueModel>>> getLoaiDuongTiepGiap() async {
    final result = await createRequestResponseArray<RoadContiguousType>(
      'assets/api/v1/roadContiguousTypes',
      method: Method.get,
      instance: RoadContiguousType.fromJson,
    );
    if (result.status == Status.complete) {
      return ApiResponse.completed(
        (result.data ?? [])
            .map(
              (e) => KeyValueModel(
                key: e.roadContiguousTypeId.toString(),
                title: e.roadContiguousTypeName,
              ),
            )
            .toList(),
      );
    }
    return ApiResponse.error(result.exception);
  }

  Future<ApiResponse<List<KeyValueModel>>> getPositions() async {
    final result = await createRequestResponseArray<PositionModel>(
      'assets/api/v1/positions',
      method: Method.get,
      instance: PositionModel.fromJson,
    );
    if (result.status == Status.complete) {
      return ApiResponse.completed(
        (result.data ?? [])
            .map(
              (e) => KeyValueModel(
                id: e.positionId,
                key: e.positionId.toString(),
                title: e.positionName,
              ),
            )
            .toList(),
      );
    }
    return ApiResponse.error(result.exception);
  }

  Future<ApiResponse<List<KeyValueModel>>> getZone() async {
    final result = await createRequestResponseArray<ZoneModel>(
      'assets/api/v1/zones',
      method: Method.get,
      instance: ZoneModel.fromJson,
    );
    if (result.status == Status.complete) {
      return ApiResponse.completed(
        (result.data ?? [])
            .map(
              (e) => KeyValueModel(
                key: e.zoneId.toString(),
                title: e.zone,
              ),
            )
            .toList(),
      );
    }
    return ApiResponse.error(result.exception);
  }

  //Lấy vị trí trong khung giá
  Future<ApiResponse<List<KeyValueModel>>> getPositionInPriceRanges() async {
    final result = await createRequestResponseArray<PositionInPriceRange>(
      'assets/api/v1/positionInPriceRanges',
      method: Method.get,
      instance: PositionInPriceRange.fromJson,
    );
    if (result.status == Status.complete) {
      return ApiResponse.completed(
        (result.data ?? [])
            .map(
              (e) => KeyValueModel(
                key: e.positionInPriceRangeId.toString(),
                title: e.positionInPriceRangeName,
              ),
            )
            .toList(),
      );
    }
    return ApiResponse.error(result.exception);
  }

  //Lấy đoạn đường trong khung giá
  Future<ApiResponse<List<KeyValueModel>>> getRoadInPrice(
      {String? provinceCode}) async {
    final result = await createRequestResponseArray<RoadInPrice>(
      'bussiness/api/v1/roadInPrice/get_by_provinceCode/$provinceCode',
      method: Method.get,
      instance: RoadInPrice.fromJson,
    );
    if (result.status == Status.complete) {
      return ApiResponse.completed(
        (result.data ?? [])
            .map(
              (e) => KeyValueModel(
                key: e.roadInPriceRangeId.toString(),
                title: e.getRoadTitle(),
              ),
            )
            .toList(),
      );
    }
    return ApiResponse.error(result.exception);
  }

  /// Lấy mục đích sử dụng
  Future<ApiResponse<List<KeyValueModel>>> getUsingPurpose(
      {int? taiSanCap2Id}) async {
    final result = await createRequest(
      'assets/api/v1/usingPurpose/get_all?direction=0&status=true&page=1&limit=1000',
      method: Method.get,
    );

    if (result.status == Status.complete) {
      final content = (result.data['items'] as List<dynamic>?)
          ?.map((e) => UsingPurpose.fromJson(e as Map<String, dynamic>))
          .toList();
      return ApiResponse.completed(
        (content ?? [])
            .map(
              (e) => KeyValueModel(
                key: e.usingPurposeId.toString(),
                title: e.title,
              ),
            )
            .toList(),
      );
    }
    return ApiResponse.error(result.exception);
  }

  /// Lấy loại CTXD
  Future<ApiResponse<List<KeyValueModel>>> getConstructionType() async {
    final result = await createRequestResponseArray<ConstructionType>(
      'assets/api/v1/constructionTypes',
      method: Method.get,
      instance: ConstructionType.fromJson,
    );
    if (result.status == Status.complete) {
      return ApiResponse.completed(
        (result.data ?? [])
            .map(
              (e) => KeyValueModel(
                id: e.constructionTypeId,
                key: e.constructionTypeId.toString(),
                title: e.constructionTypeName,
              ),
            )
            .toList(),
      );
    }
    return ApiResponse.error(result.exception);
  }

  /// Lấy tên CTXD
  Future<ApiResponse<List<KeyValueModel>>> getConstructionName(
      {String? constructionType}) async {
    final result = await createRequestResponseArray<ConstructionName>(
      'assets/api/v1/constructionNames/$constructionType',
      method: Method.get,
      instance: ConstructionName.fromJson,
    );
    if (result.status == Status.complete) {
      return ApiResponse.completed(
        (result.data ?? [])
            .map(
              (e) => KeyValueModel(
                id: e.constructionNameId,
                key: e.constructionNameId.toString(),
                title: e.constructionName,
              ),
            )
            .toList(),
      );
    }
    return ApiResponse.error(result.exception);
  }

  /// Hồ sơ pháp lý CTXD
  Future<ApiResponse<List<KeyValueModel>>> getConstructionLegal(
      {String? constructionType}) async {
    final result = await createRequestResponseArray<KeyValueModel>(
      'assets/api/v1/constructionLegalTypes',
      method: Method.get,
      instance: KeyValueModel.fromJson,
    );
    if (result.status == Status.complete) {
      return ApiResponse.completed((result.data ?? []));
    }
    return ApiResponse.error(result.exception);
  }

  /// Loại cây
  Future<ApiResponse<List<KeyValueModel>>> getTreeTypes(
      {String? constructionType}) async {
    final result = await createRequestResponseArray<TreeType>(
      'assets/api/v1/treeTypes',
      method: Method.get,
      instance: TreeType.fromJson,
    );
    if (result.status == Status.complete) {
      return ApiResponse.completed(
        (result.data ?? [])
            .map(
              (e) => KeyValueModel(
                key: e.assetTreeTypeId.toString(),
                title: e.assetTreeTypeName,
              ),
            )
            .toList(),
      );
    }
    return ApiResponse.error(result.exception);
  }

  /// Lợi thế kinh doanh
  Future<ApiResponse<List<KeyValueModel>>> getBusinessAdvantages(
      {String? constructionType}) async {
    final result = await createRequestResponseArray<KeyValueModel>(
      'assets/api/v1/bussinessAdvantages',
      method: Method.get,
      instance: KeyValueModel.fromJson,
    );
    if (result.status == Status.complete) {
      return ApiResponse.completed((result.data ?? []));
    }
    return ApiResponse.error(result.exception);
  }

  /// Tính thanh khoản
  Future<ApiResponse<List<KeyValueModel>>> getLiqudTies(
      {String? constructionType}) async {
    final result = await createRequestResponseArray<KeyValueModel>(
      'assets/api/v1/liquidities',
      method: Method.get,
      instance: KeyValueModel.fromJson,
    );
    if (result.status == Status.complete) {
      return ApiResponse.completed((result.data ?? []));
    }
    return ApiResponse.error(result.exception);
  }

  /// Cảnh báo rủi ro
  Future<ApiResponse<List<KeyValueModel>>> getRiskTypes() async {
    final result = await createRequestResponseArray<RiskModel>(
      'assets/api/v1/riskTypes',
      method: Method.get,
      instance: RiskModel.fromJson,
    );
    if (result.status == Status.complete) {
      return ApiResponse.completed(
        (result.data ?? [])
            .map(
              (e) => KeyValueModel(
                key: e.riskTypeId.toString(),
                title: e.riskTypeName,
              ),
            )
            .toList(),
      );
    }
    return ApiResponse.error(result.exception);
  }

  /// Nội dung CBRR
  Future<ApiResponse<List<KeyValueModel>>> getRiskContent(
      {int? assetLevel2Id}) async {
    final result = await createRequestResponseArray<RiskContentModel>(
      'assets/api/v1/riskAssets/$assetLevel2Id',
      method: Method.get,
      instance: RiskContentModel.fromJson,
    );
    if (result.status == Status.complete) {
      return ApiResponse.completed(
        (result.data ?? [])
            .map(
              (e) => KeyValueModel(
                key: e.riskAssetId.toString(),
                title: e.riskContent,
                value: e.riskLevel?.toString(),
              ),
            )
            .toList(),
      );
    }
    return ApiResponse.error(result.exception);
  }

  /// Lưu tài sản
  Future<ApiResponse<SaveAssetResponse?>> saveAsset<T>({
    required String appraisalFileId,
    required int assetLevelTwoId,
    required List<AssetsDetailModel<T>> items,
  }) async {
    final result = await createRequest(
      'assets/api/v1/entire/$assetLevelTwoId?appraisalFileId=$appraisalFileId',
      method: Method.put,
      data: items,
    );
    if (result.data != null) {
      try {
        final body = SaveAssetResponse.fromJson(result.data);
        return ApiResponse.completed(body);
      } catch (e) {
        log('Lỗi parse json', error: e);
      }
    }
    return ApiResponse.error(AppException());
  }

  Future<ApiResponse<AssetsModel?>> getAssetDetailFromFileId({
    required String appraisalFileId,
    CancelToken? cancelToken,
  }) async {
    final result = await createRequest<AssetsModel>(
      'bussiness/api/v1/appraisalFiles/$appraisalFileId',
      method: Method.get,
      instance: AssetsModel.fromJson,
      cancelToken: cancelToken,
    );
    return result;
  }

  Future<ApiResponse> updateLocation({
    required String appraisalFileId,
    double? lat,
    double? lng,
  }) async {
    final result = await createRequest('bussiness/api/v1/locate/appraisalFile',
        method: Method.put,
        queryParameters: {
          'appraisalFileId': appraisalFileId,
          'lat': lat,
          'long': lng,
        });
    return result;
  }

  Future<ApiResponse> updateImageList({
    required String appraisalFileId,
    required List<Attachment> lsAttachment,
  }) async {
    final result = await createRequest(
      'bussiness/api/v1/assetImage/$appraisalFileId',
      method: Method.put,
      data: lsAttachment,
    );
    return result;
  }

  Future<ApiResponse<dynamic>> uploadSignature({
    required String appraisalFileId,
    List<int>? typeExport,
    required Uint8List imageStaffSign,
    required Uint8List imageCustomerSign,
  }) async {
    final result = await createRequest(
      // 'assets/api/v1/surveyReport/fakes',
      'assets/api/v1/surveyReport/successSurveyReport',
      method: Method.post,
      data: {
        'appraisalFileId': appraisalFileId,
        'typeExport': typeExport ?? [0],
        'imageStaffSign': base64Encode(imageStaffSign),
        'imagesurveyGuideSign': base64Encode(imageCustomerSign),
      },
    );
    return result;
  }

  Future<ApiResponse<dynamic>> completeSurvey({
    required String appraisalFileId,
    List? data,
  }) async {
    final result = await createRequest(
      // 'assets/api/v1/surveyReport/fakes',
      'bussiness/api/v1/completeSurvey/$appraisalFileId',
      data: data,
      method: Method.put,
    );
    return result;
  }

  /// Danh sách vị trí
  Future<ApiResponse<List<KeyValueModel>>> getPosition({
    int? assetLevel2Id,
  }) async {
    final result = await createRequestResponseArray<Position>(
      'assets/api/v1/positions',
      method: Method.get,
      instance: Position.fromJson,
    );
    if (result.status == Status.complete) {
      return ApiResponse.completed(
        (result.data ?? [])
            .map(
              (e) => KeyValueModel(
                key: e.positionId.toString(),
                title: e.positionName,
              ),
            )
            .toList(),
      );
    }
    return ApiResponse.error(result.exception);
  }

  ///Công thức bánh
  Future<ApiResponse<List<KeyValueModel>>> wheelFomula() async {
    final result = await createRequestResponseArray<WheelFormula>(
        'assets/api/v1/wheelFormulas',
        method: Method.get,
        instance: WheelFormula.fromJson);
    return ApiResponse.completed(
      result.data
              ?.map(
                (e) => KeyValueModel(
                  id: e.wheelFormulaId,
                  title: e.wheelFormulaName,
                ),
              )
              .toList() ??
          [],
    );
  }

  ///Hộp số
  Future<ApiResponse<List<KeyValueModel>>> gearBox() async {
    final result = await createRequestResponseArray<GearBox>(
        'assets/api/v1/gearBoxs',
        method: Method.get,
        instance: GearBox.fromJson);
    return ApiResponse.completed(result.data
            ?.map((e) => KeyValueModel(
                  id: e.gearBoxId,
                  title: e.gearBoxName,
                ))
            .toList() ??
        []);
  }

  ///Nhiên liệu
  Future<ApiResponse<List<KeyValueModel>>> fuels() async {
    final result = await createRequestResponseArray<Fuel>('assets/api/v1/fuels',
        method: Method.get, instance: Fuel.fromJson);
    return ApiResponse.completed(result.data
            ?.map((e) => KeyValueModel(id: e.fuelId, title: e.fuelName))
            .toList() ??
        []);
  }

  ///Nước sản xuất
  Future<ApiResponse<List<KeyValueModel>>> country() async {
    final result = await createRequestResponseArray<Country>(
        'assets/api/v1/countrys/search',
        method: Method.get,
        instance: Country.fromJson);
    return ApiResponse.completed(result.data
            ?.map((e) => KeyValueModel(id: e.id, title: e.vnName))
            .toList() ??
        []);
  }

  ///Nhãn hiệu phương tiện
  Future<ApiResponse<List<KeyValueModel>>> vehicleBrands(
      {VehicleTypeEnum type = VehicleTypeEnum.ptdb}) async {
    final result = await createRequestResponseArray<Vehicle>(
      'assets/api/v1/vehicleBrands',
      queryParameters: {
        'type': type.id,
      },
      method: Method.get,
      instance: Vehicle.fromJson,
    );
    return ApiResponse.completed(
      result.data
              ?.map(
                (e) => KeyValueModel(
                  id: e.roadVehicleBrandId,
                  key: e.roadVehicleBrandId.toString(),
                  title: e.roadVehicleBrandName,
                ),
              )
              .toList() ??
          [],
    );
  }
}
