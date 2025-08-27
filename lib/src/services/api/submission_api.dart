import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/approval_submission_model.dart';
import 'package:sba/src/models/assets/submission_detail_model.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/models/login/user_model.dart';
import 'package:sba/src/services/base_api_services.dart';

final submissionApiProvider = Provider<SubmissionApi>((ref) {
  var result = SubmissionApi(ref.read(dioProvider));
  ref.onDispose(result.dispose);
  return result;
});

class SubmissionApi extends BaseApi {
  SubmissionApi(super.dio);

  ///Thông tin tờ trình
  Future<ApiResponse<ApprovalSubmissionInfo?>> getApprovalSubmissionInfo({
    String? appraisalFileId,
  }) async {
    final result = await createRequest(
      'bussiness/api/v1/approvalSubmission/$appraisalFileId',
      method: Method.get,
      instance: ApprovalSubmissionInfo.fromJson,
    );

    return result;
  }

  ///Chi tiết tờ trình
  Future<ApiResponse<SubmissionDetailModel?>> chiTietToTrinh({
    String? appraisalFileId,
    int? assetLevelTwoId,
  }) async {
    final result = await createRequest(
      'assets/api/v1/entire/valuation',
      method: Method.get,
      queryParameters: {
        'appraisalFileId': appraisalFileId,
        'assetLevelTwoId': assetLevelTwoId,
      },
      instance: SubmissionDetailModel.fromJson,
    );

    return result;
  }

  ///Danh sách quản trị phê duyệt tờ trình
  Future<List<KeyValueModel>?> getListUserSubmission({
    String? appraisalFileId,
  }) async {
    final result = await createRequestResponseArray(
      'bussiness/api/v1/approvalSubmission/findApprovalStaff/$appraisalFileId',
      method: Method.get,
      instance: StaffModel.fromJson,
    );
    if ((result.data ?? []).isNotEmpty) {
      return (result.data ?? [])
          .map(
            (e) => KeyValueModel(
              key: e.staffId,
              title: '${e.staffName} (${e.roleCode})',
            ),
          )
          .toList();
    }

    return [];
  }

  /// Gửi tờ trình
  Future<ApiResponse<dynamic>> sendSubmission({
    ApproveSubmission? body,
  }) async {
    final result = await createRequest(
      'bussiness/api/v1/approvalSubmission/send',
      method: Method.post,
      data: body,
    );
    ServerResponse data = ServerResponse();
    data = data.postResponseJson(result.data, null);
    return handleResponse(data);
  }

  /// Duyệt tờ trình
  Future<ApiResponse<dynamic>> acceptSubmission({
    ApproveSubmission? body,
  }) async {
    final result = await createRequest(
      'bussiness/api/v1/approvalSubmission/accept',
      method: Method.post,
      data: body,
    );
    ServerResponse data = ServerResponse();
    data = data.postResponseJson(result.data, null);
    return handleResponse(data);
  }

  /// Từ chối tờ trình
  Future<ApiResponse<dynamic>> cancelSubmission({
    int? approvalSubmissionId,
    String? approvalComment,
    String? approvalEmployeeId,
  }) async {
    final result = await createRequest(
      'bussiness/api/v1/approvalSubmission/cancel',
      method: Method.post,
      data: {
        'approvalSubmissionId': approvalSubmissionId,
        'approvalComment': approvalComment,
        'approvalEmployeeId': approvalEmployeeId
      },
    );
    ServerResponse data = ServerResponse();
    data = data.postResponseJson(result.data, null);
    return handleResponse(data);
  }

  /// Điều chỉnh người ký số
  Future<ApiResponse<dynamic>> dieuChinhNguoiKySo({
    String? appraisalFileId,
    String? staffId,
  }) async {
    final result = await createRequest(
      '/bussiness/api/v1/assignment/assignmentSignature',
      method: Method.post,
      data: {
        'appraisalFileId': appraisalFileId,
        'staffId': staffId,
      },
    );
    return result;
  }

  ///Bắt đầu ký
  Future<ApiResponse<dynamic>> startSign({
    String? appraisalFileId,
    String accessToken = '',
    String? credentialId,
    required int page,
  }) async {
    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
      final result = await createRequest(
        'report/api/v1/result/signatureMobi',
        method: Method.post,
        queryParameters: {
          'appraisalFilesId': appraisalFileId,
          'spId': decodedToken['client_id'],
          'userId': decodedToken['Uid'],
          'spPassword': 'ZjE3MjM1OTg-MWE3Yi00YzY4',
          'page': page,
        },
        instance: null,
      );
      if (result.status == Status.error) {
        return result;
      }
      if (result.data == null) throw AppException();

      ServerResponse data = ServerResponse();
      data = data.postResponseJson(
        result.data,
        null,
      );
      return handleResponse(data);
    } catch (e) {
      return ApiResponse.error(AppException(S.current.co_loi_xay_ra));
    }
  }

  ///Hoàn thành ký, kiểm tra trạng thái
  Future<ApiResponse<dynamic>> checkStatus({
    String? appraisalFileId,
    String accessToken = '',
    String? credentialId,
  }) async {
    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
      final result = await createRequest(
        'report/api/v1/result/signatureMobi/success',
        method: Method.post,
        queryParameters: {
          'appraisalFilesId': appraisalFileId,
          'spId': decodedToken['client_id'],
          'userId': decodedToken['Uid'],
          'spPassword': 'ZjE3MjM1OTg-MWE3Yi00YzY4',
        },
        instance: null,
      );
      if (result.data == null) throw AppException();

      ServerResponse data = ServerResponse();
      data = data.postResponseJson(result.data, null);
      return handleResponse(data);
    } catch (e) {
      return ApiResponse.error(AppException(e.toString()));
    }
  }

  Future<ApiResponse<ApprovalSubmissionInfo?>> getSubmissionHistory(
      String? iD) async {
    final result = await createRequest<ApprovalSubmissionInfo>(
      'bussiness/api/v1/approvalSubmission/$iD',
      method: Method.get,
      instance: ApprovalSubmissionInfo.fromJson,
    );
    return result;
  }

  ///Lấy danh sách nhân viên có thể ký số
  Future<List<KeyValueModel>?> getStaffCanSign({
    int? companyBranchId,
    int? totalPrice,
  }) async {
    final result = await createRequestResponseArray<UserModel>(
      'bussiness/api/v1/appraisalFiles/staffCanSign',
      method: Method.get,
      queryParameters: {
        'companyBranchId': companyBranchId,
        'totalPrice': totalPrice,
      },
      instance: UserModel.fromJson,
    );
    if ((result.data ?? []).isNotEmpty) {
      return (result.data ?? [])
          .map(
            (e) => KeyValueModel(
              key: e.staffId,
              title: '${e.staffName} (${e.username})',
            ),
          )
          .toList();
    }

    return [];
  }

  ///Lấy danh sách nhân viên
  Future<ApiResponse<List<UserModel>?>> getAllStaff() async {
    final result = await createRequestResponseArray<UserModel>(
      'admin/api/v1/staffs/search?page=1&limit=9000',
      method: Method.get,
      instance: UserModel.fromJson,
    );
    return result;
  }

  ///bussiness/api/v1/assignment/assignmentSignature
}
