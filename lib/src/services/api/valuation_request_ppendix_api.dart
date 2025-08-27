import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sba/src/services/base_api_services.dart';

final valuationRequestAppendixApiProvider =
    Provider<ValuationRequestAppendixApi>((ref) {
  var result = ValuationRequestAppendixApi(ref.read(dioProvider));
  ref.onDispose(result.dispose);
  return result;
});

class ValuationRequestAppendixApi extends BaseApi {
  ValuationRequestAppendixApi(super.dio);

  // Future<ApiResponse<ServerResponseArray<AppendixPendingModel>?>> getAppendixPending(
  //     {String? assetTypeCode = "BĐS",
  //     String? textSearch,
  //     int? pageIndex}) async {
  //   // try {
  //   //   var response =
  //   //       await createRequest<AppendixPendingModel>(
  //   //     _getAppendixPending,
  //   //     data: {
  //   //       "AssetTypeCode": assetTypeCode == 'BDS' ? 'BĐS' : assetTypeCode,
  //   //       "textSearch": textSearch ?? '',
  //   //       "PageIndex": pageIndex,
  //   //       "PageSize": AppConstants.PAGE_SIZE
  //   //     },
  //   //     instance: AppendixPendingModel.fromJson,
  //   //   );
  //   //   return response;
  //   // } catch (error) {
  //   //   return ApiResponse.error(AppException(error.toString()));
  //   // }
  // }
}
