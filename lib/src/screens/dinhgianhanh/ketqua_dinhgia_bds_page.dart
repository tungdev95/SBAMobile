import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sba/gen/assets.gen.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/fast_valuation_model.dart';
import 'package:sba/src/screens/base/base_page.dart';
import 'package:sba/src/screens/dinhgianhanh/controller/ketqua_dinhgia_bds_page_controller.dart';
import 'package:sba/src/screens/dinhgianhanh/state/ketqua_dinhgia_state.dart';
import 'package:sba/src/utils/base_flutter_extensions.dart';
import 'package:sba/src/widgets/buttons/stadium_button.dart';
import 'package:sba/src/widgets/keyvalule_widget.dart';
import 'package:sba/src/widgets/widget_network_image.dart';

final ketQuaDinhGiaNhanhItem = Provider.autoDispose<FastValuationModel>((ref) {
  throw UnimplementedError();
});

class KetQuaDinhGiaNhanhPage extends BasePage<KetQuaDinhGiaNhanhPageController,
    KetQuaDinhGiaNhanhState> {
  @override
  String get title => S.current.dinh_gia_nhanh_nha_pho;

  @override
  Color backgroundColor(BuildContext context) => Colors.white;

  const KetQuaDinhGiaNhanhPage({super.key});

  @override
  Widget bodyWidget(
      BuildContext context, WidgetRef ref, KetQuaDinhGiaNhanhState state) {
    final detail = state.detail;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Assets.images.icKetquaDinhgiaNhadat.image(fit: BoxFit.cover),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                KeyValueWidget(
                  title: S.current.vi_tri,
                  value: detail.address,
                ),
                KeyValueWidget(
                  title: S.current.tong_dien_tich,
                  value: detail.areaWidth.text(),
                ),
                KeyValueWidget(
                  title: S.current.don_gia_thi_truong,
                  value: detail.estimatePrice.toPriceFormat(),
                ),
                KeyValueWidget(
                  title: S.current.tong_gia_tri_dat,
                  value: detail.landPrice.toPriceFormat(),
                ),
                KeyValueWidget(
                  title: S.current.tong_gia_tri_tai_san,
                  value: detail.totalValue.toPriceFormat(),
                ),
                KeyValueWidget(
                  title: S.current.loai_tai_san,
                  value: S.current.nha_pho_dat_o,
                ),
                KeyValueWidget(
                  title: S.current.don_gia_dat_dieu_chinh,
                  value: (detail.optimizePrice ?? detail.estimatePrice)
                      .toPriceFormat(),
                ),
                KeyValueWidget(
                  title: S.current.khung_gia_stb,
                  value: detail.roadInPriceRange,
                ),
                KeyValueWidget(
                  title: S.current.tong_gia_tri_ctxd,
                  value: detail.getConstructionPrice.toPriceFormat(),
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
            dinhViItemWidget(context, S.current.quy_hoach, () {
              ref.read(provider(ref).notifier).xemQuyHoach(context, ref);
            }),
            if (state.detail.valuations.isNotEmpty)
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
                      chiTietKQDinhGiaNhanh(
                        context,
                        ref,
                        state,
                        isExpandList.value[0],
                      ),
                      chiTietBDS(
                        context,
                        ref,
                        state,
                        isExpandList.value[1],
                      ),
                      thongTinTaiSanSoSanh(
                        child,
                        isExpandList.value[2],
                      ),
                    ],
                  );
                },
                child: HookConsumer(
                  builder: (context, ref, child) {
                    final valuation = state.detail.valuations;
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
  AutoDisposeStateNotifierProvider<KetQuaDinhGiaNhanhPageController,
      KetQuaDinhGiaNhanhState> provider(WidgetRef ref) {
    return KetQuaDinhGiaNhanhPageController.ketQuaDinhGiaPageController(
      ref.read(ketQuaDinhGiaNhanhItem),
    );
  }

  Widget getTSSInfo(
      FastValuationModel item, WidgetRef ref, KetQuaDinhGiaNhanhState state) {
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
            title: S.current.dien_tich_khuon_vien,
            value: item.areaWidth.text(),
          ),
          KeyValueWidget(
            title: S.current.dien_tich_phu_hop_quy_hoach,
            value: item.areaInplan.text(),
          ),
          KeyValueWidget(
            title: S.current.dien_tich_khong_phu_hop_quy_hoach,
            value: item.areaUnplan.text(),
          ),
          KeyValueWidget(
            title: S.current.kich_thuoc_mat_tien,
            value: item.facadeLength.text(),
          ),
          KeyValueWidget(
            title: S.current.so_mat_tiep_giap,
            value: item.numberOfFacade.text(),
          ),
          KeyValueWidget(
            title: S.current.hinh_dang,
            value: item.shape,
          ),
          KeyValueWidget(
            title: S.current.do_rong_duong_hem_chinh_hem_phu,
            value: item.widthToMainRoad.text(),
          ),
          KeyValueWidget(
            title: S.current.khoang_canh_toi_truc_duong_chinh,
            value: item.distanceToMainRoad.text(),
          ),
          KeyValueWidget(
            title: S.current.loi_the_kinh_doanh,
            value: item.businessAdvantage,
          ),
          KeyValueWidget(
            title: S.current.muc_dich_sdung_dat,
            value: item.usingPurposeName,
          ),
          KeyValueWidget(
            title: S.current.yeu_to_khac,
            value: item.note,
          ),
          KeyValueWidget(
            title: S.current.gia_giao_dich,
            value: item.transactionPrice.toPriceFormat(),
          ),
          KeyValueWidget(
            title: S.current.gia_uoc_tinh,
            value: item.estimatePrice.toPriceFormat(),
          ),
          KeyValueWidget(
            title: S.current.tong_dtich_san_xd,
            value: item.totalFloorArea.text(),
          ),
          KeyValueWidget(
            title: S.current.don_gia,
            value: item.constructionUnitPrice.text(),
          ),
          KeyValueWidget(
            title: S.current.clcl,
            value: item.remainQuality.text(),
          ),
          KeyValueWidget(
            title: S.current.gia_tri_ctxd,
            value: item.constructionPrice.toPriceFormat(),
          ),
          KeyValueWidget(
            title: S.current.don_gia_dat_m2,
            value: item.landUnitPrice.toPriceFormat(),
          ),
          KeyValueWidget(
            title: S.current.don_gia_phu_hop_quy_hoach,
            value: item.landPrice.toPriceFormat(),
          ),
          KeyValueWidget(
            title: S.current.don_gia_dat_dieu_chinh,
            value: item.optimizePrice.toPriceFormat(),
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

  ExpansionPanel chiTietKQDinhGiaNhanh(BuildContext context, WidgetRef ref,
      KetQuaDinhGiaNhanhState state, bool value) {
    return ExpansionPanel(
      backgroundColor: Colors.transparent,
      isExpanded: value,
      headerBuilder: (context, isExpand) {
        return Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    S.current.chi_tiet_kq_dinh_gia_nhanh,
                    style: context.textMediumBold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          contentValueText(
            context,
            S.current.dat_cong_nhan_phu_hop_quy_hoach,
            state.detail.giaTriDatCongNhanPhuHopQuyHoach,
            prevValueText:
                '${S.current.dien_tich}: ${state.detail.areaInplan.text()} m2\n${S.current.don_gia}: ${state.detail.estimatePrice?.toPriceFormat(true) ?? ''}\n',
          ),
          contentValueText(
            context,
            S.current.dat_cong_nhan_khong_phu_hop_quy_hoach,
            state.detail.giaTriDatKhongCongNhanPhuHopQuyHoach,
            prevValueText:
                '${S.current.dien_tich}: ${state.detail.areaUnplan.text()} m2\n${S.current.don_gia}: ${state.detail.unPlanPrice?.toPriceFormat(true) ?? ''}\n',
          ),
        ],
      ),
    );
  }

  ExpansionPanel chiTietBDS(BuildContext context, WidgetRef ref,
      KetQuaDinhGiaNhanhState state, bool value) {
    return ExpansionPanel(
      backgroundColor: Colors.transparent,
      isExpanded: value,
      headerBuilder: (context, isExpand) {
        return Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    S.current.cong_trinh_xd,
                    style: context.textMediumBold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        ...state.detail.constructions.map<Widget>((e) {
          return contentValueText(
            context,
            '${e.type ?? ''}/${e.name ?? ''} (CLCL: ${e.clcl.text()}%)',
            ((e.clcl ?? 0.0) / 100 * (e.area ?? 0.0) * (e.unitPrice ?? 0.0))
                .toPriceFormat(),
            prevValueText:
                '${S.current.dien_tich}: ${e.area.text()} m2\n${S.current.don_gia}: ${e.unitPrice?.toPriceFormat(true) ?? ''}\n',
          );
        }).toList(),
        Row(
          children: [
            Text(S.current.tong_gia_tri_ctxd),
            Expanded(
              child: Text(
                state.detail.getConstructionPrice.toPriceFormat(),
                textAlign: TextAlign.right,
                style: context.textNormalBold,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Text(S.current.tong_gia_tri_tai_san),
            Expanded(
              child: Text(
                state.detail.totalValue.toPriceFormat(),
                textAlign: TextAlign.right,
                style: context.textNormalBold,
              ),
            )
          ],
        )
      ]),
    );
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
