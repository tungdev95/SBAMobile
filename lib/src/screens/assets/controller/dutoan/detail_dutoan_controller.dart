import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/assets/assets.dart';
import 'package:sba/src/screens/assets/controller/bds/bds.dart';
import 'package:sba/src/screens/assets/detail/dutoan/congtrinh_tuonglai_page.dart';
import 'package:sba/src/services/providers/bds_api_provider.dart';
import 'package:sba/src/utils/utils.dart';

class DetailDuToanPageController extends DetailLandInfoPageController {
  DetailDuToanPageController(super.state, super.ref);

  static final detailLandInfoProvider = StateNotifierProvider.autoDispose
      .family<DetailDuToanPageController, DetailLandState, DetailData>(
    (ref, element) {
      final controller = DetailDuToanPageController(
        DetailLandState(
          landInfo: element.landInfo,
          expandList: [],
          detailModel: element.detailModel,
        ),
        ref,
      );
      return controller;
    },
  );

  @override
  Future<void> initialLoad() async {
    final lsExpand = <ExpandModel>[];
    final landInfo = state.landInfo;
    ExpandModel thongTinThuaDat = ExpandModel(
      key: '$phapLyThucTe-thuaDat',
      title: S.current.thong_tin_thua_dat,
      isExpand: false,
      topLsInputField: [
        InputFieldModel<String>(
          label: S.current.so_thua,
          value: landInfo.landPlotNumber,
          onTextChanged: (newValue) => landInfo.landPlotNumber = newValue,
        ),
        InputFieldModel<String>(
          label: S.current.so_to_ban_do,
          value: landInfo.mapSheetNumber,
          onTextChanged: (newValue) => landInfo.mapSheetNumber = newValue,
        ),
      ],
      child: [
        generatelandInfo(landInfo),
        generateRealLandInfo(landInfo),
      ],
      lsInputField: [
        InputFieldModel<String>(
          label: S.current.doan_duong_trong_khung_gia,
          inputFieldType: InputFieldType.dropDown,
          listDataProvider: (p0) => p0.call(
            getDoanDuongTrongKhungGiaProvider(landInfo),
          ),
          selectedItemProvider: selectedRoadInPrice(landInfo),
          onChange: (newValue) =>
              landInfo.roadInPriceRange = int.tryParse(newValue?.key ?? ''),
        ),
        InputFieldModel<String>(
          label: S.current.loai_duong_tiep_giap,
          inputFieldType: InputFieldType.dropDown,
          listDataProvider: (p0) => p0.call(
            getLoaiDuongTiepGiapProvider,
          ),
          selectedValue: landInfo.roadContiguousTypeId == null
              ? null
              : KeyValueModel(
                  key: landInfo.roadContiguousTypeId.toString(),
                ),
          onChange: (newValue) {
            landInfo.roadContiguousTypeId = int.tryParse(newValue?.key ?? '');
          },
        ),
        InputFieldModel<String>(
          label: S.current.vi_tri,
          inputFieldType: InputFieldType.dropDown,
          listDataProvider: (p0) => p0.call(
            getPositionProvider,
          ),
          selectedValue: landInfo.positionId == null
              ? null
              : KeyValueModel(
                  key: landInfo.positionId.toString(),
                ),
          onChange: (newValue) {
            landInfo.positionId = int.tryParse(newValue?.key ?? '');
          },
        ),
        InputFieldModel<String>(
          label: S.current.khu_vuc,
          inputFieldType: InputFieldType.dropDown,
          listDataProvider: (p0) => p0.call(
            getZoneProvider,
          ),
          selectedValue: landInfo.zoneId == null
              ? null
              : KeyValueModel(
                  key: landInfo.zoneId.toString(),
                ),
          onChange: (newValue) {
            landInfo.zoneId = int.tryParse(newValue?.key ?? '');
          },
        ),
        InputFieldModel<double>(
          label: S.current.kc_den_duong_chinh,
          // value: landInfo.distanceToMainRoad?.toString(),
          data: landInfo.distanceToMainRoad,
          onTextChanged: (newText) {
            landInfo.distanceToMainRoad = newText;
          },
        ),
        InputFieldModel<String>(
          label: S.current.vi_tri_trong_khung_gia,
          inputFieldType: InputFieldType.dropDown,
          listDataProvider: (p0) => p0.call(
            getViTriTrongKhungGiaProvider,
          ),
          selectedValue: landInfo.positionInPriceRangeId == null
              ? null
              : KeyValueModel(
                  key: landInfo.positionInPriceRangeId.toString(),
                ),
          onChange: (newValue) => landInfo.positionInPriceRangeId =
              int.tryParse(newValue?.key ?? ''),
        ),
        InputFieldModel<double>(
          label: S.current.do_rong_duong_nn,
          data: landInfo.minWidthToMainRoad,
          onTextChanged: (newValue) => landInfo.minWidthToMainRoad = newValue,
        ),
        InputFieldModel<double>(
          label: S.current.do_rong_duong_ln,
          data: landInfo.maxWidthToMainRoad,
          onTextChanged: (newValue) => landInfo.maxWidthToMainRoad = newValue,
        ),
        InputFieldModel<String>(
          label: S.current.ghi_chu,
          value: landInfo.note,
          enable: false,
        ),
      ],
    );
    ExpandModel dacDiemThuaDat = ExpandModel(
      key: '$phapLyThucTe-dacDiemThuaDat',
      title: 'Đặc điểm thửa đất',
      isExpand: false,
      child: [
        listDacTiemThuaDatPhapLy(landInfo),
        listDacTiemThuaDatThucTe(landInfo)
      ],
      copyLegalToFactual: () {
        copyThuaDatPhapLySangThucTe(landInfo);
      },
      lsInputField: const [],
      topLsInputField: [],
    );

    ExpandModel mucDichSuDung = ExpandModel(
      key: mucDichSDDat,
      title: S.current.muc_dich_sd,
      isExpand: false,
      child: const [],
      lsInputField: const [],
      trailingExpandWidgetBuilder: (context, ref) {
        return CupertinoSwitch(
          activeColor: Theme.of(context).primaryColor,
          value: state.landInfo.haveLandingPurpose,
          onChanged: (newValue) {
            toggleMucDichSuDungDat(newValue);
          },
        );
      },
      topLsInputField: [],
    );

    if (landInfo.assetLandUsingPurposes.isNotEmpty) {
      var lsChild = <ExpandModel>[];
      landInfo.assetLandUsingPurposes.forEachIndexed((index, element) {
        lsChild.add(generateMucDichSDDat(element));
      });
      mucDichSuDung.child = lsChild;
    }

    ExpandModel cayTrong = generateGroupCayTrong();

    ExpandModel congTrinhXayDung = generateGroupCTXD();

    ExpandModel hopThua = thongTinHopThua();

    ExpandModel congTrinhTuongLai = ExpandModel(
      title: S.current.cong_trinh_tuong_lai,
      isExpand: false,
      child: const [],
      lsInputField: [
        InputFieldModel<String>(
          label: S.current.cong_trinh_tuong_lai,
          data: landInfo.contructionFutureText,
          onTextChanged: (newValue) =>
              landInfo.contructionFutureText = newValue,
        ),
        InputFieldModel<String>(
          inputFieldType: InputFieldType.custom,
          widgetBuilder: (context, ref, tap, data) {
            return Align(
              alignment: Alignment.topRight,
              child: TextButton.icon(
                onPressed: () async {
                  await chiTietCongTrinhTuongLai(context, ref, landInfo);
                  tap();
                },
                style: ButtonStyle(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: MaterialStateProperty.resolveWith(
                    (states) => EdgeInsets.zero,
                  ),
                ),
                icon: const Icon(Icons.edit),
                label: Text(S.current.chi_tiet),
              ),
            );
          },
        )
      ],
      topLsInputField: [],
    );

    lsExpand.add(thongTinThuaDat);
    lsExpand.add(dacDiemThuaDat);
    lsExpand.add(mucDichSuDung);
    lsExpand.add(cayTrong);
    lsExpand.add(congTrinhXayDung);
    lsExpand.add(hopThua);
    lsExpand.add(congTrinhTuongLai);

    state = state.copyWith(expandList: lsExpand);

    if (landInfo.haveLandingPurpose == true) {
      toggleMucDichSuDungDat(true);
    }
    if (landInfo.haveCayTrong == true) {
      toggleCayTrong(true);
    }
    if (landInfo.haveCTXD == true) {
      toggleCTXD(true);
    }

    updateHopThua(state.landInfo.isConsolidation);
  }

  Future chiTietCongTrinhTuongLai(
      BuildContext context, WidgetRef ref, AssetLandInfo landInfo) async {
    AssetLandInfo? result = await AppRoutes.push(
      context,
      ProviderScope(
        overrides: [
          detailDuToanLandProvider.overrideWithValue(
            DetailData(
              landInfo: landInfo,
              detailModel: state.detailModel,
            ),
          )
        ],
        child: const CongTrinhTuongLaiPage(),
      ),
    );
    if (result != null) {
      state = state.copyWith(landInfo: result);
    }
  }
}
