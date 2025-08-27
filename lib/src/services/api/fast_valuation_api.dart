import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/assets/chcc_fast_valuation_model.dart';
import 'package:sba/src/models/assets/fast_valuation_model.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/services/base_api_services.dart';
import 'package:sba/src/utils/utils.dart';

final fastApiProvider = Provider<FastValuationApi>((ref) {
  var result = FastValuationApi(ref.read(dioProvider));
  ref.onDispose(result.dispose);
  return result;
});

class FastValuationApi extends BaseApi {
  FastValuationApi(super.dio);

  //Lấy danh sách tài sản
  Future<ApiResponse<List<T>?>> getListAssets<T extends FastValuationModel>({
    required int page,
    required AssetsTypeEnum? assetType,
    bool? isFast = true,
    T Function(Map<String, Object?>)? instance,
  }) async {
    final assetsLevel2Id = assetType?.assetsLevel2Id;
    if (assetsLevel2Id != AssetsTypeEnum.dinhGiaNhanhBDS.assetsLevel2Id &&
        assetsLevel2Id != AssetsTypeEnum.dinhGiaNhanhCHCC.assetsLevel2Id) {
      return ApiResponse.completed([]);
    }

    final result = await createRequestResponseArray<T>(
      'assets/api/v1/fastValuation',
      queryParameters: {
        'limit': kDefaultPageSize,
        'page': page,
        'assetType': assetsLevel2Id,
        'isFastValuation': isFast,
      },
      method: Method.get,
      instance: instance,
    );
    return result;
  }

  Future<ApiResponse<FastValuationModel?>> getDetail({String? iD}) async {
    final result = await createRequest<FastValuationModel>(
      'assets/api/v1/fastValuation/$iD',
      method: Method.get,
      queryParameters: {
        'assetType': 0,
      },
      instance: FastValuationModel.fromJson,
    );
    return result;
  }

  Future<ApiResponse<CHCCFastValModel?>> getDetailDinhGiaNhanhCHCC(
      {String? iD}) async {
    final result = await createRequest<CHCCFastValModel>(
      'assets/api/v1/fastValuation/$iD',
      method: Method.get,
      queryParameters: {
        'assetType': AssetsTypeEnum.dinhGiaNhanhCHCC.assetsLevel2Id,
      },
      instance: CHCCFastValModel.fromJson,
    );
    return result;
  }

  ///Lấy đặc tính kỹ thuật
  Future<List<KeyValueModel>?> getDacTinhKyThuat({String? iD}) async {
    final result = await createRequestResponseArray<ConstructionProps>(
      'assets/api/v1/constructionNames/$iD',
      method: Method.get,
      instance: ConstructionProps.fromJson,
    );
    if (result.status == Status.complete) {
      return (result.data ?? [])
          .map(
            (e) => KeyValueModel(
              id: e.constructionNameId,
              key: e.constructionNameId?.toString(),
              title: e.constructionName,
              otherField: e.toJson(),
            ),
          )
          .toList();
    }
    return [];
  }

  ///Định gía tài sản
  Future<ApiResponse<FastValuationModel?>> dinhGiaTaiSan(
      {required FastValuationModel body}) async {
    final rqBody = body.toJson();
    rqBody['roadInPriceRange'] = body.roadInPriceRangeId;
    rqBody.remove('positionName');
    final result = await createRequest<FastValuationModel>(
      'assets/api/v1/fastValuation/insert?assetType=0',
      data: rqBody,
      method: Method.post,
      instance: FastValuationModel.fromJson,
    );
    return result;
  }

  ///Định gía tài sản
  Future<ApiResponse<FastValuationModel?>> dinhGiaTaiSanCHCC(
      {required CHCCFastValModel body}) async {
    final rqBody = body.toJson();
    final result = await createRequest<FastValuationModel>(
      'assets/api/v1/fastValuation/insert?assetType=${AssetsTypeEnum.dinhGiaNhanhCHCC.assetsLevel2Id}',
      data: rqBody,
      method: Method.post,
      instance: CHCCFastValModel.fromJson,
    );
    return result;
  }

  ///Định giá
  Future<ApiResponse<FastValuationInfoResponse?>> getFastValuationInfo(
      {required FastValuationModel body}) async {
    final result = await createRequest(
      'assets/api/v1/fastValuation',
      queryParameters: {
        'customerName': body.customerName,
        'customerIdentity': body.customerIdentity,
        'landPlotNumber': body.landPlotNumber,
        'mapSheetNumber': body.mapSheetNumber,
        'latitude': body.latitude,
        'longitude': body.longitude,
        'areaInPlan': body.areaInplan,
        'areaUnPlan': body.areaUnplan,
        'areaWidth': body.areaWidth,
        'usingPurposeId': body.usingPurposeId,
        'shape': body.shape,
        'numberOfFacade': body.numberOfFacade,
        'radius': body.radius,
        'facadeLength': body.facadeLength,
        'roadInPriceRange': body.roadInPriceRangeId,
        'roadContiguousTypeId': body.roadContiguousTypeId,
        'positionId': body.positionId,
        'widthToMainRoad': body.widthToMainRoad,
        'assetType': 0,
        'addressStreet': body.addressStreet,
        'addressProvince': body.addressProvince,
        'addressDistrict': body.addressDistrict,
        'addressWard': body.addressWard,
        'addressDetail': body.addressDetail,
        'address': body.address,
        'dateFrom': DateTime.now().toStringFormat('yyyy-MM-dd'),
        'dateTo': DateTime.now()
            .add(const Duration(days: 30 * 6))
            .toStringFormat('yyyy-MM-dd'),
        'page': 1,
        'limit': 3,
      },
      method: Method.get,
      instance: null,
    );
    if (result.data != null && result.status == Status.complete) {
      return ApiResponse.completed(
          FastValuationInfoResponse.fromJson(result.data));
    }
    return ApiResponse.error(result.exception);
  }

  ///Định giá chcc
  Future<ApiResponse<DinhGiaCHCCResponse?>> getFastValuationInfoCHCC(
      {required CHCCFastValModel body}) async {
    final address = [
      body.addressDetail,
      body.addressStreet,
      body.wards?.fullName ?? '',
      body.districts?.fullName ?? '',
      body.provinces?.fullName,
    ]..removeWhere((element) => (element ?? '').isEmpty);
    body.address = address.join(', ');
    final result = await createRequest(
      'assets/api/v1/fastValuation',
      queryParameters: {
        'customerName': body.customerName,
        'customerIdentity': body.customerIdentity,
        'codeBook': body.codeBook,
        'mapSheetNumber': body.mapSheetNumber,
        'projectId': body.projectId,
        'buildingId': body.buildingId,
        'blockId': body.blockId,
        'latitude': body.latitude,
        'longitude': body.longitude,
        'building': body.building,
        'projectName': body.projectName,
        'totalFloor': body.totalFloor,
        'positionId': body.positionId,
        'kitchens': body.kitchens,
        'privateUseArea': body.privateUseArea,
        'clearanceArea': body.clearanceArea,
        'buildupArea': body.buildupArea,
        'extendArea': body.extendArea,
        'floorNo': body.floorNo,
        'bedrooms': body.bedrooms,
        'toilets': body.toilets,
        'surfaces': body.surfaces,
        'furniture': body.furniture,
        'utilities': body.utilities,
        'assetType': 1,
        'addressStreet': body.addressStreet,
        'addressProvince': body.addressProvince,
        'addressDistrict': body.addressDistrict,
        'addressWard': body.addressWard,
        'addressDetail': body.addressDetail,
        'address': body.address,
        'dateFrom': DateTime.now().toStringFormat('yyyy-MM-dd'),
        'dateTo': DateTime.now()
            .add(const Duration(days: 30 * 6))
            .toStringFormat('yyyy-MM-dd'),
        'page': 1,
        'limit': 3,
      },
      method: Method.get,
      instance: null,
    );
    if (result.data != null && result.status == Status.complete) {
      return ApiResponse.completed(DinhGiaCHCCResponse.fromJson(result.data));
    }
    return ApiResponse.error(result.exception);
  }

  Future<ApiResponse<FindByLOSResponse?>> findByLos(
      {required FastValuationModel body}) async {
    final result = await createRequest(
      'assets/api/v1/fastValuation/findByLos',
      data: {
        'landPlotNumber': body.landPlotNumber,
        'mapSheetNumber': body.mapSheetNumber,
        'latitude': '',
        'longitude': '',
        'areaInPlan': body.areaInplan,
        'areaUnPlan': body.areaUnplan,
        'areaWidth': body.areaWidth,
        'usingPurposeId': body.usingPurposeId,
        'shape': body.shape,
        'numberOfFacade': body.numberOfFacade,
        'radius': body.radius,
        'facadeLength': body.facadeLength,
        'roadInPriceRangeId': body.roadInPriceRangeId,
        // 'roadInPriceRange': body.roadInPriceRange,
        'roadContiguousTypeId': body.roadContiguousTypeId,
        'positionId': body.positionId,
        'widthToMainRoad': body.widthToMainRoad,
        'assetType': 0,
        'addressProvince': body.addressProvince,
        'addressDistrict': body.addressDistrict,
        'addressWard': body.addressWard,
        'addressDetail': body.addressDetail,
        'address': body.address,
        'addressStreet': body.addressStreet,
        'constructions': body.constructions,
      },
      method: Method.post,
      instance: null,
    );

    if (result.data != null && result.status == Status.complete) {
      return ApiResponse.completed(
        FindByLOSResponse.fromJson(
          result.data['data'],
        ),
      );
    }
    return ApiResponse.error(result.exception);
  }

  Future<ApiResponse<dynamic>> xoaTaiSan(
      {required String? iD, int? assetType = 0}) async {
    final result = await createRequest(
      'assets/api/v1/fastValuation/$iD?assetType=$assetType',
      method: Method.delete,
    );
    return result;
  }

  Future<dynamic> getListTSSS({required FastValuationModel data}) async {
    //latitude=11.7266355&longitude=108.5236955&areaWidth=1000&usingPurposeId=70&radius=100&roadInPriceRange=41987&positionId=2&assetType=0&
    //addressProvince=68&addressDistrict=677&addressWard=2494&limit=3
    final result = await dio.get(
      'assets/api/v1/fastValuation',
      queryParameters: {
        'latitude': data.latitude,
        'longitude': data.longitude,
        'areaWidth': data.areaWidth,
        'usingPurposeId': data.usingPurposeId,
        'radius': data.radius,
        'roadInPriceRange': data.roadInPriceRange,
        'positionId': data.positionId,
        'assetType': '0',
        'addressProvince': data.addressProvince,
        'addressDistrict': data.addressDistrict,
        'addressWard': data.addressWard,
      },
    );
    return result.data;
  }

  ///Danh sách dự án chcc
  Future<ApiResponse<List<KeyValueModel>?>> layDanhSachDuAnCHCC(
      {String? name}) async {
    final result = await createRequestResponseArray<DuAnChungCuModel>(
      'assets/api/v1/apartment/detail/projects',
      queryParameters: {
        if (name != null) 'name': name,
      },
      method: Method.get,
      instance: DuAnChungCuModel.fromJson,
    );
    return ApiResponse.completed(
        result.data?.map((e) => e.toKeyValueModel()).toList() ?? []);
  }

  ///Danh sách tòa nhà
  Future<ApiResponse<List<KeyValueModel>?>> layDanhSachToaNha(
      {String? projectId, String? name}) async {
    final result = await createRequestResponseArray<ToaNhaThucTeModel>(
      'assets/api/v1/apartment/detail/building',
      queryParameters: {
        if (projectId != null) 'projectId': projectId,
        if (name != null) 'name': name,
      },
      method: Method.get,
      instance: ToaNhaThucTeModel.fromJson,
    );
    return ApiResponse.completed(
        result.data?.map((e) => e.toKeyValueModel()).toList() ?? []);
  }

  ///Danh sách tòa nhà
  Future<ApiResponse<dynamic>> layDanhSachBlock({
    String? projectId,
    String? buildingId,
    String? name,
  }) async {
    final result = await createRequest(
      'assets/api/v1/apartment/detail/blocks',
      queryParameters: {
        if (projectId != null) 'projectId': projectId,
        if (buildingId != null) 'buildingId': buildingId,
        if (name != null) 'name': name,
      },
      method: Method.get,
    );
    return result;
  }
}
