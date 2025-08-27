import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:sba/gen/assets.gen.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/assets/assets_detail_model.dart';
import 'package:sba/src/models/assets/enum.dart';
import 'package:sba/src/models/assets/mmtb_model.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/assets/assets.dart';
import 'package:sba/src/screens/assets/detail/mmtb/machine_detail_page.dart';
import 'package:sba/src/screens/base/top_level_provider.dart';
import 'package:sba/src/utils/utils.dart';

class MMTBDetailPageController
    extends BaseAssetDetailPageController<MMTBModel> {
  MMTBDetailPageController(super.state, super.ref);

  static final detailPageControllerProvider = StateNotifierProvider.autoDispose
      .family<MMTBDetailPageController, AssetsDetailState<MMTBModel>,
          AssetDetailProviderElement>(
    (ref, element) {
      final controller = MMTBDetailPageController(
        AssetsDetailState.element(element),
        ref,
      );
      return controller;
    },
  );

  @override
  Box<AssetsDetailModel<MMTBModel>> get boxProvider =>
      ref.read(mmtbBoxProvider);

  @override
  bool get enableZoningImage => false;

  @override
  bool get enableUploadDinhVi => true;

  @override
  void initDropdownList(List<AssetsDetailModel<MMTBModel>> assets) {
    final customerInfo = state.element.assetsModel?.customer;

    ExpandModel ttinTaiSan = thongTinTaiSan(state.surveyInfo!);

    ExpandModel ttinChiNhanh = thongTinChiNhanh(state.surveyInfo!);

    ExpandModel thongTinDeNghi = generateThongTinDeNghi(customerInfo);

    ExpandModel thongTinKhaoSatTaiSan = thongTinLienHeVaKhaoSatTaiSan(
        state.surveyInfo ??=
            AssetsModel(surveySchedules: [], assetType: AssetsTypeEnum.ptdb));

    ExpandModel thoiGianHenSBA = thoiGianKhaoSatSBA(
      state.surveyInfo ??=
          AssetsModel(surveySchedules: [], assetType: AssetsTypeEnum.ptdb),
    );

    Map<String, List<ExpandModel>> assetMap = {};

    for (var element in assets) {
      var assetLevelThreeId = element.assetLevelThreeId ??
          state.surveyInfo?.assetCommons
              ?.firstWhereOrNull((item) => element.assetCode == item.assetCode)
              ?.assetLevelThreeId;

      ExpandModel thongTinPhapLy = ExpandModel(
        key: phapLyKey,
        title: S.current.thong_tin_phap_ly,
        isExpand: false,
        child: generateLegals(element),
        lsInputField: [],
        topLsInputField: [],
      );

      ExpandModel dacDiemKyThuat = ExpandModel(
        key: 'dacDiemKyThuat',
        title: S.current.dac_diem_thong_so_ky_thuat,
        isExpand: false,
        child: [],
        lsInputField: [
          if (assetLevelThreeId == AssetLevelThreeEnum.dayChuyenSanXuat.id)
            InputFieldModel<String>(
              label: S.current.ten_day_chuyen,
              data: element.asset.productLineName,
              onTextChanged: (newValue) =>
                  element.asset.productLineName = newValue,
              inputAction: TextInputAction.done,
            ),
          getDacDiemKyThuat(element),
          InputFieldModel<String>(
            inputFieldType: InputFieldType.custom,
            widgetBuilder: (context, ref, tap, data) {
              return TextButton.icon(
                onPressed: () async {
                  // await goToEditCHCCPage(context, ref, chccInfo, asset);
                  await addOrEditItem(element);
                  tap();
                },
                style: ButtonStyle(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: MaterialStateProperty.resolveWith(
                    (states) => EdgeInsets.zero,
                  ),
                ),
                icon: const Icon(Icons.add),
                label: const Text('Thêm'),
              );
            },
          )
        ],
        topLsInputField: [],
      );

      ExpandModel canhBaoRuiRo = ExpandModel(
        key: cbrr,
        title: S.current.canh_bao_rui_ro,
        isExpand: false,
        child: generateListCBRR(element),
        lsInputField: [],
        topLsInputField: [],
      );

      assetMap[element.assetCode ?? ''] = [
        thongTinPhapLy,
        dacDiemKyThuat,
        canhBaoRuiRo,
      ];
    }

    state = state.copyWith(
      assets: assets,
      defaultInfoList: [
        ttinTaiSan,
        ttinChiNhanh,
        thongTinDeNghi,
        thongTinKhaoSatTaiSan,
        thoiGianHenSBA,
      ],
      assetInfo: assetMap,
    );
  }

  @override
  String get chuSoHuuLabel => S.current.don_vi_nguoi_dung_ten_chu_so_huu;

  @override
  bool get requiredChuSoHuu => false;

  ///Thông tin đặc điểm kỹ thuật rút gọn
  InputFieldModel getDacDiemKyThuat(AssetsDetailModel<MMTBModel> detail) {
    return InputFieldModel<String>(
      inputFieldType: InputFieldType.custom,
      widgetBuilder: (context, ref, tap, data) {
        final lsItem = detail.asset.assetMachineInfors;
        return Column(
          children: lsItem
              .mapIndexed(
                (index, element) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                  child: ListTile(
                    onTap: () {
                      addOrEditItem(detail, machine: element);
                    },
                    leading: Assets.images.home.icMmtb.svg(
                      colorFilter: const ColorFilter.mode(
                          AppColor.secondaryColor, BlendMode.srcIn),
                    ),
                    contentPadding: const EdgeInsets.only(left: 8),
                    title: Text(
                      element.tenMMTB,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      element.brand,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          deleteMachine(detail, element);
                        },
                        icon: const Icon(Icons.delete)),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }

  Future<void> addOrEditItem(AssetsDetailModel<MMTBModel> detail,
      {MachineInfo? machine}) async {
    final machineInfo = machine ??
        MachineInfo(
          repairHistories: [],
          assetId: detail.assetObject?.assetId ?? '',
        );
    final result = await AppRoutes.push(
      context,
      ProviderScope(
        overrides: [machineProvider.overrideWithValue(machineInfo.copyWith())],
        child: const MachineDetailPage(),
      ),
    );
    if (result != null && result is MachineInfo) {
      if (machine == null) {
        detail.asset.assetMachineInfors.add(result);
      } else {
        final itemIndex = detail.asset.assetMachineInfors
            .indexWhere((element) => element.id == machine.id);
        detail.asset.assetMachineInfors[itemIndex] = result;
      }
      reloadDacDiemKyThuat(detail);
    }
  }

  void deleteMachine(AssetsDetailModel<MMTBModel> detail, MachineInfo element) {
    detail.asset.assetMachineInfors.remove(element);
    reloadDacDiemKyThuat(detail);
  }

  void reloadDacDiemKyThuat(AssetsDetailModel<MMTBModel> detail) {
    var assetLevelThreeId = detail.assetLevelThreeId ??
        state.surveyInfo?.assetCommons
            ?.firstWhereOrNull((item) => detail.assetCode == item.assetCode)
            ?.assetLevelThreeId;
    final lsDropDown = state.assetInfo[detail.assetCode ?? ''] ?? [];
    var dacDiemKyThuat = lsDropDown[1];
    if (assetLevelThreeId == AssetLevelThreeEnum.dayChuyenSanXuat.id) {
      dacDiemKyThuat.lsInputField[1] = getDacDiemKyThuat(detail);
    } else {
      dacDiemKyThuat.lsInputField[0] = getDacDiemKyThuat(detail);
    }
    state = state.copyWith();
  }

  @override
  bool visibleDiaChiTaiSanInGroupThongTin = true;
}
