import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sba/gen/assets.gen.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/chcc_fast_valuation_model.dart';
import 'package:sba/src/screens/base/base_page.dart';
import 'package:sba/src/screens/dinhgianhanh/controller/ketqua_dinhgia_chcc_page_controller.dart';
import 'package:sba/src/screens/dinhgianhanh/state/ketqua_dinhgia_chcc_state.dart';
import 'package:sba/src/utils/base_flutter_extensions.dart';
import 'package:sba/src/widgets/buttons/stadium_button.dart';
import 'package:sba/src/widgets/keyvalule_widget.dart';
import 'package:sba/src/widgets/widget_network_image.dart';

final ketQuaDinhGiaNhanhCHCCItem =
    Provider.autoDispose<CHCCFastValModel>((ref) {
  throw UnimplementedError();
});

class KetQuaDinhGiaNhanhCHCCPage extends BasePage<
    KetQuaDinhGiaNhanhCHCCPageController, KetQuaDinhGiaNhanhCHCCState> {
  @override
  String get title => S.current.dinh_gia_nhanh_chung_cu;

  @override
  Color backgroundColor(BuildContext context) => Colors.white;

  const KetQuaDinhGiaNhanhCHCCPage({super.key});

  @override
  Widget bodyWidget(
      BuildContext context, WidgetRef ref, KetQuaDinhGiaNhanhCHCCState state) {
    final detail = state.detail;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Assets.images.icKetquaDinhgiaNhadat.image(fit: BoxFit.cover),
            const SizedBox(
              height: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                KeyValueWidget(
                  title: S.current.vi_tri_bat_dong_san,
                  value: detail.address,
                ),
                KeyValueWidget(
                  title: S.current.dien_tich_sd_rieng,
                  value: detail.privateUseArea?.text() ?? '',
                ),
                KeyValueWidget(
                  title: S.current.tong_gia_tri,
                  value: detail.tongGiaTri.toPriceFormat(),
                ),
                KeyValueWidget(
                  title: S.current.loai_tai_san,
                  value: 'Chung cư',
                ),
                KeyValueWidget(
                  title: S.current.don_gia_qshch,
                  value: detail.donGia.toPriceFormat(),
                ),
                KeyValueWidget(
                  title: S.current.tang_so,
                  value: detail.floorNo?.toString() ?? '',
                ),
                KeyValueWidget(
                  title: S.current.thang_may,
                  value: detail.elevator == true ? 'Có' : 'Không',
                ),
                KeyValueWidget(
                  title: S.current.ham_de_xe,
                  value: detail.garage == true ? 'Có' : 'Không',
                ),
                KeyValueWidget(
                  title: S.current.ho_boi,
                  value: detail.pool == true ? 'Có' : 'Không',
                ),
                KeyValueWidget(
                  title: S.current.khu_thuong_mai,
                  value: detail.commercialServiceArea == true ? 'Có' : 'Không',
                ),
                KeyValueWidget(
                  title: S.current.cong_vien_noi_khu,
                  value: detail.innerPark == true ? 'Có' : 'Không',
                ),
                KeyValueWidget(
                  title: S.current.benh_vien,
                  value:
                      detail.hospitalSchoolPreschool == true ? 'Có' : 'Không',
                ),
                KeyValueWidget(
                  title: S.current.sanh_le_tan,
                  value: detail.receptionHall == true ? 'Có' : 'Không',
                ),
                KeyValueWidget(
                  title: S.current.nguon_thong_tin,
                  value: 'Được cung cấp từ Sacombank',
                ),
              ].insertBetween(
                const Divider(
                  height: 24,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            dinhViItemWidget(context, S.current.dinh_vi, () {
              ref.read(provider(ref).notifier).xemBanDo(context, ref);
            }),
            if ((state.detail.details ?? []).isNotEmpty)
              HookConsumer(
                builder: (context, ref, child) {
                  final isExpandList = useState([true, true, true]);
                  return ExpansionPanelList(
                    elevation: 0,
                    expandedHeaderPadding: EdgeInsets.zero,
                    expansionCallback: (index, expand) {
                      isExpandList.value[index] = expand;
                      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                      isExpandList.notifyListeners();
                    },
                    children: [
                      thongTinTaiSanSoSanh(
                        child,
                        isExpandList.value[0],
                      ),
                    ],
                  );
                },
                child: HookConsumer(
                  builder: (context, ref, child) {
                    final valuation = state.detail.details ?? [];
                    final tabIndex = useState(0);
                    final tabController =
                        useTabController(initialLength: valuation.length);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: kToolbarHeight,
                          child: TabBar(
                            controller: tabController,
                            isScrollable: true,
                            onTap: (index) {
                              tabIndex.value = index;
                            },
                            tabs: valuation
                                .mapIndexed(
                                  (index, e) => Tab(text: 'TSSS ${index + 1}'),
                                )
                                .toList(),
                          ),
                        ),
                        getTSSInfo(valuation[tabIndex.value], ref, state)
                      ],
                    );
                  },
                ),
              )
          ],
        ),
      ),
    );
  }

  ExpansionPanel thongTinTaiSanSoSanh(Widget? child, bool isExpand) {
    return ExpansionPanel(
      backgroundColor: Colors.transparent,
      isExpanded: isExpand,
      headerBuilder: (context, isExpand) {
        return Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    S.current.thong_tin_tsss,
                    style: context.textMediumBold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      body: child!,
    );
  }

  @override
  AutoDisposeStateNotifierProvider<KetQuaDinhGiaNhanhCHCCPageController,
      KetQuaDinhGiaNhanhCHCCState> provider(WidgetRef ref) {
    return KetQuaDinhGiaNhanhCHCCPageController.ketQuaDinhGiaPageController(
      ref.read(ketQuaDinhGiaNhanhCHCCItem),
    );
  }

  Widget getTSSInfo(CHCCFastValuationDetail item, WidgetRef ref,
      KetQuaDinhGiaNhanhCHCCState state) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          KeyValueWidget(
            title: S.current.ma_tai_san_kho_gia,
            value: item.assetCode,
          ),
          KeyValueWidget(
            title: S.current.nguon_du_lieu,
            value: item.dataSourceName,
          ),
          KeyValueWidget(
            title: S.current.nguon_thong_tin,
            value: item.infoSourceName,
          ),
          KeyValueWidget(
            title: S.current.nguoi_lienhe_sdt,
            value: item.contact,
          ),
          KeyValueWidget(
            title: S.current.tinh_trang_giao_dich,
            value: item.transactionStatus,
          ),
          KeyValueWidget(
            title: S.current.thoi_diem,
            value: item.dateCreate.toStringFormat(),
          ),
          KeyValueWidget(
            title: S.current.tinh_tp,
            value: item.provinces?.fullName,
          ),
          KeyValueWidget(
            title: S.current.tp_quan_huyen,
            value: item.districts?.fullName,
          ),
          KeyValueWidget(
            title: S.current.xa_phuong_thi_tran,
            value: item.wards?.fullName,
          ),
          KeyValueWidget(
            title: S.current.duong_pho,
            value: item.addressStreet,
          ),
          KeyValueWidget(
            title: S.current.chi_tiet,
            value: item.addressDetail,
          ),
          KeyValueWidget(
            title: S.current.vi_tri,
            value: item.positionName,
          ),
          KeyValueWidget(
            title: S.current.so_to,
            value: item.mapSheetNumber,
          ),
          KeyValueWidget(
            title: S.current.so_thua,
            value: item.landPlotNumber,
          ),
          KeyValueWidget(
            title: S.current.dinh_vi,
            value:
                '${item.coordinate?.latitude}, ${item.coordinate?.longitude}',
          ),
          KeyValueWidget(
            title: S.current.hinh_anh_tai_san,
            customValueWidget: Align(
              alignment: Alignment.centerRight,
              child: NetworkLoadImage(
                width: 56,
                height: 56,
                url: item.assetImage,
              ),
            ),
          ),
          KeyValueWidget(
            title: S.current.ten_cc_du_an,
            value: item.projectName,
          ),
          KeyValueWidget(
            title: S.current.toa_nha_thuc_te,
            value: item.building ?? item.buildingName,
          ),
          KeyValueWidget(
            title: S.current.block,
            value: item.blockName,
          ),
          KeyValueWidget(
            title: S.current.ma_can_ho,
            value: item.apartmentCode,
          ),
          KeyValueWidget(
            title: S.current.tang_so,
            value: item.floorNo.text(),
          ),
          KeyValueWidget(
            title: S.current.noi_that,
            value: item.furniture,
          ),
          KeyValueWidget(
            title: S.current.loi_the_kinh_doanh,
            value: item.businessAdvantage,
          ),
          KeyValueWidget(
            title: S.current.yeu_to_khac,
            value: item.otherFactor,
          ),
          KeyValueWidget(
            title: S.current.so_phong_ngu,
            value: item.bedrooms.text(),
          ),
          KeyValueWidget(
            title: S.current.so_mat_thoang,
            value: item.surfaces.text(),
          ),
          KeyValueWidget(
            title: S.current.so_phong_wc,
            value: item.toilets.text(),
          ),
          KeyValueWidget(
            title: S.current.so_tang_toa_nha,
            value: item.totalFloor.text(),
          ),
          KeyValueWidget(
            title: S.current.muc_dich_sd,
            value: item.usingPurposeName,
          ),
          KeyValueWidget(
            title: S.current.so_can_ho,
            value: item.numberApartment.text(),
          ),
          KeyValueWidget(
            title: S.current.so_phong_bep,
            value: item.kitchens.text(),
          ),
          KeyValueWidget(
            title: S.current.tien_ich,
            value: item.utilitiesName,
          ),
          KeyValueWidget(
            title: S.current.dien_tich_sd_rieng,
            value: item.privateUseArea.text(),
          ),
          KeyValueWidget(
            title: S.current.dien_tich_thong_thuy,
            value: item.clearanceArea.text(),
          ),
          KeyValueWidget(
            title: S.current.dien_tich_tim_tuong,
            value: item.buildupArea.text(),
          ),
          KeyValueWidget(
            title: S.current.dien_tich_coi_noi,
            value: (item.extendArea ?? 0).text(),
          ),
          KeyValueWidget(
            title: S.current.gia_thuong_luong,
            value: (item.transactionPrice ?? 0).toPriceFormat(),
          ),
          KeyValueWidget(
            title: S.current.gia_rao_ban,
            value: item.estimatePrice?.toPriceFormat(),
          ),
          KeyValueWidget(
            title: S.current.don_gia_uoc_tinh_qsh_can_ho,
            value: item.unitPrice.toPriceFormat(),
          ),
          KeyValueWidget(
            title: S.current.don_gia_sau_khi_da_tinh_he_so_dieu_chinh,
            value: item.optimizePrice?.toPriceFormat(),
          ),
          KeyValueWidget(
            title: S.current.gia_tri_tai_san_sau_khi_da_dieu_chinh_he_so,
            value: item.adjustPrice?.toPriceFormat(),
          ),
        ].insertBetween(
          const Divider(
            height: 24,
          ),
        ),
      ),
    );
  }

  @override
  List<Widget>? persistentFooterButtons(BuildContext context, WidgetRef ref) {
    return [
      Row(
        children: [
          CustomButton.primary(
            context,
            title: 'Nhập lại',
            onPressed: () {
              ref.read(provider(ref).notifier).editValuation(context);
            },
          ),
          const SizedBox(
            width: 16,
          ),
          if (ref.read(provider(ref)).detail.isNew == true) ...[
            CustomButton.primary(
              context,
              title: 'Lưu',
              onPressed: () {
                ref.read(provider(ref).notifier).save(context);
              },
            ),
            const SizedBox(
              width: 16,
            ),
          ],
          Expanded(
              child: CustomButton.save(
            title: 'Định giá TS khác',
            onPressed: () {
              ref.read(provider(ref).notifier).newFastValuation(context);
            },
          )),
        ],
      )
    ];
  }

  Widget dinhViItemWidget(
      BuildContext context, String title, void Function()? onTap) {
    return Container(
      margin: const EdgeInsets.only(
        left: 0,
        right: 0,
        bottom: 16,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).dividerColor,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Assets.images.icLocationMark.svg(),
        title: Text(title),
      ),
    );
  }

  Widget contentValueText(BuildContext context, String title, String? value,
      {String? prevValueText}) {
    return Container(
      margin: const EdgeInsets.only(
        left: 0,
        right: 0,
        bottom: 16,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).dividerColor,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        onTap: () {},
        leading: Assets.images.icLeadingBuilding.svg(),
        title: Text(
          title,
          style: context.textNormal,
        ),
        subtitle: Text('${prevValueText ?? ''}Giá trị: ${value ?? ''}'),
      ),
    );
  }
}
