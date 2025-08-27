import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/approval_submission_model.dart';
import 'package:sba/src/models/assets/submission_detail_model.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/base/controller/base_controller.dart';
import 'package:sba/src/screens/trinhky/states/ketqua_chitiet_state.dart';
import 'package:sba/src/screens/trinhky/widgets/gia_ptdb_ptdt_info_bottomsheet.dart';
import 'package:sba/src/screens/trinhky/widgets/ketqua_chitiet_bottomsheet.dart';
import 'package:sba/src/utils/base_flutter_extensions.dart';
import 'package:sba/src/utils/validator_util.dart';

class KetQuaChiTietPageController extends BaseController<KetQuaChiTietState> {
  KetQuaChiTietPageController(super.state, super.ref);

  static final controller = StateNotifierProvider.autoDispose
      .family<KetQuaChiTietPageController, KetQuaChiTietState, ApprovalHistory>(
    (ref, item) {
      return KetQuaChiTietPageController(
        KetQuaChiTietState(history: item),
        ref,
      );
    },
  );

  /// Hiển thị chi tiết giá đất
  void chiTietGiaDat(BuildContext context, KQDatModel item) async {
    final giaTri = InputFieldModel<int>(
      label: S.current.gia_tri,
      data: item.totalValue,
      isCurrency: true,
      enable: false,
      onTextChanged: (newValue) {
        item.totalValue = newValue;
      },
    );
    final dienTich = InputFieldModel<double>(
      label: S.current.dien_tich,
      data: item.totalArea,
      enable: false,
      onTextChanged: (newValue) {
        item.totalArea = newValue;
        item.totalValue =
            ((item.totalArea ?? 0.0) * (item.unitPrice ?? 0)).toInt();
        giaTri.updateText?.call((item.totalValue ?? 0).toPriceFormat() ?? '');
      },
    );
    final donGia = InputFieldModel<int>(
      label: S.current.don_gia,
      data: item.unitPrice,
      isCurrency: true,
      enable: false,
      onTextChanged: (newValue) {
        item.unitPrice = newValue;
        item.totalValue =
            ((item.totalArea ?? 0.0) * (item.unitPrice ?? 0)).toInt();
        giaTri.updateText?.call((item.totalValue ?? 0).toPriceFormat() ?? '');
      },
    );

    final phanLoai = InputFieldModel<String>(
      label: S.current.phan_loai,
      data: item.typeString,
      enable: false,
    );
    final lsItem = [
      InputFieldModel<String>(
        label: S.current.ten_tai_san,
        data: item.name,
        enable: false,
      ),
      if (item.typeString.isNotEmpty) phanLoai,
      dienTich,
      donGia,
      giaTri,
    ];
    await showModalBottomSheet<KQDatModel>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: KetQuaChiTietBottomSheet(
            lsItem: lsItem,
          ),
        );
      },
    );
  }

  void chiTietInfo(BuildContext context, KQDatModel item) {
    if (state.history.assetType == AssetsTypeEnum.ptdb ||
        state.history.assetType == AssetsTypeEnum.ptdt) {
      chiTietPTDB(context, item);
    } else {
      chiTietGiaDat(context, item);
    }
  }

  /// Hiển thị chi tiết CTXD
  void chiTietCTXD(BuildContext context, KQCTXDModel item) {
    final giaTri = InputFieldModel<int>(
      label: S.current.gia_tri,
      data: item.totalValue,
      enable: false,
      isCurrency: true,
      onTextChanged: (newValue) => item.totalValue = newValue,
    );
    final dienTich = InputFieldModel<double>(
      label: S.current.dien_tich,
      data: item.constructionArea,
      enable: false,
      onTextChanged: (newValue) {
        item.constructionArea = newValue;
        item.totalValue =
            ((item.constructionArea ?? 0.0) * (item.unitPrice ?? 0)).toInt();
        giaTri.updateText?.call((item.totalValue ?? 0).toPriceFormat() ?? '');
      },
    );
    final donGia = InputFieldModel<int>(
      label: S.current.don_gia,
      data: item.unitPrice,
      isCurrency: true,
      enable: false,
      onTextChanged: (newValue) {
        item.unitPrice = newValue;
        item.totalValue =
            ((item.constructionArea ?? 0.0) * (item.unitPrice ?? 0)).toInt();
        giaTri.updateText?.call((item.totalValue ?? 0).toPriceFormat() ?? '');
      },
    );
    final lsItem = [
      InputFieldModel<String>(
        label: S.current.ten_ctrinh,
        data: item.constructionName?.constructionName,
        enable: false,
      ),
      InputFieldModel<String>(
        label: S.current.phan_loai,
        data: item.constructionType?.constructionTypeName,
        enable: false,
      ),
      InputFieldModel<double>(
        label: S.current.clcl,
        data: item.remainingQuality,
        onTextChanged: (newText) => item.remainingQuality = newText,
        validator: Validator.validatePercent,
        required: false,
        enable: false,
      ),
      InputFieldModel<double>(
        label: S.current.muc_do_hoan_thien,
        data: item.mdht,
        onTextChanged: (newText) => item.mdht = newText,
        validator: Validator.validatePercent,
        required: false,
        enable: false,
      ),
      dienTich,
      donGia,
      giaTri
    ];
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: KetQuaChiTietBottomSheet(
            // item: item,
            lsItem: lsItem,
          ),
        );
      },
    );
  }

  /// Hiển thi chi tiết PTDB
  void chiTietPTDB(BuildContext context, KQDatModel item) async {
    final tenTaiSan = InputFieldModel<String>(
      label: S.current.ten_tai_san,
      data: item.name,
      enable: false,
    );
    final giaTri = InputFieldModel<int>(
      label: S.current.gia_tri,
      data: item.totalValue,
      isCurrency: true,
      enable: false,
    );
    final donGia = InputFieldModel<int>(
      label: S.current.don_gia_,
      data: item.unitPrice,
      isCurrency: true,
      enable: false,
      onTextChanged: (newValue) {
        item.unitPrice = newValue;
        item.totalValue = newValue;
        giaTri.updateText?.call((item.totalValue ?? 0).toPriceFormat() ?? '');
      },
    );

    final lsItem = [
      InputFieldModel<String>(
        label: S.current.ten_tai_san,
        data: item.name,
        enable: false,
      ),
      donGia,
      giaTri,
    ];

    await showModalBottomSheet<KQDatModel>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: KetQuaChiTietGiaPTDBPTDT(
            item: item,
            lsItem: lsItem,
          ),
        );
      },
    );
  }

  void chiTietMMTB(BuildContext context, KQDatModel e) async {
    final tenTaiSan = InputFieldModel<String>(
      label: S.current.ten_tai_san,
      data: e.name,
      enable: false,
    );
    final soLuongMMTB = InputFieldModel<int>(
      label: S.current.so_luong_MMTB,
      data: e.realCommonMachine,
      enable: false,
    );

    final giaTri = InputFieldModel<int>(
      label: S.current.gia_tri,
      data: e.totalValue,
      isCurrency: true,
      enable: false,
    );

    final donGia = InputFieldModel<int>(
      label: S.current.don_gia_,
      data: e.unitPrice,
      isCurrency: true,
      onTextChanged: (newValue) {
        e.unitPrice = newValue;
        final newPrive = (e.unitPrice ?? 0) * (e.realCommonMachine ?? 0);
        e.totalValue = newPrive;
        giaTri.updateText?.call(newPrive.toPriceFormat() ?? '');
      },
    );

    final lsItem = [
      InputFieldModel<String>(
        label: S.current.ten_tai_san,
        data: e.name,
        enable: false,
      ),
      soLuongMMTB,
      donGia,
      giaTri,
    ];

    await showModalBottomSheet<KQDatModel>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: KetQuaChiTietBottomSheet(
            lsItem: lsItem,
          ),
        );
      },
    );
  }
}
