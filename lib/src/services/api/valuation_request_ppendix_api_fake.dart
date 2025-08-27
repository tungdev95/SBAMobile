import 'package:dio/dio.dart';
import 'package:sba/src/services/api/valuation_request_ppendix_api.dart';

// const String path = "ValuationRequestAppendix";

class FakeValuationRequestAppendixApi extends ValuationRequestAppendixApi {
  FakeValuationRequestAppendixApi(Dio dio) : super(dio);

  // @override
  // Future<ApiResponse<PagingResponse<AppendixPendingModel>?>> getAppendixPending(
  //     {String? assetTypeCode = "BĐS",
  //     String? textSearch,
  //     int? pageIndex}) async {
  //   try {
  //     String data =
  //         await rootBundle.loadString('assets/json/complete_response.json');
  //     var jsonResult = jsonDecode(data);
  //     ServerResponseArray<AppendixPendingModel>? result = ServerResponseArray();
  //     result = result.parseJson(jsonResult, AppendixPendingModel.fromJson);
  //     return ApiResponse.completed(result?.data);
  //   } catch (error) {
  //     return ApiResponse.error(AppException(error.toString()));
  //   }
  // }

  // Future<ApiResponse<ServerResponseArray<AppendixPendingModel>?>>
  //     getAppendixPending(
  //         {String? assetTypeCode = "BĐS",
  //         String? textSearch,
  //         int? pageIndex}) async {
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
