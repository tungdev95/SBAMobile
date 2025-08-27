import 'dart:async';
import 'dart:developer';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rate_limiter/rate_limiter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/assets/enum.dart';
import 'package:sba/src/models/assets/survey_schedule_model.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/assets/assets.dart';
import 'package:sba/src/screens/base/controller/base_controller.dart';
import 'package:sba/src/screens/base/top_level_provider.dart';
import 'package:sba/src/screens/map/page_map.dart';
import 'package:sba/src/screens/map/states/map_state.dart';
import 'package:sba/src/screens/map/zoning_map_page.dart';
import 'package:sba/src/services/api/assets_api.dart';
import 'package:sba/src/services/file_service.dart';
import 'package:sba/src/sign/sign_page.dart';
import 'package:sba/src/utils/dialog_utils.dart';
import 'package:sba/src/utils/utils.dart';
import 'package:sba/src/widgets/attachment/attachment_picker.dart';
import 'package:sba/src/widgets/attachment/attachment_picker_bottom_sheet.dart';
import 'package:sba/src/services/providers/asset_api_provider.dart';
part 'base_asset_detail_page_controller.g.dart';

@riverpod
Future<List<KeyValueModel>> danhSachQuanHuyen(
  DanhSachQuanHuyenRef ref,
  AssetCommons asset,
) async {
  final provinceSelected = ref.watch(thongTinTaiSanTinhTP(asset));
  if (provinceSelected == null) return [];
  final result = await ref
      .read(assetsApiProvider)
      .getListDistrict(provinceCode: provinceSelected.key ?? '');
  if ((result.data ?? []).isNotEmpty) {
    final keepAliveLink = ref.keepAlive();
    ref.listen(thongTinTaiSanTinhTP(asset), (previous, next) {
      if (previous?.key != next?.key) {
        keepAliveLink.close();
      }
    });
  }
  return result.data ?? [];
}

@riverpod
Future<List<KeyValueModel>> danhSachDuongPho(
  DanhSachDuongPhoRef ref,
  AssetCommons asset,
) async {
  final districtSelected = ref.watch(thongTinTaiSanQuanHuyen(asset));
  if (districtSelected == null) return [];
  final result = await ref
      .read(assetsApiProvider)
      .getListAddress(districtCode: districtSelected.key ?? '');
  if ((result.data ?? []).isNotEmpty) {
    final keepAliveLink = ref.keepAlive();
    ref.listen(thongTinTaiSanQuanHuyen(asset), (previous, next) {
      if (previous?.key != next?.key) {
        keepAliveLink.close();
      }
    });
  }
  return result.data ?? [];
}

final selectedCBRR = StateProvider.family<KeyValueModel?, RiskFactorModel>(
  (ref, params) {
    ref.listenSelf((previous, next) {
      // params.legalAddressWard = next?.key;
    });
    if (params.riskTypeId == null) return null;

    return KeyValueModel(key: params.riskTypeId.toString(), title: null);
  },
);

//riskAssetId
final selectedNoiDungCBRR =
    StateProvider.family<KeyValueModel?, RiskAssetModel?>(
  (ref, params) {
    ref.listenSelf((previous, next) {
      if (next == null) {
        return;
      }
      params?.riskAssetId = int.tryParse(next.key ?? '');

      params?.riskContent = next.title;
      if (next.value != null) {
        params?.riskLevel = int.tryParse(next.value ?? '');
        Future.delayed(const Duration(milliseconds: 500)).then(
          (value) => ref.read(selectedCapDoBCRR(params).notifier).state =
              KeyValueModel(
            key: next.value,
            title: next.value,
          ),
        );
      }
    });
    if (params?.riskAssetId == null) return null;

    return KeyValueModel(
      key: params?.riskAssetId.toString(),
    );
  },
);

final selectedCapDoBCRR = StateProvider.family<KeyValueModel?, RiskAssetModel?>(
  (ref, params) {
    if (params?.riskLevel == null) return null;

    return KeyValueModel(
      key: params?.riskLevel.toString(),
      title: params?.riskLevel.toString(),
    );
  },
);

final thongTinTaiSanTinhTP = StateProvider.family<KeyValueModel?, AssetCommons>(
  (ref, params) {
    ref.listenSelf((previous, next) {
      params.addressProvince = next?.key;
      if (previous == null && next != null) return;

      params.addressDistrict = null;
      ref.read(thongTinTaiSanQuanHuyen(params).notifier).state = null;
    });
    if (params.addressProvince == null) return null;

    return KeyValueModel(key: params.addressProvince, title: null);
  },
);

final thongTinTaiSanQuanHuyen =
    StateProvider.family<KeyValueModel?, AssetCommons>(
  (ref, params) {
    ref.listenSelf((previous, next) {
      params.addressDistrict = next?.key;
      if (previous == null && next != null) return;

      params.addressWard = null;
      ref.read(thongTinTaiSanXaPhuong(params).notifier).state = null;
    });
    if (params.addressDistrict == null) return null;

    return KeyValueModel(
      key: params.addressDistrict,
      title: null,
    );
  },
);

final thongTinTaiSanXaPhuong =
    StateProvider.family<KeyValueModel?, AssetCommons>(
  (ref, params) {
    ref.listenSelf((previous, next) {
      params.addressWard = next?.key;
    });
    if (params.addressWard == null) return null;

    return KeyValueModel(
      key: params.addressWard,
      title: null,
    );
  },
);

abstract class BaseAssetDetailPageController<T extends BaseDetailModel>
    extends BaseController<AssetsDetailState<T>> {
  BaseAssetDetailPageController(super.state, super.ref);

  final _cancelableAttachmentUploadRequest = <String, CancelToken>{};
  final _attachmentsUploadCompleter = <String, Completer<String>>{};

  Box<AssetsDetailModel<T>> get boxProvider;

  GlobalKey<FormState> detailKey = GlobalKey();

  bool get enableZoningImage => true;

  bool get enableUploadDinhVi => false;

  @override
  Future<void> initialLoad() async {
    await getAssetsDetail();
  }

  Future<void> getAssetsDetail() async {
    hasEditValue = false;
    var assetsModel = state.element.assetsModel;
    List<AssetsDetailModel<T>> lsItem = [];
    CancelToken cancelToken = CancelToken();
    ref.onDispose(() {
      log('dispose cancel token');
      cancelToken.cancel();
    });

    if (assetsModel == null) return;
    showLoading();
    final detailResponse =
        await ref.read(assetsApiProvider).getAssetDetailFromFileId(
              appraisalFileId: assetsModel.appraisalFileId ?? '',
              cancelToken: cancelToken,
            );

    final detailData = detailResponse.data;

    if (detailData == null) {
      return;
    }

    state = state.copyWith(surveyInfo: detailData);
    final imageResponse = detailData.assetImages ?? [];
    assetsModel = detailData;
    state.element.assetsModel = assetsModel;

    getListImageComplete(imageResponse);

    for (var element in assetsModel.assetCodes) {
      final detailAsset = boxProvider.get(element);
      if (detailAsset != null) {
        lsItem.add(detailAsset);
      }
    }

    if (lsItem.length == assetsModel.assetCodes.length && lsItem.isNotEmpty) {
      state.element.assetsModel = assetsModel;
      hideLoading();
      initDropdownList(lsItem);
      return;
    }

    final result = await ref.read(assetsApiProvider).getAssetDetail<T>(
          assetLevelTwoId: assetsModel.assetType.assetsLevel2Id,
          assetCodes: assetsModel.assetCodes,
          cancelToken: cancelToken,
        );

    hideLoading();
    final isOk = await handleResponse(result, (p0) => null);
    lsItem = result.data ?? [];

    if (lsItem.isEmpty ||
        lsItem.any((element) => element.assetObject == null)) {
      await showMessageDialog('Không tìm thấy thông tin tài sản');
      Navigator.maybePop(context);
      return;
    }

    initDropdownList(lsItem);
    if (!isOk) {
      Navigator.maybePop(context);
    }
  }

  /// Khởi tạo danh sách ảnh
  void getListImageComplete(List<Attachment> imageResponse) {
    state.assetImages = imageResponse;

    //     .where((element) => element.type == ImageType.info)
    //     .toList();

    // state.diagramImages = imageResponse
    //     .where((element) => element.type == ImageType.diagram)
    //     .toList();

    // state.otherImages = imageResponse
    //     .where((element) => element.type == ImageType.appendix)
    //     .toList();

    // state.locationImages = imageResponse
    //     .where((element) => element.type == ImageType.location)
    //     .toList();

    // state.zoningImages = imageResponse
    //     .where((element) => element.type == ImageType.zoning)
    //     .toList();

    // state.anhDinhVi = imageResponse
    //     .where((element) => element.type == ImageType.dinhVi)
    //     .toList();
  }

  void initDropdownList(List<AssetsDetailModel<T>> assets);

  ///Thông tin tài sản
  ExpandModel thongTinTaiSan(AssetsModel asset,
      {bool enableMotaChiTiet = true}) {
    List<ExpandModel> lsExpandAsset = [];
    for (AssetCommons element in (asset.assetCommons ?? [])) {
      final expandModel = ExpandModel(
        title: element.assetCode ?? '',
        isExpand: false,
        lsInputField: [
          InputFieldModel<String>(
            label: S.current.ma_tai_san,
            data: element.assetCode,
            enable: false,
          ),
          InputFieldModel<String>(
            label: S.current.tinh_tp,
            data: element.addressProvince,
            required: true,
            inputFieldType: InputFieldType.dropDown,
            selectedItemProvider: thongTinTaiSanTinhTP(element),
            listDataProvider: (p0) => p0.call(getListProvinceProvider),
          ),
          InputFieldModel<String>(
            label: S.current.tp_quan_huyen,
            inputFieldType: InputFieldType.dropDown,
            required: true,
            selectedItemProvider: thongTinTaiSanQuanHuyen(element),
            listDataProvider: (p0) =>
                p0.call(danhSachQuanHuyenProvider(element)),
          ),
          InputFieldModel<String>(
            label: S.current.xa_phuong_thi_tran,
            inputFieldType: InputFieldType.dropDown,
            required: true,
            selectedItemProvider: thongTinTaiSanXaPhuong(element),
            listDataProvider: (p0) =>
                p0.call(danhSachDuongPhoProvider(element)),
          ),
          if (enableMotaChiTiet)
            InputFieldModel<String>(
              label: S.current.mo_ta_chi_tiet,
              data: element.description,
              required: true,
              onTextChanged: (p0) => element.description = p0,
            ),
        ],
        topLsInputField: const [],
        child: const [],
      );
      lsExpandAsset.add(expandModel);
    }
    return ExpandModel(
      title: S.current.thong_tin_tai_san,
      isExpand: false,
      child: lsExpandAsset,
      lsInputField: const [],
      topLsInputField: [
        InputFieldModel<String>(
          label: S.current.dia_chi_tai_san_tu_los,
          data: asset.description ?? 'Hệ thống tự nhập',
          minLines: 4,
          maxLines: 4,
          enable: false,
          hint: 'Hệ thống tự nhập',
        ),
        if (visibleDiaChiTaiSanInGroupThongTin)
          InputFieldModel<String>(
            label: S.current.dia_chi_tai_san,
            data: asset.addressCustomDetail,
            minLines: 4,
            maxLines: 4,
            onTextChanged: (p0) {
              asset.addressCustomDetail = p0;
            },
          ),
      ],
    );
  }

  ///Chỉ show field địa chỉ tài sản ở Động sản
  bool get visibleDiaChiTaiSanInGroupThongTin => false;

  ///Thông tin chi nhánh
  ExpandModel thongTinChiNhanh(AssetsModel asset) {
    return ExpandModel(
      title: S.current.thong_tin_chi_nhanh,
      isExpand: false,
      child: const [],
      lsInputField: [
        InputFieldModel<String>(
            label: S.current.chi_nhanh_pgd,
            data: [
              asset.branch?.branchName,
              asset.transOffice?.transOfficeName,
            ].nonNulls.toList().join(' - '),
            enable: false),
        InputFieldModel<String>(
            label: S.current.ho_ten_CBTD,
            data: asset.rmName ?? '',
            enable: false),
        InputFieldModel<String>(
          label: S.current.sdt,
          data: asset.rmPhone ?? '',
          enable: false,
        ),
      ],
      topLsInputField: const [],
    );
  }

  ///Thông tin liên hệ và khảo sát tài sản
  ExpandModel thongTinLienHeVaKhaoSatTaiSan(AssetsModel asset) {
    return ExpandModel(
      title: S.current.thong_tin_lien_he_va_khao_sat_taisan,
      isExpand: false,
      lsInputField: [
        InputFieldModel<String>(
          label: S.current.nguoi_lien_he,
          data: asset.surveyGuide,
          onTextChanged: (newValue) {
            asset.surveyGuide = newValue;
          },
        ),
        InputFieldModel<String>(
          label: S.current.sdt,
          data: asset.surveyGuidePhone,
          onTextChanged: (newValue) {
            asset.surveyGuidePhone = newValue;
          },
        ),
        InputFieldModel<DateTime>(
          label: S.current.thoi_gian_khao_sat_du_kien,
          value: asset.surveyTime?.toLocal().toStringFormat(),
          inputFieldType: InputFieldType.customSelect,
          trailingIcon: const Icon(Icons.calendar_month),
          onTap: (context, controller) async {
            final result = await showDatePickerSelect(
              context,
              (asset.surveyTime?.toLocal() ?? DateTime.now()).toStringFormat(),
            );
            if (result != null) {
              controller.text = result.toStringFormat();
              asset.surveyTime = result.toUtc();
            }
          },
        ),
      ],
      topLsInputField: [],
      child: [],
    );
  }

  ///Thời gian khảo sát SBA thống nhất
  ExpandModel thoiGianKhaoSatSBA(AssetsModel asset) {
    return ExpandModel(
      key: thoiGianThongNhatSBA,
      title: S.current.thoi_gian_sba_thong_nhat,
      isExpand: false,
      lsInputField: [],
      topLsInputField: [],
      child: generateThoiGianKhaoSatSBA(asset),
    );
  }

  ///Thời gian khảo sát SBA
  List<ExpandModel> generateThoiGianKhaoSatSBA(AssetsModel info) {
    final result = <ExpandModel>[];
    // final lsInput = <>[];
    var surveySchedules = info.surveySchedules;
    if (surveySchedules.isEmpty) {
      surveySchedules.add(SurveyScheduleModel());
    }
    for (var i = 0; i < surveySchedules.length; i++) {
      final survey = surveySchedules[i];
      final legalExpand = getSurveyItem(survey);
      result.add(legalExpand);
    }

    return result;
  }

  ExpandModel getSurveyItem(SurveyScheduleModel survey) {
    bool isSaved = survey.surveyScheduleId != null;
    bool isLastItem =
        state.surveyInfo?.surveySchedules.lastOrNull?.id == survey.id;
    bool containNewItem = (state.surveyInfo?.surveySchedules ?? [])
        .any((element) => element.surveyScheduleId == null);
    bool allowAdd = !containNewItem && isLastItem;

    final batDauKhaoSat = InputFieldModel<DateTime>(
      label: S.current.bat_dau_khao_sat,
      value: survey.timeStart?.toLocal().toStringFormat(showSurveyTimeFormat),
      inputFieldType: InputFieldType.customSelect,
      enable: !isSaved,
      trailingIcon: const Icon(Icons.calendar_month),
      onTap: (context, controller) async {
        final result = await showDateTimePicker(context, survey.timeStart);
        if (result != null) {
          if (survey.timeEnd != null && survey.timeEnd!.isBefore(result)) {
            showMessageDialog(
              S.current.thoi_gian_bat_dau_khao_sat_phai_nho_hon,
            );
            return;
          }
          survey.timeStart = result.toUtc();
          controller.text = result.toStringFormat(showSurveyTimeFormat);
        }
      },
    );

    final ketThucKhaoSat = InputFieldModel<DateTime>(
      label: S.current.ket_thuc_khao_sat,
      value: survey.timeEnd?.toLocal().toStringFormat(showSurveyTimeFormat),
      inputFieldType: InputFieldType.customSelect,
      trailingIcon: const Icon(Icons.calendar_month),
      enable: isLastItem,
      onTap: (context, controller) async {
        final result = await showDateTimePicker(context, survey.timeEnd);
        if (result != null) {
          if (survey.timeStart != null && survey.timeStart!.isAfter(result)) {
            showMessageDialog(
              S.current.thoi_gian_ket_thuc_khao_sat_phai_lon_hon,
            );
            return;
          }
          survey.timeEnd = result.toUtc();
          controller.text = result.toStringFormat(showSurveyTimeFormat);
        }
      },
    );

    final chiTiet = InputFieldModel<String>(
      label: S.current.ghi_chu,
      data: survey.note,
      enable: isLastItem,
      onTextChanged: (newText) => survey.note = newText,
    );

    final khHenLai = InputFieldModel<bool>(
      label: S.current.khach_hang_hen_lai,
      inputFieldType: InputFieldType.custom,
      widgetBuilder: (context, ref, tap, data) {
        return checkBoxKHHenLai(
          context,
          S.current.khach_hang_hen_lai,
          survey.isMetCustomer,
          enable: state.surveyInfo?.surveySchedules.lastOrNull?.id == survey.id,
          (newValue) {
            bool value = newValue ?? false;
            survey.isMetCustomer = value;
            final lsLanLienHe = state.defaultInfoList
                .firstWhere(
                  (element) => element.key == thoiGianThongNhatSBA,
                )
                .child;
            lsLanLienHe.lastOrNull
              ?..allowAdd = value
              ..allowDelete = !isSaved;
            state = state.copyWith();
          },
        );
      },
    );

    return ExpandModel(
      id: lanLienHe,
      title: 'Lần liên hệ',
      isExpand: false,
      generateTitleIndex: true,
      allowAdd: isLastItem && survey.isMetCustomer == true,
      allowDelete: !isSaved,
      child: const [],
      removeExpandClicked: (context, ref, expandId) {
        removeTime(expandId, survey.id);
      },
      addNewExpandClicked: (context, ref, expandId) {
        bool containNewItem = (state.surveyInfo?.surveySchedules ?? [])
            .any((element) => element.surveyScheduleId == null);
        if (!containNewItem) {
          addNewTime();
        }
      },
      lsInputField: [
        batDauKhaoSat,
        ketThucKhaoSat,
        chiTiet,
        if (isSaved && isLastItem) khHenLai,
      ],
      topLsInputField: [],
    );
  }

  Widget checkBoxKHHenLai(BuildContext context, String title, bool? value,
      void Function(bool?)? onChanged,
      {bool enable = true}) {
    return HookConsumer(builder: (context, ref, child) {
      final isCheck = useState(value ?? false);
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (enable) {
            isCheck.value = !isCheck.value;
            onChanged?.call(isCheck.value);
          }
        },
        child: Row(
          children: [
            IgnorePointer(
              child: Checkbox(
                value: isCheck.value,
                onChanged: onChanged,
              ),
            ),
            Text(title),
          ],
        ),
      );
    });
  }

  ///Thông tin đề nghị
  ExpandModel generateThongTinDeNghi(CustomerModel? customerInfo) {
    final asset = state.element.assetsModel;
    int typeCreated = asset?.typeCreated ?? 0;
    return ExpandModel(
      title: S.current.thong_tin_de_nghi,
      isExpand: false,
      topLsInputField: [],
      lsInputField: [
        InputFieldModel<String>(
          label: S.current.ten_khach_hang,
          hint: 'Hệ thống tự nhập',
          value: typeCreated == 0
              ? customerInfo?.customerName
              : asset?.customerNameByLos?.toString() ?? '',
          enable: false,
        ),
        InputFieldModel<String>(
          label: S.current.loai_khach_hang,
          hint: 'Hệ thống tự nhập',
          value: customerInfo?.customerType?.customerTypeId == 2
              ? 'Tổ chức'
              : 'Cá nhân',
          enable: false,
        ),
      ],
      child: const [],
    );
  }

  ///Thông tin pháp lý
  List<ExpandModel> generateLegals(AssetsDetailModel<T> asset) {
    final result = <ExpandModel>[];
    // final lsInput = <>[];
    var legals = asset.asset.legalInformations;
    if (legals.isEmpty) {
      legals.add(LegalModel());
    }
    for (var i = 0; i < legals.length; i++) {
      final legal = legals[i];
      final lsInput = <InputFieldModel>[];
      final legalExpand = getLegalItem(legal, asset.asset.assetCode);
      result.add(legalExpand);
    }

    return result;
  }

  ///Thêm pháp lý
  void addNewLegal(String assetCode) {
    final assetId = (state.assets ?? [])
            .firstWhereOrNull((element) => element.asset.assetCode == assetCode)
            ?.asset
            .assetId ??
        '';
    if (assetId.isEmpty) return;
    final newLegalItem = LegalModel(assetId: assetId);
    final legalExpandItem = getLegalItem(newLegalItem, assetCode);
    final currentAssetIndex = (state.assets ?? [])
        .indexWhere((element) => element.assetCode == assetCode);
    final currentAsset = (state.assets ?? [])[currentAssetIndex];
    final assetObject = currentAsset.asset;
    assetObject.legalInformations.add(newLegalItem);

    var lsExpand = state.assetInfo[assetCode] ?? [];
    lsExpand
        .firstWhere((element) => element.key == phapLyKey)
        .child
        .add(legalExpandItem);
    state = state.copyWith();
  }

  ///Xóa pháp lý
  void removeLegal(String assetCode, String expandId, String legalId) {
    final currentAssetIndex = (state.assets ?? [])
        .indexWhere((element) => element.assetCode == assetCode);
    final currentAsset = (state.assets ?? [])[currentAssetIndex];
    final assetObject = currentAsset.asset;
    assetObject.legalInformations
        .removeWhere((element) => element.id == legalId);
    var lsExpand = state.assetInfo[assetCode] ?? [];
    var legalExpandModel =
        lsExpand.firstWhere((element) => element.key == phapLyKey);

    legalExpandModel.child.removeWhere((element) => element.id == expandId);
    if (legalExpandModel.child.isEmpty) {
      legalExpandModel.child = generateLegals(currentAsset);
    }
    state = state.copyWith();

    // ///Nếu xóa hết thông tin pháp lý thì phải thêm lại 1 cái rỗng
    // if (assetObject.legalInformations.isEmpty) {
    //   addNewLegal(assetCode);
    // }
  }

  ///Generate 1 thông tin pháp lý
  ExpandModel getLegalItem(LegalModel legal, String assetCode) {
    final legalInfo = legal.legalDocumentType ??= LegalInformationType();
    final tenHS = InputFieldModel<String>(
      hint: S.current.chon,
      label: S.current.ten_hs_phap_ly,
      inputFieldType: InputFieldType.dropDown,
      selectedValue: legal.legalInformationTypeId != null
          ? KeyValueModel(
              key: legal.legalInformationTypeId.toString(),
            )
          : null,
      listDataProvider: (p0) => p0.call(
        getListLegalsProvider(state.element.assetsModel?.assetLevelTwoId),
      ),
      onChange: (newValue) {
        if (newValue == null) {
          legal.legalInformationTypeId = null;
          return;
        }
        legal.legalInformationTypeId = int.tryParse(newValue.key ?? '');
        legalInfo
          ..legalDocumentTypeId = int.tryParse(newValue.key ?? '')
          ..name = newValue.title;
      },
    );

    final soHieu = InputFieldModel<String>(
      label: S.current.so_hieu,
      value: legal.legalInformationNumber,
      onTextChanged: (newValue) {
        legal.legalInformationNumber = newValue;
      },
    );

    final donViCap = InputFieldModel<String>(
      label: S.current.don_vi_cap,
      value: legal.issueUnit,
      onTextChanged: (newValue) {
        legal.issueUnit = newValue;
      },
    );

    final ngayCap = InputFieldModel<DateTime>(
      label: S.current.ngay_cap,
      value: legal.issueDate?.toLocal().toStringFormat(),
      inputFieldType: InputFieldType.customSelect,
      trailingIcon: const Icon(Icons.calendar_month),
      onTap: (context, controller) async {
        final result = await showDatePickerSelect(
          context,
          (legal.issueDate?.toLocal() ?? DateTime.now()).toStringFormat(),
        );
        if (result != null) {
          controller.text = result.toStringFormat();
          legal.issueDate = result.toUtc();
        }
      },
    );

    final chuSoHuu = InputFieldModel<String>(
      label: chuSoHuuLabel,
      value: legal.owner,
      required: requiredChuSoHuu,
      onTextChanged: (newValue) => legal.owner = newValue,
    );

    final chiTiet = InputFieldModel<String>(
      label: S.current.chi_tiet,
      value: legal.details,
      onTextChanged: (newValue) => legal.details = newValue,
    );

    return ExpandModel(
      title: S.current.thong_tin_phap_ly,
      isExpand: false,
      generateTitleIndex: true,
      allowAdd: true,
      allowDelete: true,
      child: [],
      topLsInputField: [],
      removeExpandClicked: (context, ref, expandId) {
        removeLegal(assetCode, expandId, legal.id ?? '');
      },
      addNewExpandClicked: (context, ref, expandId) {
        addNewLegal(assetCode);
      },
      lsInputField: [tenHS, soHieu, donViCap, ngayCap, chuSoHuu, chiTiet],
    );
  }

  ///Thông tin các label của HSPL, vì các loại tài sản label khác nhau
  String get chuSoHuuLabel => S.current.chu_so_huu;

  bool get requiredChuSoHuu => false;

  List<KeyValueModel> get getListQuyHoach => lsQuyHoach;

  ///Generate thông tin khác
  ExpandModel generateOtherInfo(T item) {
    //businessAdvantage
    final loiTheKinhDoanh = InputFieldModel<String>(
      label: S.current.loi_the_kinh_doanh,
      inputFieldType: InputFieldType.dropDown,
      listDataProvider: (p0) => p0.call(getLoiTheKinhDoanhProvider),
      selectedValue: item.businessAdvantage == null
          ? null
          : KeyValueModel(key: item.businessAdvantage),
      onChange: (newValue) => item.businessAdvantage = newValue?.key,
    );

    final hienTrangSuDung = InputFieldModel<String>(
      label: S.current.hien_trang_su_dung,
      value: item.currentUseSituation,
      onTextChanged: (newValue) => item.currentUseSituation = newValue,
    );

    final thongTinQuyHoach = InputFieldModel<String>(
      label: S.current.ttin_quy_hoach,
      inputFieldType: InputFieldType.dropDown,
      lsDropDown: getListQuyHoach,
      selectedValue: item.planningInfor == null
          ? null
          : getListQuyHoach
              .firstWhereOrNull((element) => item.planningInfor == element.key),
      onChange: (newValue) => item.planningInfor = newValue?.key,
    );

    final tinhThanhKhoan = InputFieldModel<String>(
      label: S.current.tinh_thanh_khoan,
      inputFieldType: InputFieldType.dropDown,
      listDataProvider: (p0) => p0.call(getTinhThanhKhoanProvider),
      selectedValue:
          item.liquidity == null ? null : KeyValueModel(key: item.liquidity),
      onChange: (newValue) => item.liquidity = newValue?.key,
    );

    final thongTinTranhChap = getThongTinTranhChap(item);

    final ghiChu = InputFieldModel<String>(
      label: S.current.ghi_chu,
      value: item.note,
      onTextChanged: (newValue) => item.note = newValue,
      maxLength: 4000,
    );

    return ExpandModel(
      title: S.current.thong_tin_khac,
      isExpand: false,
      child: [],
      topLsInputField: [],
      lsInputField: [
        loiTheKinhDoanh,
        hienTrangSuDung,
        thongTinQuyHoach,
        tinhThanhKhoan,
        thongTinTranhChap,
        ghiChu,
      ],
    );
  }

  InputFieldModel<String> getThongTinTranhChap(T item) {
    return InputFieldModel<String>(
      label: S.current.thong_tin_tranh_chap,
      lsDropDown: tTinTranhChap,
      inputFieldType: InputFieldType.dropDown,
      selectedValue: item.disputeInfor == null
          ? null
          : tTinTranhChap
              .firstWhereOrNull((element) => item.disputeInfor == element.key),
      onChange: (newValue) => item.disputeInfor = newValue?.key,
    );
  }

  void expandChildItem(ExpandModel model, bool isExpand) {
    // if (parentIndex == -1) {
    //   // header
    //   state.defaultInfoList.last.child[childIndex].isExpand = isExpanded;
    //   state = state.copyWith();
    // } else {
    //   state.assetInfo[assetKey]?[parentIndex].child[childIndex].isExpand =
    //       isExpanded;
    //   state = state.copyWith();
    // }
    model.isExpand = isExpand;
    state = state.copyWith();
  }

  T getCurrentAsset(String assetCode) {
    final currentAssetIndex = (state.assets ?? [])
        .indexWhere((element) => element.assetCode == assetCode);
    final currentAsset = (state.assets ?? [])[currentAssetIndex];
    final assetObject = currentAsset.asset;
    return assetObject;
  }

  ///Thêm Upload hình ảnh
  Future<void> addNewImagePressed(BuildContext context) async {
    final List<Attachment>? result = await showAttachmentPickerModalBottomSheet(
      context: context,
      initialAttachments: [],
    );
    if (result != null) {
      for (var element in result) {
        element.type = ImageType.info;
      }
      state = state.addNewImage(assetImages: result);
      _uploadAttachments(
        state.assetImages.map(
          (e) => e.id,
        ),
        type: ImageType.info,
      );
    }
  }

  ///
  Future<void> addNewDiagramPressed(BuildContext context) async {
    final List<Attachment>? result = await showAttachmentPickerModalBottomSheet(
        context: context, initialAttachments: []);
    if (result != null) {
      for (var element in result) {
        element.type = ImageType.diagram;
      }
      state = state.addNewImage(assetImages: result);
      _uploadAttachments(
        state.assetImages.map((e) => e.id),
        type: ImageType.diagram,
      );
    }
  }

  Future<void> addPhuLucHinhAnh(BuildContext context) async {
    final List<Attachment>? result = await showAttachmentPickerModalBottomSheet(
        context: context, initialAttachments: []);
    if (result != null) {
      for (var element in result) {
        element.type = ImageType.appendix;
      }
      state = state.addNewImage(assetImages: result);
      _uploadAttachments(
        result.map((e) => e.id).toList(),
        type: ImageType.appendix,
      );
    }
  }

  ///Thêm Upload hình ảnh
  Future<void> addUploadDinhVi(BuildContext context) async {
    final List<Attachment>? result = await showAttachmentPickerModalBottomSheet(
        context: context, initialAttachments: []);
    if (result != null) {
      for (var element in result) {
        element.type = ImageType.dinhVi;
      }
      state = state.addNewImage(assetImages: result);
      _uploadAttachments(
        state.assetImages.map((e) => e.id),
        type: ImageType.dinhVi,
      );
    }
  }

  ///Upload nhiều ảnh quy hoạch
  void themAnhQuyHoach(BuildContext context) async {
    final List<Attachment> result = (await showAttachmentPickerModalBottomSheet(
          context: context,
          initialAttachments: [],
        )) ??
        [];

    if (result.isNotEmpty) {
      for (var element in result) {
        element.type = ImageType.zoning;
      }
      state = state.addNewImage(assetImages: result);
      _uploadAttachments(
        state.assetImages.map((e) => e.id),
        type: ImageType.zoning,
      );
    }
  }

  ///Upload ảnh
  Future<void> _uploadAttachments(
    Iterable<String> attachmentIds, {
    ImageType type = ImageType.info,
  }) {
    var attachments = getListAttachmentFromType(type);

    attachments = attachments.where((it) {
      if (it.uploadState.isSuccess) return false;
      return attachmentIds.contains(it.id);
    }).toList();

    if (attachments.isEmpty) {
      return Future.value();
    }

    void updateAttachment(Attachment attachment, {bool remove = false}) {
      var lsAttach = getListAttachmentFromType(type);
      final index = lsAttach.indexWhere(
        (it) => it.id == attachment.id,
      );
      if (index != -1) {
        // update or remove attachment
        if (remove) {
          lsAttach = [...lsAttach]..removeAt(index);
        } else {
          lsAttach = [...lsAttach]..[index] = attachment;
        }
        state = state.copyWith(assetImages: lsAttach);
      }
    }

    return Future.wait(attachments.map((it) {
      final throttledUpdateAttachment = updateAttachment.throttled(
        const Duration(milliseconds: 500),
      );

      void onSendProgress(int sent, int total) {
        throttledUpdateAttachment([
          it.copyWith(
            uploadState: UploadState.inProgress(uploaded: sent, total: total),
          ),
        ]);
      }

      final cancelToken = CancelToken();
      Future<Attachment?> future = ref.read(fileServiceProvider).sendImage(
            it.file,
            code: state.element.assetsModel?.proposalCode,
            onSendProgress: onSendProgress,
            cancelToken: cancelToken,
          );
      _cancelableAttachmentUploadRequest[it.id] = cancelToken;
      return future.then((response) {
        log('Attachment ${it.id} uploaded successfully...');
        final resultAttach = it.copyWith(
          filename: response?.filename,
          ecmId: response?.ecmId,
          mediaType: response?.mediaType,
          uploadState: const UploadState.success(),
        );
        updateAttachment(resultAttach);
        uploadImageComplete(resultAttach);
        updateAssetImage();
      }).catchError((e, stk) {
        if (e is DioException && e.type == DioExceptionType.cancel) {
          log('Attachment ${it.id} upload cancelled');

          // remove attachment from message if cancelled.
          updateAttachment(it, remove: true);
          return;
        }

        log('error uploading the attachment', error: e, stackTrace: stk);
        updateAttachment(
          it.copyWith(uploadState: UploadState.failed(error: e.toString())),
        );
      }).whenComplete(() {
        throttledUpdateAttachment.cancel();
        _cancelableAttachmentUploadRequest.remove(it.id);
      });
    })).whenComplete(() {
      state.assetImages
          .where((element) => element.uploadState.isSuccess == true)
          .forEach((element) {
        _attachmentsUploadCompleter.remove(element.id)?.complete(element.id);
      });
    });
  }

  List<Attachment> getListAttachmentFromType(ImageType type) {
    return state.assetImages;
  }

  ///Lấy tất cả ảnh theo trạng thái
  List<Attachment> getAllImage({bool isSucess = true}) {
    return state.assetImages
        .where((element) => isSucess
            ? element.uploadState.isSuccess
            : !element.uploadState.isSuccess)
        .toList();
  }

  ///Lấy ảnh upload không thành công
  List<Attachment> getFailedImage() {
    return state.assetImages
        .where((element) => !element.uploadState.isSuccess)
        .toList();
  }

  ///Upload lại ảnh
  Future<void> retryAttachmentUpload(String attachmentId,
          {ImageType type = ImageType.info}) =>
      _uploadAttachments(
        [attachmentId],
        type: type,
      );

  void cancelAttachmentUpload(
    Attachment attachment, {
    String? reason,
  }) {
    final cancelToken = _cancelableAttachmentUploadRequest[attachment.id];
    deleteImage(attachment);
    if (cancelToken == null) {
      var infoImage = state.assetImages;
      var index = state.assetImages.indexWhere((element) =>
          element.id == attachment.id ||
          element.imageDownloadUrl == attachment.imageDownloadUrl);
      if (index != -1) {
        final deleteItem = state.assetImages.removeAt(index);
        if (deleteItem.imageDownloadUrl != null) {
          //call api delete
        }
      }
      state = state.copyWith();

      return;
    }
    if (cancelToken.isCancelled) {
      throw AppException('Upload request already cancelled');
    }
    cancelToken.cancel(reason);
  }

  void goToMapPage(BuildContext context) async {
    final Attachment? result = await AppRoutes.push(
      context,
      ProviderScope(
        overrides: [
          mapPageProvider.overrideWithValue(
            MapPageData(
              center: lastKnowPosition != null
                  ? LatLng(
                      lastKnowPosition!.latitude, lastKnowPosition!.longitude)
                  : null,
              proposalCode: state.element.assetsModel?.proposalCode,
              appraisalFileId: state.element.assetsModel?.appraisalFileId,
            ),
          )
        ],
        child: MapPage(),
      ),
    );
    if (result != null) {
      final oldLocationImage = state.locationImages;
      final resultImage = result.copyWith(
        uploadState: const UploadState.success(),
        type: ImageType.location,
      );
      state.assetImages
          .removeWhere((element) => element.type == ImageType.location);
      state = state.addNewImage(
        assetImages: [resultImage],
      );
      uploadImageComplete(resultImage);
      updateAssetImage();
    } else {}
  }

  void goToZoningPage(BuildContext context) async {
    final Attachment? result = await AppRoutes.push(
      context,
      ProviderScope(
        overrides: [
          zoningDataProvider.overrideWithValue(
            MapPageData(
              center: lastKnowPosition != null
                  ? LatLng(
                      lastKnowPosition!.latitude, lastKnowPosition!.longitude)
                  : null,
              proposalCode: state.element.assetsModel?.proposalCode,
              appraisalFileId: state.element.assetsModel?.appraisalFileId,
            ),
          )
        ],
        child: const ZoningMapPage(),
      ),
    );
    if (result != null) {
      // final defaultImage = state.zoningImages;
      final resultImage = result.copyWith(
        uploadState: const UploadState.success(),
        type: ImageType.zoning,
      );
      // defaultImage.add(resultImage);
      state = state.addNewImage(assetImages: [resultImage]);
      uploadImageComplete(resultImage);
      updateAssetImage();
    } else {}
  }

  ///Hoàn thành
  void complete() async {
    if (isShowLoading) return;
    bool hasTimeWithCustomer = state.surveyInfo?.surveySchedules
            .any((element) => element.surveyScheduleId != null) ==
        true;
    if (!hasTimeWithCustomer) {
      await showMessageDialog(
        'Vui lòng cập nhật Thông tin lịch khảo sát',
      );
      return;
    }
    bool isSaveOK = await save(showMessage: false);
    if (!isSaveOK) return;

    bool haveLocationImage = state.haveLocationImage;
    bool haveZoningImage = state.haveLocationImage;

    if (!haveLocationImage) {
      await DialogUtils.showMessageDialog(
        context,
        'Vui lòng cập nhật thông tin định vị',
      );
      goToMapPage(context);
      return;
    }

    if (!haveZoningImage && enableZoningImage) {
      await DialogUtils.showMessageDialog(
        context,
        'Vui lòng cập nhật thông tin quy hoạch',
      );
      goToZoningPage(context);
      return;
    }
    final lsImageUploadFailed = getFailedImage();
    if (lsImageUploadFailed.isNotEmpty) {
      final result = await showOkCancelAlertDialog(
        context: context,
        title: S.current.thong_bao,
        message:
            'Có ${lsImageUploadFailed.length} ảnh chưa upload thành công, bạn có muốn tiếp tục hoàn thành không?',
      );
      if (result != OkCancelResult.ok) {
        return;
      }
    }

    state.element.assetsModel?.exportType =
        state.assets?.map((e) => e.asset.exportType).toList();

    AppRoutes.push(
      context,
      ProviderScope(
        overrides: [
          assetsDetailProvider.overrideWithValue(
            state.element.assetsModel!,
          ),
        ],
        child: const SignPage(),
      ),
    );
  }

  ///Lưu
  Future<bool> save({bool showMessage = true}) async {
    if (isShowLoading) return false;
    updateSurveyInfo();
    final formOK = await validateData();
    if (!formOK) return false;

    Completer<bool> saveCompleter = Completer();

    final assetModel = state.element.assetsModel;
    final assetCommons = assetModel?.assetCommons ?? [];

    state.assets?.forEach((element) {
      element
        ..assetLevelThreeId = assetCommons
            .firstWhereOrNull((child) => element.assetCode == child.assetCode)
            ?.assetLevelThreeId
        ..assetLevelTwoId = assetModel?.assetLevelTwoId;
    });
    showLoading();

    updateAssetImage();

    ref
        .read(assetsApiProvider)
        .saveAsset<T>(
          appraisalFileId: assetModel?.appraisalFileId ?? '',
          assetLevelTwoId:
              assetModel?.assetLevelTwoId ?? AssetsTypeEnum.bds.assetsLevel2Id,
          items: state.assets ?? [],
        )
        .then((result) {
      hideLoading();

      handleResponse(result, (p0) {
        final code = p0?.body?.code;
        final mess = p0?.body?.message;
        final isSuccess = code == 200;
        if (isSuccess) {
          //Đã lưu, xóa khỏi cache
          hasEditValue = false;
          removeCache();
        }
        if ((showMessage || !isSuccess)) {
          showMessageDialog(mess ?? S.current.co_loi_xay_ra);
        }
        saveCompleter.complete(isSuccess);
      });
    });

    return saveCompleter.future;
  }

  Future<void> updateSurveyInfo() async {
    if (state.surveyInfo == null) return;
    final updateSurveyResult =
        await ref.read(assetsApiProvider).updateSurveyInfo(
              data: state.surveyInfo,
            );
    if (updateSurveyResult.isSuccess) {
      BotToast.showText(text: S.current.cap_nhat_thong_tin_ho_so_thanh_cong);
      final detailResponse =
          await ref.read(assetsApiProvider).getAssetDetailFromFileId(
                appraisalFileId: state.surveyInfo?.appraisalFileId ?? '',
              );

      if (detailResponse.isSuccess) {
        if (mounted) {
          state.surveyInfo?.surveySchedules =
              detailResponse.data?.surveySchedules ?? [];
          final oldThoiGianHen =
              state.defaultInfoList[state.defaultInfoList.length - 1];
          ExpandModel thoiGianHenSBA = thoiGianKhaoSatSBA(state.surveyInfo!);
          thoiGianHenSBA.isExpand = oldThoiGianHen.isExpand;
          state.defaultInfoList[state.defaultInfoList.length - 1] =
              thoiGianHenSBA;
          state = state.copyWith();
        }
      }
    }
  }

  Future updateAssetImage() {
    //Update image asset
    return ref.read(assetsApiProvider).updateImageList(
          lsAttachment: getAllImage(isSucess: true),
          appraisalFileId: state.element.assetsModel?.appraisalFileId ?? '',
        );
  }

  ///Cảnh báo rủi ro
  List<ExpandModel> generateListCBRR(AssetsDetailModel<T> asset) {
    final result = <ExpandModel>[];
    var riskFactor = asset.asset.riskDetails;

    if (riskFactor.isEmpty) {
      riskFactor.add(RiskFactorModel());
    }
    for (var i = 0; i < riskFactor.length; i++) {
      final risk = riskFactor[i];
      final lsInput = <InputFieldModel>[];
      final riskExpand = generateCBRR(risk, asset.asset.assetCode);
      result.add(riskExpand);
    }

    return result;
  }

  ///Generate 1 group CBRR
  ExpandModel generateCBRR(RiskFactorModel item, String assetCode) {
    final detail = item.riskAsset;

    final loai = InputFieldModel<String>(
      label: S.current.loai_cbrr,
      inputFieldType: InputFieldType.dropDown,
      listDataProvider: (p0) => p0.call(getCBRRProvider),
      selectedItemProvider: selectedCBRR(item),
      onChange: (newValue) =>
          item.riskTypeId = int.tryParse(newValue?.key ?? ''),
    );

    final noiDung = InputFieldModel<String>(
      label: S.current.noi_dung_cbrr,
      inputFieldType: InputFieldType.dropDown,
      listDataProvider: (p0) => p0.call(getCBRRContentProvider(
          state.element.assetsModel?.assetLevelTwoId ?? 1)),
      selectedItemProvider: selectedNoiDungCBRR(detail),
      onChange: (newValue) {
        item.riskAssetId = int.tryParse(newValue?.key ?? '');
        detail?.riskAssetId = int.tryParse(newValue?.key ?? '');
      },
    );

    final capDo = InputFieldModel<String>(
      label: S.current.cap_do,
      enable: false,
      inputFieldType: InputFieldType.dropDown,
      selectedItemProvider: selectedCapDoBCRR(detail),
      onChange: (value) {
        detail?.riskLevel = int.tryParse(value?.key ?? '');
      },
    );

    final chiTiet = InputFieldModel<String>(
        label: S.current.mo_ta_chi_tiet_cbrr,
        data: item.description,
        onTextChanged: (newValue) => item.description = newValue);

    return ExpandModel(
      title: S.current.canh_bao_rui_ro,
      isExpand: true,
      allowDelete: true,
      allowAdd: true,
      generateTitleIndex: true,
      child: [],
      topLsInputField: [],
      addNewExpandClicked: (context, ref, expandId) {
        addNewCBRR(assetCode);
      },
      removeExpandClicked: (context, ref, expandId) {
        deleteCBRR(assetCode, item.id ?? '', expandId);
      },
      lsInputField: [
        loai,
        noiDung,
        capDo,
        chiTiet,
      ],
    );
  }

  ///Thêm CBRR mới
  void addNewCBRR(String assetCode) {
    final currentAssetIndex = (state.assets ?? [])
        .indexWhere((element) => element.assetCode == assetCode);
    final currentAsset = (state.assets ?? [])[currentAssetIndex];
    RiskFactorModel riskFactor =
        RiskFactorModel(assetId: currentAsset.asset.assetId);
    final riskExpandItem = generateCBRR(riskFactor, assetCode);

    final assetObject = currentAsset.asset;
    assetObject.riskDetails.add(riskFactor);
    var lsExpand = state.assetInfo[assetCode] ?? [];
    lsExpand
        .firstWhere((element) => element.key == cbrr)
        .child
        .add(riskExpandItem);
    state = state.copyWith();
  }

  ///Xóa CBRR
  void deleteCBRR(String assetCode, String riskId, String expandId) {
    final currentAssetIndex = (state.assets ?? [])
        .indexWhere((element) => element.assetCode == assetCode);
    final currentAsset = (state.assets ?? [])[currentAssetIndex];
    final assetObject = currentAsset.asset;
    assetObject.riskDetails.removeWhere((element) => element.id == riskId);
    var lsExpand = state.assetInfo[assetCode] ?? [];
    var cbrrExpandModel = lsExpand.firstWhere((element) => element.key == cbrr);
    cbrrExpandModel.child.removeWhere((element) => element.id == expandId);
    if (cbrrExpandModel.child.isEmpty) {
      cbrrExpandModel.child = generateListCBRR(currentAsset);
    }
    state = state.copyWith();
  }

  Future<DateTime?> showDateTimePicker(
      BuildContext context, DateTime? selectedTime) async {
    final result = await showDatePickerSelect(
      context,
      (selectedTime?.toLocal() ?? DateTime.now()).toStringFormat(),
    );
    if (result != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(
          selectedTime ?? DateTime.now(),
        ),
      );
      if (time != null) {
        return DateTime(
            result.year, result.month, result.day, time.hour, time.minute);
      } else {
        return result;
      }
    }
    return null;
  }

  void removeTime(String expandId, String? id) {
    state.defaultInfoList.lastOrNull?.child
        .removeWhere((element) => element.id == expandId);
    state.surveyInfo?.surveySchedules
        .removeWhere((element) => element.id == id);
    if (state.defaultInfoList.lastOrNull?.child.isEmpty == true) {
      addNewTime();
    } else {
      state = state.copyWith();
    }
  }

  void addNewTime() {
    final newItem = SurveyScheduleModel();
    state.surveyInfo?.surveySchedules.add(newItem);
    state.defaultInfoList.lastOrNull?.child.add(getSurveyItem(newItem));
    state = state.copyWith();
  }

  void themAnhDinhVi(BuildContext context) async {
    final List<Attachment> result = (await showAttachmentPickerModalBottomSheet(
          context: context,
          initialAttachments: [],
          controller: AttachmentPickerController(maxAttachmentCount: 1),
        )) ??
        [];
    if (result.isNotEmpty) {
      final image = result.first;
      final assetsImage = state.assetImages;
      assetsImage.removeWhere((element) => element.type == ImageType.dinhVi);

      // assetsImage.add(image.copyWith(
      //   type: ImageType.location,
      //   uploadState: const UploadState.preparing(),
      // ));
      state = state.copyWith(
        assetImages: assetsImage,
      );

      LocationUtils.determinePosition().then((position) {
        ref.read(assetsApiProvider).updateLocation(
              appraisalFileId: state.element.assetsModel?.appraisalFileId ?? '',
              lat: position?.latitude,
              lng: position?.longitude,
            );
      });

      showLoading();
      final uploadResult = await ref.read(fileServiceProvider).sendImage(
            image.file,
            code: state.element.assetsModel?.proposalCode,
          );
      hideLoading();
      if (uploadResult != null) {
        final resultImage = uploadResult.copyWith(
          uploadState: const UploadState.success(),
          type: ImageType.location,
        );
        assetsImage.add(resultImage);
        state = state.copyWith(
          assetImages: assetsImage,
        );
        uploadImageComplete(resultImage);
        updateAssetImage();
      } else {
        showMessageDialog(S.current.loi_upload_tai_lieu);
      }
    }
  }

  @override
  void dispose() {
    if (hasEditValue) {
      ref.read(assetSavedProvider).put(
            state.element.assetsModel?.appraisalFileId ?? '',
            '',
          );

      for (AssetsDetailModel<T> element in (state.assets ?? [])) {
        var item = boxProvider.put(element.assetCode ?? '', element);
      }
    }

    super.dispose();
  }

  void removeCache() {
    ref.read(assetSavedProvider).delete(
          state.element.assetsModel?.appraisalFileId ?? '',
        );
    for (AssetsDetailModel<T> element in (state.assets ?? [])) {
      var item = boxProvider.delete(element.assetCode ?? '');
    }
  }

  Future<bool> validateData() async {
    String errorMess = '';
    for (var group in state.assetInfo.values) {
      for (var element in group) {
        errorMess = element.getError();
        if (errorMess.isNotEmpty) {
          errorMess = '${element.title}: $errorMess';
          break;
        }
      }
      if (errorMess.isNotEmpty) {
        break;
      }
    }
    for (AssetsDetailModel<T> element in (state.assets ?? [])) {
      final legals = element.assetObject?.legalInformations ?? [];
      int index = 1;
      for (var legal in legals) {
        final isOK = legal.isValid();
        if (!isOK) {
          errorMess =
              'Tài sản: ${element.assetCode ?? ''}: ${S.current.vui_long_nhap_thong_tin_phap_ly} $index';
          break;
        }
        index++;
      }
    }

    var formOK = detailKey.currentState?.validate() ?? true;
    if (errorMess.isEmpty && !formOK) {
      errorMess = S.current.vui_long_nhap_thong_tin;
    }
    if (errorMess.isNotEmpty) {
      showMessageDialog(errorMess);
      return false;
    }

    return true;
  }

  void uploadImageComplete(Attachment resultImage) {
    // state.element.assetsModel?.assetImages?.add(resultImage);
  }

  void deleteImage(Attachment deletedImage) {
    state.element.assetsModel?.assetImages?.removeWhere((element) =>
        element.id == deletedImage.id ||
        element.imageDownloadUrl == deletedImage.imageDownloadUrl);
  }
}
