import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sba/gen/assets.gen.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/submission_detail_model.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/utils/utils.dart';
import 'package:sba/src/widgets/custom_input_widget.dart';
import 'package:sba/src/widgets/keyvalule_widget.dart';

class KetQuaChiTietExpandWidget extends HookConsumerWidget {
  final SubmissionDetailModel? submissionDetail;
  final AssetsTypeEnum? assetType;
  final Function(BuildContext, KQDatModel)? chiTietDat;
  final Function(BuildContext, KQCTXDModel)? chiTietCTXD;
  final Function(BuildContext, KQDatModel)? chiTietMMTB;
  final bool allowEdit;
  final Function() reloadCount;

  const KetQuaChiTietExpandWidget({
    super.key,
    this.submissionDetail,
    this.assetType,
    this.chiTietDat,
    this.chiTietCTXD,
    this.chiTietMMTB,
    this.allowEdit = true,
    required this.reloadCount,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpandList = useState([true, true, true]);

    return ExpansionPanelList(
      expandedHeaderPadding: EdgeInsets.zero,
      expansionCallback: (panelIndex, isExpanded) {
        final datas = isExpandList.value;
        datas[panelIndex] = !datas[panelIndex];
        isExpandList.value = datas;
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        isExpandList.notifyListeners();
      },
      children: [
        if (assetType == AssetsTypeEnum.bds ||
            assetType == AssetsTypeEnum.duAn ||
            assetType == AssetsTypeEnum.duToan)
          ...constructionDetail(
              context, ref, submissionDetail?.tableKQDat ?? [], isExpandList),
        if (assetType == AssetsTypeEnum.chcc)
          ...constructionDetailCHCC(context, ref, isExpandList),
        if (assetType == AssetsTypeEnum.ptdb ||
            assetType == AssetsTypeEnum.ptdt)
          ...ptdbPtdtDetail(
              context, ref, submissionDetail?.tableKQDat ?? [], isExpandList),
        if (assetType == AssetsTypeEnum.mmtb)
          ...mmtbDetail(
              context, ref, submissionDetail?.tableKQDat ?? [], isExpandList)
      ],
    );
  }

  List<ExpansionPanel> constructionDetail(
    BuildContext context,
    WidgetRef ref,
    List<KQDatModel> tableKQDat,
    ValueNotifier<List<bool>> isExpandList,
  ) {
    final giaTriCTXDHinhThanhTrongTuongLai =
        submissionDetail?.tableTong?.constructionFutureValueApprovaled ?? 0;
    return [
      ExpansionPanel(
        canTapOnHeader: true,
        isExpanded: isExpandList.value[0],
        headerBuilder: (context, isExpanded) {
          return getTitleWidget(
            context,
            S.current.ket_qua_chi_tiet_gia_dat,
          );
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: (submissionDetail?.tableKQDat ?? [])
              .map(
                (e) => detailItemWidget(
                  context,
                  ref,
                  e.name ?? '',
                  e.typeString,
                  () {
                    chiTietDat?.call(context, e);
                  },
                ),
              )
              .toList(),
        ),
      ),
      ExpansionPanel(
        canTapOnHeader: true,
        isExpanded: isExpandList.value[1],
        headerBuilder: (context, isExpanded) => getTitleWidget(
          context,
          S.current.ket_qua_chi_tiet_gia_ctxd,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: (submissionDetail?.tableKQCTXD ?? [])
              .map(
                (e) => detailItemWidget(
                  context,
                  ref,
                  e.constructionName?.constructionName ?? '',
                  e.constructionType?.constructionTypeName ?? '',
                  () {
                    chiTietCTXD?.call(context, e);
                  },
                ),
              )
              .toList(),
        ),
      ),
      if (giaTriCTXDHinhThanhTrongTuongLai > 0)
        ExpansionPanel(
          canTapOnHeader: true,
          isExpanded: isExpandList.value[2],
          headerBuilder: (context, isExpanded) => getTitleWidget(
            context,
            S.current.ket_qua_chi_tiet_gia_ctxd_hinh_thanh,
          ),
          body: allowEdit
              ? CustomInputWidget(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  key: const ValueKey('CTXD'),
                  inputFieldModel: InputFieldModel<int>(
                    label: S.current.tong_gia_tri_ctxd_tuong_lai_tham_khao,
                    data: giaTriCTXDHinhThanhTrongTuongLai,
                    isCurrency: true,
                    inputAction: TextInputAction.done,
                    onTextChanged: (value) => submissionDetail
                        ?.tableTong?.constructionFutureValueApprovaled = value,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: KeyValueWidget(
                    title: S.current.tong_gia_tri_ctxd_tuong_lai_tham_khao,
                    customValueWidget: Text(
                      giaTriCTXDHinhThanhTrongTuongLai.toPriceFormat(),
                      textAlign: TextAlign.end,
                      style: context.textMediumBold,
                    ),
                  ),
                ),
        ),
    ];
  }

  List<ExpansionPanel> constructionDetailCHCC(
    BuildContext context,
    WidgetRef ref,
    ValueNotifier<List<bool>> isExpandList,
  ) {
    final giaTriCTXDHinhThanhTrongTuongLai =
        submissionDetail?.tableTong?.constructionFutureValueApprovaled ?? 0;
    return [
      ExpansionPanel(
        canTapOnHeader: true,
        isExpanded: isExpandList.value[0],
        headerBuilder: (context, isExpanded) {
          return getTitleWidget(
            context,
            S.current.ket_qua_chi_tiet_gia_dat,
          );
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: (submissionDetail?.tableKQ ?? [])
              .map(
                (e) => detailItemWidget(
                  context,
                  ref,
                  e.name ?? '',
                  e.typeString,
                  () {
                    chiTietDat?.call(context, e);
                  },
                ),
              )
              .toList(),
        ),
      ),
      if (submissionDetail?.tableKQDat.isNotEmpty == true)
        ExpansionPanel(
          canTapOnHeader: true,
          isExpanded: isExpandList.value[1],
          headerBuilder: (context, isExpanded) =>
              getTitleWidget(context, S.current.ket_qua_chi_tiet_gia_ctxd),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: (submissionDetail?.tableKQDat ?? [])
                .map(
                  (e) => detailItemWidget(
                    context,
                    ref,
                    e.name ?? '',
                    e.typeString,
                    () {
                      chiTietDat?.call(context, e);
                    },
                  ),
                )
                .toList(),
          ),
        ),
      if (giaTriCTXDHinhThanhTrongTuongLai > 0)
        ExpansionPanel(
          canTapOnHeader: true,
          isExpanded: isExpandList.value[2],
          headerBuilder: (context, isExpanded) => getTitleWidget(
            context,
            S.current.ket_qua_chi_tiet_gia_ctxd_hinh_thanh,
          ),
          body: allowEdit
              ? CustomInputWidget(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  key: const ValueKey('CTXD'),
                  inputFieldModel: InputFieldModel<int>(
                    label: S.current.tong_gia_tri_ctxd_tuong_lai_tham_khao,
                    data: giaTriCTXDHinhThanhTrongTuongLai,
                    isCurrency: true,
                    inputAction: TextInputAction.done,
                    onTextChanged: (value) {
                      submissionDetail?.tableTong
                          ?.constructionFutureValueApprovaled = value;
                      reloadCount();
                    },
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: KeyValueWidget(
                    title: S.current.tong_gia_tri_ctxd_tuong_lai_tham_khao,
                    customValueWidget: Text(
                      giaTriCTXDHinhThanhTrongTuongLai.toPriceFormat(),
                      textAlign: TextAlign.end,
                      style: context.textMediumBold,
                    ),
                  ),
                ),
        ),
    ];
  }

  List<ExpansionPanel> ptdbPtdtDetail(
    BuildContext context,
    WidgetRef ref,
    List<KQDatModel> tableKQDat,
    ValueNotifier<List<bool>> isExpandList,
  ) {
    return [
      ExpansionPanel(
        canTapOnHeader: true,
        isExpanded: isExpandList.value[0],
        headerBuilder: (context, isExpanded) {
          return getTitleWidget(
            context,
            ketQuaChiTietLabel(assetType),
          );
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: (submissionDetail?.tableKQDat ?? [])
              .map(
                (e) => detailItemWidget(
                  context,
                  ref,
                  e.name ?? '',
                  e.typeString,
                  () {
                    chiTietDat?.call(context, e);
                  },
                  icon: assetType == AssetsTypeEnum.ptdb
                      ? Assets.images.home.icPtdb.svg(
                          colorFilter: const ColorFilter.mode(
                            Colors.black,
                            BlendMode.srcIn,
                          ),
                        )
                      : Assets.images.home.icPtdt.svg(
                          colorFilter: const ColorFilter.mode(
                            Colors.black,
                            BlendMode.srcIn,
                          ),
                        ),
                ),
              )
              .toList(),
        ),
      )
    ];
  }

  List<ExpansionPanel> mmtbDetail(
    BuildContext context,
    WidgetRef ref,
    List<KQDatModel> tableKQDat,
    ValueNotifier<List<bool>> isExpandList,
  ) {
    return [
      ExpansionPanel(
        canTapOnHeader: true,
        isExpanded: isExpandList.value[0],
        headerBuilder: (context, isExpanded) {
          return getTitleWidget(
            context,
            S.current.ket_qua_chi_tiet,
          );
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: (submissionDetail?.tableKQ ?? [])
              .map(
                (e) => detailItemWidget(
                  context,
                  ref,
                  e.name ?? '',
                  '',
                  () {
                    chiTietMMTB?.call(context, e);
                  },
                  icon: Assets.images.home.icMmtb.svg(
                      colorFilter: const ColorFilter.mode(
                    Colors.black,
                    BlendMode.srcIn,
                  )),
                ),
              )
              .toList(),
        ),
      )
    ];
  }

  Widget getTitleWidget(
    BuildContext context,
    String title, {
    bool boldTitle = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: boldTitle ? context.textMediumBold : context.textMedium,
        ),
      ),
    );
  }

  String ketQuaChiTietLabel(AssetsTypeEnum? assetType) {
    if (assetType != AssetsTypeEnum.ptdb && assetType != AssetsTypeEnum.ptdt) {
      return S.current.ket_qua_chi_tiet_gia_ctxd;
    } else {
      return S.current.ket_qua_chi_tiet;
    }
  }

  Widget detailItemWidget(BuildContext context, WidgetRef ref, String title,
      String subTitle, Function() onTap,
      {Widget? icon}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
      ),
      margin: const EdgeInsets.all(8),
      child: ListTile(
        onTap: onTap,
        leading: icon ?? Assets.images.icLeadingBuilding.svg(),
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          subTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
