import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_filex/open_filex.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/assets/mmtb_model.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/assets/assets.dart';
import 'package:sba/src/screens/assets/detail/ptdb/lichsu_suachua_page.dart';
import 'package:sba/src/screens/assets/state/detail_machine_state.dart';
import 'package:sba/src/services/file_service.dart';
import 'package:sba/src/utils/utils.dart';
import 'package:sba/src/services/providers/asset_api_provider.dart';
import 'package:sba/src/utils/validator_util.dart';
import 'package:sba/src/widgets/attachment/attachment_handler_io.dart';

class MachineDetailPageController
    extends BaseDetailInfoPageController<DetailMachineState> {
  MachineDetailPageController(super.state, super.ref);

  static final machineDetail = StateNotifierProvider.autoDispose
      .family<MachineDetailPageController, DetailMachineState, MachineInfo>(
    (ref, element) {
      final controller = MachineDetailPageController(
        DetailMachineState(
          expandList: [],
          machineInfo: element,
        ),
        ref,
      );
      return controller;
    },
  );

  @override
  Future<void> initialLoad() async {
    final result = <ExpandModel>[];
    final machineInfo = state.machineInfo;
    final expandModel = ExpandModel(
      key: '$phapLyThucTe-dacDiemKyThuat',
      title: 'Máy móc thiết bị',
      isExpand: true,
      child: [
        listDacDiemKyThuatPhapLy(machineInfo),
        listDacDiemKyThuatThucTe(machineInfo),
      ],
      copyLegalToFactual: copyDacDiemPhapLySangThucTe,
      lsInputField: [],
      topLsInputField: [],
    );
    ExpandModel thongTinSuaChuaVaBaoHanh = ExpandModel(
      key: 'thongTinSuaChuaVaBaoHanh',
      title: S.current.thong_tin_sua_chua_va_bao_hanh,
      isExpand: false,
      child: [],
      lsInputField: [
        getThongTinSuaChuaVaBaoHanh(state.machineInfo),
        InputFieldModel<String>(
          inputFieldType: InputFieldType.custom,
          widgetBuilder: (context, ref, tap, data) {
            return TextButton.icon(
              onPressed: () async {
                // await goToEditCHCCPage(context, ref, chccInfo, asset);
                await themThongTinSuaChuaBaoHanh();
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
    ExpandModel thongTinKhac = generateOtherInfo(state.machineInfo);
    state = state.copyWith(expandList: [
      expandModel,
      thongTinSuaChuaVaBaoHanh,
      thongTinKhac,
    ]);
  }

  ExpandModel listDacDiemKyThuatPhapLy(MachineInfo machineInfo) {
    var tenMMTB = InputFieldModel<String>(
      label: S.current.ten_mmtb,
      data: machineInfo.legalName,
      onTextChanged: (newValue) => machineInfo.legalName = newValue,
    );

    var nhanHieu = InputFieldModel<String>(
      label: S.current.nhan_hieu,
      data: machineInfo.legalBrand,
      onTextChanged: (newValue) => machineInfo.legalBrand = newValue,
    );

    var soMay = InputFieldModel<String>(
      label: S.current.so_may,
      data: machineInfo.legalEngineNo,
      onTextChanged: (newValue) {
        machineInfo.legalEngineNo = newValue;
      },
    );

    var soLoaiModel = InputFieldModel<String>(
      label: S.current.soloai_model,
      data: machineInfo.legalModel,
      onTextChanged: (newValue) => machineInfo.legalModel = newValue,
    );

    var namSanXuat = InputFieldModel<int>(
      label: S.current.nam_san_xuat,
      data: machineInfo.legalYearMfg,
      required: false,
      inputFormatter: [FilteringTextInputFormatter.digitsOnly],
      value: machineInfo.legalYearMfg?.toString() ?? '',
      onTextChanged: (newValue) => machineInfo.legalYearMfg = newValue,
      validator: (p0) {
        return Validator.validateYear(p0, required: false);
      },
    );

    var nuocSanXuat = InputFieldModel<String>(
      label: S.current.nuoc_san_xuat,
      inputFieldType: InputFieldType.dropDown,
      selectedValue: machineInfo.legalCountryMfgId != null
          ? KeyValueModel(
              id: machineInfo.legalCountryMfgId,
              key: machineInfo.legalCountryMfgId.toString(),
              title: machineInfo.legalCountryMfgName,
            )
          : null,
      listDataProvider: (p0) => p0.call(getListCountryProvider),
      onChange: (newValue) {
        machineInfo.legalCountryMfgId = newValue?.id;
        machineInfo.legalCountryMfgName = newValue?.title;
      },
    );

    var nhaSanXuat = InputFieldModel<String>(
      label: S.current.nha_san_xuat,
      data: machineInfo.legalMfr,
      onTextChanged: (newValue) => machineInfo.legalMfr = newValue,
    );

    var congSuat = InputFieldModel<double>(
      label: S.current.cong_suat,
      data: machineInfo.legalPower,
      onTextChanged: (newValue) => machineInfo.legalPower = newValue,
    );

    var cheDoDieuKhien = InputFieldModel<String>(
      label: S.current.che_do_dieu_khien,
      data: machineInfo.legalControlType,
      onTextChanged: (newValue) => machineInfo.legalControlType = newValue,
    );

    var kichThuoc = InputFieldModel<String>(
      label: S.current.kich_thuoc,
      data: machineInfo.legalSize,
      onTextChanged: (newValue) => machineInfo.legalSize = newValue,
    );

    var thongSoKyThuat = InputFieldModel<String>(
      label: S.current.thong_so_ky_thuat,
      data: machineInfo.legalSpecs,
      onTextChanged: (newValue) => machineInfo.legalSpecs = newValue,
    );

    var dongCoDien = InputFieldModel<String>(
      label: S.current.dong_co_dien,
      data: machineInfo.legalElectricEngine,
      onTextChanged: (newValue) => machineInfo.legalElectricEngine = newValue,
    );

    var dongCoChinh = InputFieldModel<String>(
      label: S.current.dong_co_chinh,
      data: machineInfo.legalMainEngine,
      onTextChanged: (newValue) => machineInfo.legalMainEngine = newValue,
    );

    var heThongThietBiDien = InputFieldModel<String>(
      label: S.current.he_thong_thiet_bi_dien,
      data: machineInfo.legalEngineSystem,
      onTextChanged: (newValue) => machineInfo.legalEngineSystem = newValue,
    );

    var soLuongMMTBTuongDong = InputFieldModel<int>(
      label: S.current.so_luong_mmtb_tuong_dong,
      data: machineInfo.legalCommonMachine,
      onTextChanged: (newValue) => machineInfo.legalCommonMachine = newValue,
    );

    var noiDungKhac = InputFieldModel<String>(
      label: S.current.noi_dung_khac,
      data: machineInfo.legalOtherContent,
      minLines: 4,
      maxLines: 4,
      onTextChanged: (newValue) => machineInfo.legalOtherContent = newValue,
    );

    return ExpandModel(
      title: '',
      isExpand: false,
      child: [],
      lsInputField: [
        tenMMTB,
        nhanHieu,
        soMay,
        soLoaiModel,
        namSanXuat,
        nuocSanXuat,
        nhaSanXuat,
        congSuat,
        cheDoDieuKhien,
        kichThuoc,
        thongSoKyThuat,
        dongCoDien,
        dongCoChinh,
        heThongThietBiDien,
        soLuongMMTBTuongDong,
        noiDungKhac,
      ],
      topLsInputField: [],
    );
  }

  ExpandModel listDacDiemKyThuatThucTe(MachineInfo machineInfo) {
    var tenMMTB = InputFieldModel<String>(
      label: S.current.ten_mmtb,
      required: true,
      data: machineInfo.realName,
      onTextChanged: (newValue) => machineInfo.realName = newValue,
    );

    var nhanHieu = InputFieldModel<String>(
      label: S.current.nhan_hieu,
      data: machineInfo.realBrand,
      onTextChanged: (newValue) => machineInfo.realBrand = newValue,
    );

    var soMay = InputFieldModel<String>(
      label: S.current.so_may,
      required: true,
      data: machineInfo.realEngineNo,
      onTextChanged: (newValue) {
        machineInfo.realEngineNo = newValue;
      },
    );

    var soLoaiModel = InputFieldModel<String>(
      label: S.current.soloai_model,
      required: true,
      data: machineInfo.realModel,
      onTextChanged: (newValue) => machineInfo.realModel = newValue,
    );

    var namSanXuat = InputFieldModel<int>(
        label: S.current.nam_san_xuat,
        required: true,
        inputFormatter: [FilteringTextInputFormatter.digitsOnly],
        value: machineInfo.realYearMfg?.toString() ?? '',
        data: machineInfo.realYearMfg,
        onTextChanged: (newValue) => machineInfo.realYearMfg = newValue,
        validator: Validator.validateYear);

    var nuocSanXuat = InputFieldModel<String>(
      label: S.current.nuoc_san_xuat,
      required: true,
      inputFieldType: InputFieldType.dropDown,
      selectedValue: machineInfo.realCountryMfgId != null
          ? KeyValueModel(
              id: machineInfo.realCountryMfgId,
              key: machineInfo.realCountryMfgId.toString(),
              title: machineInfo.realCountryMfgName,
            )
          : null,
      listDataProvider: (p0) => p0.call(getListCountryProvider),
      onChange: (newValue) {
        machineInfo.realCountryMfgId = newValue?.id;
        machineInfo.realCountryMfgName = newValue?.title;
      },
    );

    var nhaSanXuat = InputFieldModel<String>(
      label: S.current.nha_san_xuat,
      data: machineInfo.realMfr,
      onTextChanged: (newValue) => machineInfo.realMfr = newValue,
    );

    var congSuat = InputFieldModel<double>(
      label: S.current.cong_suat,
      data: machineInfo.realPower,
      onTextChanged: (newValue) => machineInfo.realPower = newValue,
    );

    var cheDoDieuKhien = InputFieldModel<String>(
      label: S.current.che_do_dieu_khien,
      data: machineInfo.realControlType,
      onTextChanged: (newValue) => machineInfo.realControlType = newValue,
    );

    var kichThuoc = InputFieldModel<String>(
      label: S.current.kich_thuoc,
      data: machineInfo.realSize,
      onTextChanged: (newValue) => machineInfo.realSize = newValue,
    );

    var thongSoKyThuat = InputFieldModel<String>(
      label: S.current.thong_so_ky_thuat,
      data: machineInfo.realSpecs,
      onTextChanged: (newValue) => machineInfo.realSpecs = newValue,
    );

    var dongCoDien = InputFieldModel<String>(
      label: S.current.dong_co_dien,
      data: machineInfo.realElectricEngine,
      onTextChanged: (newValue) => machineInfo.realElectricEngine = newValue,
    );

    var dongCoChinh = InputFieldModel<String>(
      label: S.current.dong_co_chinh,
      data: machineInfo.realMainEngine,
      onTextChanged: (newValue) => machineInfo.realMainEngine = newValue,
    );

    var heThongThietBiDien = InputFieldModel<String>(
      label: S.current.he_thong_thiet_bi_dien,
      data: machineInfo.realEngineSystem,
      onTextChanged: (newValue) => machineInfo.realEngineSystem = newValue,
    );

    var soLuongMMTBTuongDong = InputFieldModel<int>(
      label: S.current.so_luong_mmtb_tuong_dong,
      data: machineInfo.realCommonMachine,
      onTextChanged: (newValue) => machineInfo.realCommonMachine = newValue,
    );

    var noiDungKhac = InputFieldModel<String>(
      label: S.current.noi_dung_khac,
      data: machineInfo.realOtherContent,
      minLines: 4,
      maxLines: 4,
      onTextChanged: (newValue) => machineInfo.realOtherContent = newValue,
    );

    return ExpandModel(
      title: '',
      isExpand: false,
      child: [],
      lsInputField: [
        tenMMTB,
        nhanHieu,
        soMay,
        soLoaiModel,
        namSanXuat,
        nuocSanXuat,
        nhaSanXuat,
        congSuat,
        cheDoDieuKhien,
        kichThuoc,
        thongSoKyThuat,
        dongCoDien,
        dongCoChinh,
        heThongThietBiDien,
        soLuongMMTBTuongDong,
        noiDungKhac,
      ],
      topLsInputField: [],
    );
  }

  void copyDacDiemPhapLySangThucTe() {
    final info = state.machineInfo;
    info
      ..realName = info.legalName
      ..realBrand = info.legalBrand
      ..realModel = info.legalModel
      ..realColor = info.legalColor
      ..realYearMfg = info.legalYearMfg
      ..realCountryMfgId = info.legalCountryMfgId
      ..realMfr = info.legalMfr
      ..realPower = info.legalPower
      ..realControlType = info.legalControlType
      ..realSize = info.legalSize
      ..realSpecs = info.legalSpecs
      ..realEngine = info.legalEngine
      ..realElectricEngine = info.legalElectricEngine
      ..realMainEngine = info.legalMainEngine
      ..realEngineSystem = info.legalEngineSystem
      ..realCommonMachine = info.legalCommonMachine
      ..realOtherContent = info.legalOtherContent
      ..realEngineNo = info.legalEngineNo;
    initialLoad();
  }

  InputFieldModel getThongTinSuaChuaVaBaoHanh(MachineInfo detail) {
    final lsItem = detail.repairHistories;
    return InputFieldModel<String>(
      inputFieldType: InputFieldType.custom,
      widgetBuilder: (context, ref, tap, data) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: lsItem
              .mapIndexed(
                (index, element) =>
                    thongTinSuaChuaWidget(context, element, detail, tap),
              )
              .toList(),
        );
      },
    );
  }

  Widget thongTinSuaChuaWidget(BuildContext context, RepairHistory element,
      MachineInfo item, Function() tap) {
    return GestureDetector(
      onTap: () async {
        await chiTietSuaChuaBaoHanh(context, element);
        tap.call();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Theme.of(context).dividerColor,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.note,
                  size: 20,
                ),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Text(
                    element.note ?? '',
                    style: context.textMediumMedium,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    openFile(context, element);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: Icon(Icons.link),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                GestureDetector(
                  onTap: () {
                    deleteThongTinSuaChuaBaoHanh(item, element);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: Icon(Icons.delete),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.account_box_rounded,
                  size: 20,
                ),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Text(
                    element.whoUpload ?? '',
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.calendar_month_outlined,
                  size: 20,
                ),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Text(
                    element.dateRepair?.toLocal().toStringFormat() ?? '',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ExpandModel generateOtherInfo(MachineInfo item) {
    final nguonGoc = InputFieldModel<String>(
      label: S.current.nguon_goc,
      data: item.usingOrigin,
      onTextChanged: (newValue) => item.usingOrigin = newValue,
    );

    final hienTrangSuDung = InputFieldModel<String>(
      label: S.current.hien_trang_su_dung,
      value: item.currentUseSituation,
      onTextChanged: (newValue) => item.currentUseSituation = newValue,
    );

    final khaMaiTinhThanhKhoan = InputFieldModel<String>(
      label: S.current.kha_mai_tinh_thanh_khoan,
      inputFieldType: InputFieldType.dropDown,
      lsDropDown: tinhThanhKhoan,
      selectedValue: item.liquidity == null
          ? null
          : tinhThanhKhoan
              .firstWhereOrNull((element) => item.liquidity == element.key),
      onChange: (newValue) => item.liquidity = newValue?.key,
    );

    final chatLuongConLai = InputFieldModel<double>(
      label: S.current.chat_luong_con_lai,
      data: item.remainQuality,
      onTextChanged: (newText) => item.remainQuality = newText,
      validator: Validator.validatePercent,
      required: false,
    );

    final thongTinTranhChap = InputFieldModel<String>(
      label: S.current.thong_tin_tranh_chap,
      inputFieldType: InputFieldType.dropDown,
      lsDropDown: tTinTranhChap,
      selectedValue: item.disputeInfor == null
          ? null
          : tTinTranhChap
              .firstWhereOrNull((element) => item.disputeInfor == element.key),
      onChange: (newValue) => item.disputeInfor = newValue?.key,
    );

    final soNgayDaSuDung = InputFieldModel<int>(
      label: S.current.so_ngay_da_su_dung,
      data: item.dayUse,
      onTextChanged: (newValue) => item.dayUse = newValue,
    );

    final ghiChu = InputFieldModel<String>(
      label: S.current.ghi_chu,
      value: item.note,
      maxLength: 4000,
      onTextChanged: (newValue) => item.note = newValue,
    );

    return ExpandModel(
      title: S.current.thong_tin_khac,
      isExpand: false,
      child: [],
      topLsInputField: [],
      lsInputField: [
        nguonGoc,
        hienTrangSuDung,
        khaMaiTinhThanhKhoan,
        chatLuongConLai,
        thongTinTranhChap,
        soNgayDaSuDung,
        ghiChu,
      ],
    );
  }

  void deleteThongTinSuaChuaBaoHanh(MachineInfo detail, RepairHistory element) {
    detail.repairHistories.remove(element);
    reloadThongTinSuaChuaVaBaoHanh(detail);
  }

  void reloadThongTinSuaChuaVaBaoHanh(MachineInfo detail) {
    final lsDropDown = state.expandList;
    var thongTinSuaChuaBaoHanh = lsDropDown[1];
    thongTinSuaChuaBaoHanh.lsInputField[0] =
        getThongTinSuaChuaVaBaoHanh(detail);
    state = state.copyWith();
  }

  Future<bool> uploadThongTinSuaChua(RepairHistory item) async {
    showLoadingDialog();
    final result =
        await ref.read(fileServiceProvider).sendFile(item.fileAttach);
    hideLoadingDialog();
    final isOK = await handleResponse(result, (p0) => null);
    if (isOK && result.data != null) {
      item.uploadFileComplete(result.data!);
      return true;
    }
    return false;
  }

  Future<void> chiTietSuaChuaBaoHanh(
      BuildContext context, RepairHistory element) async {
    var item = element.copyWith();
    final result = await showModalBottomSheet<RepairHistory?>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: LichSuSuaChuaPage(
            item: item,
            lsItem: [
              InputFieldModel<String>(
                label: S.current.trang_thai,
                inputFieldType: InputFieldType.dropDown,
                lsDropDown: RepairHistory.lsTrangThai,
                selectedValue: item.trangThai,
                onChange: (newValue) {
                  item.repairStatusId = newValue?.id;
                },
              ),
              InputFieldModel<DateTime>(
                label: S.current.ngay_thuc_hien_sua_chua,
                inputFieldType: InputFieldType.date,
                readOnly: true,
                data: item.dateRepair,
                onTextChanged: (newValue) => item.dateRepair = newValue,
              ),
              InputFieldModel<String>(
                label: S.current.mo_ta,
                data: item.note,
                onTextChanged: (newValue) => item.note = newValue,
                inputAction: TextInputAction.done,
              ),
              InputFieldModel<String>(
                label: S.current.file_tai_lieu,
                value: item.tenTaiLieu,
                inputFieldType: InputFieldType.customSelect,
                suffixIcon: (context, controller) {
                  return IconButton(
                    onPressed: () async {
                      final fileResult = await pickFile(context);
                      await item.addAttachmentResult(fileResult);
                      controller.text = item.tenTaiLieu;
                    },
                    icon: const Icon(Icons.attach_file),
                  );
                },
                onTap: (context, controller) async {
                  //open file
                  if (item.fileAttach != null) {
                    OpenFilex.open(item.fileAttach?.path ?? '');
                  } else {
                    openFile(context, item);
                  }
                },
              )
            ],
            uploadFile: (context, item) {
              return uploadThongTinSuaChua(item);
            },
          ),
        );
      },
    );
    if (result != null) {
      final asset = state.machineInfo;
      final itemIndex = asset.repairHistories.indexOf(element);
      if (itemIndex >= 0) {
        asset.repairHistories[itemIndex] = result;
      } else {
        asset.repairHistories.add(result);
      }
      reloadThongTinSuaChuaVaBaoHanh(asset);
    }
  }

  Future<void> themThongTinSuaChuaBaoHanh() async {
    return chiTietSuaChuaBaoHanh(
      context,
      RepairHistory(assetId: state.machineInfo.assetId, repairDocument: ''),
    );
  }

  void openFile(BuildContext context, RepairHistory item) async {
    showLoadingDialog();
    String? path = await AttachmentHandler.instance.downloadAttachmentFile(
      ref,
      Attachment(
        ecmId: item.ecmId,
        filename: item.filename,
      ),
      onReceiveProgress: (count, total) {},
    );
    hideLoadingDialog();
    if (path != null) {
      OpenFilex.open(path);
    }
  }

  @override
  Future<bool> saveData() async {
    var isOk = await validateData();
    if (!isOk) return false;
    Navigator.of(context).pop(state.machineInfo);
    return isOk;
  }
}
