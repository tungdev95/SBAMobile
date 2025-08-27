import 'package:flutter/material.dart';
import 'package:sba/src/screens/assets/assets.dart';
import 'package:sba/src/screens/base/controller/base_controller.dart';
import 'package:sba/src/utils/utils.dart';

class BaseDetailInfoPageController<T extends BaseDetailItemState>
    extends BaseController<T> {
  BaseDetailInfoPageController(super.state, super.ref);
  GlobalKey<FormState> detailKey = GlobalKey();

  //Toggle group
  void expandItem(int panelIndex, bool isExpanded) {
    state.expandList[panelIndex].isExpand = isExpanded;
    state = state.copyWith(expandList: state.expandList) as T;
  }

  void expandChildItem(int parentIndex, int childIndex, bool isExpanded) {
    state.expandList[parentIndex].child[childIndex].isExpand = isExpanded;
    state = state.copyWith(expandList: state.expandList) as T;
  }

  Future<bool> saveData() async {
    return detailKey.currentState?.validate() ?? false;
  }

  double? tinhToanDienTichKhongPhuHopQuyHoach(
      double? areaWidth, double? areaInPlan) {
    if (areaWidth == null || areaInPlan == null) {
      return null;
    }
    final result = areaWidth - areaInPlan;
    return result.format3Number();
  }

  Future<bool> validateData() async {
    var formOK = detailKey.currentState?.validate() ?? true;
    String errorMess = '';
    for (var element in state.expandList) {
      errorMess = element.getError();
      if (errorMess.isNotEmpty) {
        errorMess = '${element.title}: $errorMess';
        break;
      }
    }

    if (errorMess.isNotEmpty) {
      showMessageDialog(errorMess);
      return false;
    }
    return true;
  }
}
