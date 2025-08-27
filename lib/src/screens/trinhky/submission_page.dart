import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sba/gen/assets.gen.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/screens/base/base_page.dart';
import 'package:sba/src/screens/trinhky/controller/submission_controller.dart';
import 'package:sba/src/screens/other/states/pdf_view_state.dart';
import 'package:sba/src/screens/trinhky/widgets/ket_qua_chi_tiet_expand_widget.dart';
import 'package:sba/src/utils/utils.dart';
import 'package:sba/src/widgets/attachment/attachment_download_widget.dart';
import 'package:sba/src/widgets/buttons/stadium_button.dart';
import 'package:sba/src/widgets/custom_input_widget.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

final subMissionDetail = Provider<AssetsModel>((ref) {
  throw UnimplementedError();
});

class SubmissionPage extends BasePage<SubmissionPageController, PdfViewState> {
  final bool isSend;
  const SubmissionPage({super.key, this.isSend = false});

  @override
  String get title => S.current.thong_tin_to_trinh;

  @override
  Widget bodyWidget(BuildContext context, WidgetRef ref, PdfViewState state) {
    if (isSend) {
      return pdfViewChoDuyet(context, ref, state);
    }
    final isExpandList = useState([true, true, true]);
    final giaTriCTXDHinhThanhTrongTuongLai =
        state.submissionDetail?.tableTong?.constructionFutureValueApprovaled ??
            0;
    final assetType = state.assetsModel?.assetType;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          pdfViewContent(context, ref, state),
          CustomInputWidget(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            contentPadding: const EdgeInsets.all(16),
            inputFieldModel: InputFieldModel<String>(
              label: S.current.y_kien_duyet,
              hint: S.current.nhap_y_kien,
              data: state.yKien,
              minLines: 4,
              maxLines: 4,
              inputType: TextInputType.multiline,
              inputAction: TextInputAction.newline,
              required: true,
              autoValidateMode: AutovalidateMode.always,
              onTextChanged: (newValue) => state.yKien = newValue,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () {
                  ref.read(provider(ref).notifier).lichSuToTrinh(context);
                },
                icon: const Icon(Icons.history),
                label: Text(
                  S.current.lich_su_phe_duyet_to_trinh,
                ),
              ),
            ),
          ),
          KetQuaChiTietExpandWidget(
            assetType: assetType,
            submissionDetail: state.submissionDetail,
            chiTietDat: (context, e) {
              ref.read(provider(ref).notifier).chiTietInfo(context, e);
            },
            chiTietCTXD: (context, e) {
              ref.read(provider(ref).notifier).chiTietCTXD(context, e);
            },
            chiTietMMTB: (context, e) {
              ref.read(provider(ref).notifier).chiTietMMTB(context, e);
            },
            reloadCount: () {
              ref.read(provider(ref).notifier).reloadUI();
            },
          ),
          if (assetType == AssetsTypeEnum.ptdb ||
              assetType == AssetsTypeEnum.ptdt)
            tongGiaTriTaiSan(
              context,
              state.submissionDetail
                  ?.tongGiaTriTaiSanDBDT(state.submissionInfo?.level ?? 0),
            ),
          if (assetType == AssetsTypeEnum.bds)
            tongGiaTriTaiSan(
              context,
              state.submissionDetail
                  ?.tongGiaTriTaiSanBDS(state.submissionInfo?.level ?? 0),
            ),
          if (assetType == AssetsTypeEnum.duToan)
            tongGiaTriTaiSan(
              context,
              state.submissionDetail
                  ?.tongGiaTriTaiSanDuToan(state.submissionInfo?.level ?? 0),
            ),
          if (assetType == AssetsTypeEnum.chcc)
            tongGiaTriTaiSan(
              context,
              state.submissionDetail
                  ?.tongGiaTriTaiSanCHCC(state.submissionInfo?.level ?? 0),
            ),
          if (assetType == AssetsTypeEnum.mmtb)
            tongGiaTriTaiSan(
              context,
              state.submissionDetail
                  ?.tongGiaTriTaiSanMMTB(state.submissionInfo?.level ?? 0),
            ),
          if (assetType == AssetsTypeEnum.duAn)
            tongGiaTriTaiSan(
              context,
              state.submissionDetail
                  ?.tongGiaTriTaiSanDuAn(state.submissionInfo?.level ?? 0),
            )
        ],
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

  Widget tongGiaTriTaiSan(BuildContext context, int? total) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            '${S.current.tong_gia_tri_tai_san}: ',
            style: context.textMediumBold,
          ),
          Expanded(
            child: Text(
              total?.toPriceFormat() ?? '',
              style: context.textMediumBold
                  .copyWith(color: const Color(0xFF007CB9)),
            ),
          ),
        ],
      ),
    );
  }

  Widget pdfViewContent(
      BuildContext context, WidgetRef ref, PdfViewState state) {
    return Container(
      color: Colors.black,
      height: context.screenSize.height * .5,
      margin: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  S.current.thong_tin_to_trinh,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              if (state.data != null) ...[
                AttachmentDownloadWidget(attachment: state.data!),
                IconButton(
                  onPressed: () {
                    ref.read(provider(ref).notifier).fullScreenPdf(context);
                  },
                  icon: const Icon(
                    Icons.fullscreen,
                    color: Colors.white,
                  ),
                )
              ]
            ],
          ),
          Expanded(
            child: state.data != null
                ? SfPdfViewer.memory(
                    state.data!.bytes!,
                    onDocumentLoadFailed: (details) async {},
                  )
                : const SizedBox.shrink(),
          )
        ],
      ),
    );
  }

  Widget pdfViewChoDuyet(
      BuildContext context, WidgetRef ref, PdfViewState state) {
    return state.data != null
        ? SfPdfViewer.memory(
            state.data!.bytes!,
            onDocumentLoadFailed: (details) async {},
          )
        : const SizedBox.shrink();
  }

  @override
  AutoDisposeStateNotifierProvider<SubmissionPageController, PdfViewState>
      provider(WidgetRef ref) {
    return SubmissionPageController.pdfControllerProvider(
        ref.read(subMissionDetail));
  }

  @override
  List<Widget>? persistentFooterButtons(BuildContext context, WidgetRef ref) {
    final state = ref.watch(provider(ref));
    if (state.submissionInfo == null) return [];
    final level = state.submissionInfo?.level ?? -1;
    final totalLevel = state.submissionInfo?.totalLevel ?? -1;
    final isKySo = level != -1 && totalLevel != -1 && level == totalLevel;
    final coQuyenDuyet = state.coQuyenDuyet ?? false;
    final coQuyenKySo = state.coQuyenKySo ?? false;
    return [
      Row(
        children: [
          if (isKySo && coQuyenKySo)
            Expanded(
              child: CustomButton.primary(
                context,
                title: S.current.ky_so,
                onPressed: () {
                  ref.read(provider(ref).notifier).kySo(context);
                },
              ),
            ),
          if (level > -1 && !isKySo && coQuyenDuyet) ...[
            Expanded(
              child: CustomButton.danger(
                context,
                title: S.current.tu_choi,
                onPressed: () {
                  ref.read(provider(ref).notifier).tuChoi(context);
                },
              ),
            ),
            const SizedBox(
              width: 16,
            )
          ],
          if (!isKySo && coQuyenDuyet)
            Expanded(
              child: CustomButton.primary(
                context,
                title: level < 0
                    ? S.current.gui_duyet
                    : S.current.duyet_cap(level + 1),
                onPressed: () {
                  ref.read(provider(ref).notifier).guiDuyetToTrinh(context);
                },
              ),
            )
          else
            Expanded(
              child: CustomButton(
                title: S.current.thoat,
                onPressed: () {
                  Navigator.maybePop(context);
                },
              ),
            ),
        ],
      ),
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

  Widget detailItemWidget(
    BuildContext context,
    WidgetRef ref,
    String title,
    String subTitle,
    Function() onTap,
  ) {
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
        leading: Assets.images.icLeadingBuilding.svg(),
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
