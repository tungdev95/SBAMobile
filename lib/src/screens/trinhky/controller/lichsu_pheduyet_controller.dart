import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sba/src/models/assets/approval_submission_model.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/login/user_model.dart';
import 'package:sba/src/screens/base/controller/base_controller.dart';
import 'package:sba/src/screens/trinhky/ketqua_chitiet_page.dart';
import 'package:sba/src/screens/trinhky/states/lichsu_pheduyet_page_state.dart';
import 'package:sba/src/services/api/submission_api.dart';
import 'package:sba/src/utils/app_routes.dart';

class LichSuPheDuyetPageController extends BaseController<LichSuPheDuyetState> {
  LichSuPheDuyetPageController(super.state, super.ref);

  static final controller = StateNotifierProvider.autoDispose
      .family<LichSuPheDuyetPageController, LichSuPheDuyetState, AssetsModel>(
          (ref, asset) {
    return LichSuPheDuyetPageController(
      LichSuPheDuyetState(assetsModel: asset),
      ref,
    );
  });

  @override
  Future<void> initialLoad() async {
    super.initialLoad();
    getData();
  }

  void getData() async {
    showLoading();
    final staffResult = await ref.read(submissionApiProvider).getAllStaff();
    final result = await ref
        .read(submissionApiProvider)
        .getSubmissionHistory(state.assetsModel.appraisalFileId);
    hideLoading();
    handleResponse(result, (p0) {
      final item = result.data;
      for (ApprovalHistory e in (item?.approvalHistoryDtos ?? [])) {
        for (UserModel staff in (staffResult.data ?? [])) {
          if (e.tenNguoiPheDuyet != null &&
              e.tenNguoiPheDuyetTiepTheo != null) {
            break;
          }
          if (e.tenNguoiPheDuyet == null) {
            if (staff.staffId == e.approvalEmployeeId) {
              e.tenNguoiPheDuyet = staff.staffName;
            }
          }
          if (e.tenNguoiPheDuyetTiepTheo == null) {
            if (staff.staffId == e.approvalNextEmployeeId) {
              e.tenNguoiPheDuyetTiepTheo = staff.staffName;
            }
          }
        }
      }
      state = state.copyWith(item: item);
    });
  }

  void chiTiet(BuildContext context, ApprovalHistory item) {
    item.assetType = state.assetsModel.assetType;
    AppRoutes.push(
      context,
      ProviderScope(
        overrides: [history.overrideWithValue(item)],
        child: const KetQuaChiTietPage(),
      ),
    );
  }
}
