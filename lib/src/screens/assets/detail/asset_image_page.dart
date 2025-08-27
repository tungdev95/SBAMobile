import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sba/gen/assets.gen.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/models/assets/enum.dart';
import 'package:sba/src/screens/assets/assets.dart';
import 'package:sba/src/screens/base/base_page.dart';
import 'package:sba/src/utils/utils.dart';
import 'package:sba/src/widgets/attachment/appendix_attachment_widget.dart';
import 'package:sba/src/widgets/attachment/image_attachment.dart';

class AssetImagePage<T extends BaseDetailModel,
        C extends BaseAssetDetailPageController<T>>
    extends BasePage<C, AssetsDetailState<T>> {
  final AutoDisposeStateNotifierProvider<C, AssetsDetailState<T>> pageProvider;
  const AssetImagePage(this.pageProvider, {Key? key}) : super(key: key);

  @override
  bool get enableLoading => false;

  @override
  Widget bodyWidget(
      BuildContext context, WidgetRef ref, AssetsDetailState<T> state) {
    final expandState = useState({});
    final expandValue = expandState.value;
    int index = 0;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _InfoRow(
            text: S.current.ma_de_nghi,
            value: state.element.assetsModel?.proposalCode ?? '',
          ),
          const Divider(
            height: 0,
          ),
          _InfoRow(
            text: S.current.so_to_trinh,
            value: state.element.assetsModel?.reportCode ?? '',
          ),
          const Divider(
            height: 0,
          ),
          _InfoRow(
            text: S.current.tg_gui_yeu_cau,
            value: state.element.assetsModel?.proposalDate
                    ?.toLocal()
                    .toStringFormat(showInfoDateFormat) ??
                '',
          ),
          const SizedBox(
            height: 8,
          ),
          ExpansionPanelList(
            expandedHeaderPadding: EdgeInsets.zero,
            expansionCallback: (panelIndex, isExpanded) {
              // expandState.value.update(key, (value) => false)
              expandValue[panelIndex] = isExpanded;
              expandState.value = expandValue;
              // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
              expandState.notifyListeners();
            },
            elevation: 0,
            children: [
              uploadHinhAnhExpansionPanel(context, ref, expandValue[index++]),
              if (ref.read(provider(ref).notifier).enableZoningImage)
                anhSoDoExpansionPanel(context, ref, expandValue[index++]),
              phuLucTaiSan(context, ref, expandValue[index++]),
              dinhVi(context, ref, expandValue[index++]),
              if (ref.read(provider(ref).notifier).enableUploadDinhVi)
                uploadDinhVi(context, ref, expandValue[index++]),
              if (ref.read(provider(ref).notifier).enableZoningImage)
                thongTinQuyHoach(context, ref, expandValue[index++]),
            ],
          )
        ],
      ),
    );
  }

  ///Upload hình ảnh
  ExpansionPanel uploadHinhAnhExpansionPanel(
    BuildContext context,
    WidgetRef ref,
    bool? isExpand,
  ) {
    final lsImage =
        ref.watch(provider(ref).select((value) => value.assetInfoImage));
    final size = lsImage.length + 1;
    return ExpansionPanel(
      isExpanded: isExpand ?? false,
      canTapOnHeader: true,
      headerBuilder: (context, isExpand) {
        return getTitleWidget(context, S.current.upload_hinh_anh);
      },
      body: SizedBox(
        height: 100,
        child: ListView.separated(
          itemCount: size,
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => const SizedBox(
            width: 8,
          ),
          itemBuilder: (context, index) {
            if (index == size - 1) {
              return GestureDetector(
                onTap: () {
                  ref.read(provider(ref).notifier).addNewImagePressed(context);
                },
                child: AspectRatio(
                  aspectRatio: 1,
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(8),
                    child: const Center(
                      child: Text(
                        '+',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                ),
              );
            }
            final item = lsImage[index];
            return ImageAttachment(
              asset: 'asset',
              attachment: item,
              allImages: lsImage,
              constraints: const BoxConstraints.expand(width: 100, height: 100),
              borderRadius: BorderRadius.circular(8),
              cancelUpload: (attachmentId) {
                ref.read(provider(ref).notifier).cancelAttachmentUpload(item);
              },
              retryUpload: (attachmentId) {
                ref.read(provider(ref).notifier).retryAttachmentUpload(
                      attachmentId,
                    );
              },
            );
          },
        ),
      ),
    );
  }

  ///Ảnh sơ đồ
  ExpansionPanel anhSoDoExpansionPanel(
      BuildContext context, WidgetRef ref, bool? isExpand) {
    final lsImage =
        ref.watch(provider(ref).select((value) => value.diagramImages));
    final size = lsImage.length + 1;
    return ExpansionPanel(
      canTapOnHeader: true,
      isExpanded: isExpand ?? false,
      headerBuilder: (context, isExpand) {
        return getTitleWidget(context, S.current.anh_so_do);
      },
      body: SizedBox(
        height: 100,
        child: ListView.separated(
          itemCount: size,
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => const SizedBox(
            width: 8,
          ),
          itemBuilder: (context, index) {
            if (index == size - 1) {
              return GestureDetector(
                onTap: () {
                  ref
                      .read(provider(ref).notifier)
                      .addNewDiagramPressed(context);
                },
                child: AspectRatio(
                  aspectRatio: 1,
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(8),
                    child: const Center(
                      child: Text(
                        '+',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                ),
              );
            }
            final item = lsImage[index];
            return ImageAttachment(
              asset: 'asset',
              attachment: item,
              constraints: const BoxConstraints.expand(width: 100, height: 100),
              borderRadius: BorderRadius.circular(8),
              cancelUpload: (attachmentId) {
                ref.read(provider(ref).notifier).cancelAttachmentUpload(item);
              },
              retryUpload: (attachmentId) {
                ref.read(provider(ref).notifier).retryAttachmentUpload(
                    attachmentId,
                    type: ImageType.diagram);
              },
            );
          },
        ),
      ),
    );
  }

  ///Phụ lục tài sản
  ExpansionPanel phuLucTaiSan(
    BuildContext context,
    WidgetRef ref,
    bool? isExpand,
  ) {
    final lsImage =
        ref.watch(provider(ref).select((value) => value.otherImages));
    final size = lsImage.length + 1;
    return ExpansionPanel(
      isExpanded: isExpand ?? false,
      canTapOnHeader: true,
      headerBuilder: (context, isExpand) {
        return getTitleWidget(context, S.current.hinh_anh_phu_luc);
      },
      body: ListView.separated(
        itemCount: size,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
        separatorBuilder: (context, index) => const SizedBox(
          height: 8,
        ),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (index == size - 1) {
            return TextButton.icon(
              onPressed: () {
                ref.read(provider(ref).notifier).addPhuLucHinhAnh(context);
              },
              icon: const Icon(Icons.add_circle_sharp),
              label: Text(S.current.them_hinh_anh),
              style: ButtonStyle(
                padding: MaterialStateProperty.resolveWith(
                  (states) => EdgeInsets.zero,
                ),
              ),
            );
          }
          final item = lsImage[index];
          return AppendixAttachmentWidget(
            attachment: item,
            cancelUpload: (attachmentId) {
              ref.read(provider(ref).notifier).cancelAttachmentUpload(item);
            },
            retryUpload: (attachmentId) {
              ref.read(provider(ref).notifier).retryAttachmentUpload(
                    attachmentId,
                    type: ImageType.appendix,
                  );
            },
            onTextChange: (String newText) {
              item.description = newText;
            },
          );
        },
      ),
    );
  }

  ///Ảnh định vị
  ExpansionPanel dinhVi(
    BuildContext context,
    WidgetRef ref,
    bool? isExpand,
  ) {
    return ExpansionPanel(
      isExpanded: isExpand ?? false,
      canTapOnHeader: true,
      headerBuilder: (context, isExpand) {
        return getTitleWidget(context, S.current.dinh_vi);
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 16,
              right: 16,
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
              onTap: () {
                ref.read(provider(ref).notifier).goToMapPage(context);
              },
              leading: Assets.images.icLocationMark.svg(),
              title: Text(S.current.dinh_vi),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (ref.watch(provider(ref)).locationImages.isNotEmpty)
                    IconButton(
                      onPressed: () {
                        showImageViewerPage(context,
                            lsImage: ref.read(provider(ref)).locationImages);
                      },
                      icon: const Icon(Icons.image),
                    ),
                  IconButton(
                    onPressed: () {
                      ref.read(provider(ref).notifier).goToMapPage(context);
                    },
                    icon: const Icon(
                      Icons.location_on_rounded,
                    ),
                  )
                ],
              ),
            ),
          ),
          TextButton.icon(
            onPressed: () {
              ref.read(provider(ref).notifier).themAnhDinhVi(context);
            },
            icon: const Icon(Icons.add_circle_sharp),
            label: Text(S.current.them_hinh_anh),
            style: ButtonStyle(
              padding: MaterialStateProperty.resolveWith(
                (states) => EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///Ảnh thông tin quy hoạch
  ExpansionPanel thongTinQuyHoach(
    BuildContext context,
    WidgetRef ref,
    bool? isExpand,
  ) {
    final lsImage =
        ref.watch(provider(ref).select((value) => value.zoningImages));
    final size = lsImage.length + 1;
    return ExpansionPanel(
      canTapOnHeader: true,
      isExpanded: isExpand ?? false,
      headerBuilder: (context, isExpand) {
        return getTitleWidget(context, S.current.thong_tin_quy_hoach);
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 16,
              right: 16,
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
              onTap: () {
                ref.read(provider(ref).notifier).goToZoningPage(context);
              },
              leading: Assets.images.icLocationMark.svg(),
              title: Text(S.current.thong_tin_quy_hoach),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      ref.read(provider(ref).notifier).goToZoningPage(context);
                    },
                    icon: const Icon(
                      Icons.location_city,
                    ),
                  )
                ],
              ),
            ),
          ),
          // TextButton.icon(
          //   onPressed: () {
          //     ref.read(provider(ref).notifier).themAnhQuyHoach(context);
          //   },
          //   icon: const Icon(Icons.add_circle_sharp),
          //   label: Text(S.current.them_hinh_anh),
          //   style: ButtonStyle(
          //     padding: MaterialStateProperty.resolveWith(
          //       (states) => EdgeInsets.zero,
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 100,
            child: ListView.separated(
              itemCount: size,
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(
                width: 8,
              ),
              itemBuilder: (context, index) {
                if (index == size - 1) {
                  return GestureDetector(
                    onTap: () {
                      ref.read(provider(ref).notifier).themAnhQuyHoach(context);
                    },
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(8),
                        child: const Center(
                          child: Text(
                            '+',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                final item = lsImage[index];
                return ImageAttachment(
                  asset: 'asset',
                  attachment: item,
                  allImages: lsImage,
                  constraints:
                      const BoxConstraints.expand(width: 100, height: 100),
                  borderRadius: BorderRadius.circular(8),
                  cancelUpload: (attachmentId) {
                    ref
                        .read(provider(ref).notifier)
                        .cancelAttachmentUpload(item);
                  },
                  retryUpload: (attachmentId) {
                    ref.read(provider(ref).notifier).retryAttachmentUpload(
                          attachmentId,
                          type: ImageType.zoning,
                        );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

  /// Ảnh upload định vị (MMTB)
  ExpansionPanel uploadDinhVi(
    BuildContext context,
    WidgetRef ref,
    bool? isExpand,
  ) {
    final lsImage = ref.watch(provider(ref).select((value) => value.anhDinhVi));
    final size = lsImage.length + 1;
    return ExpansionPanel(
      canTapOnHeader: true,
      isExpanded: isExpand ?? false,
      headerBuilder: (context, isExpand) {
        return getTitleWidget(context, S.current.upload_dinh_vi);
      },
      body: ListView.separated(
        itemCount: size,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
        separatorBuilder: (context, index) => const SizedBox(
          height: 8,
        ),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (index == size - 1) {
            return TextButton.icon(
              onPressed: () {
                ref.read(provider(ref).notifier).addUploadDinhVi(context);
              },
              icon: const Icon(Icons.add_circle_sharp),
              label: Text(S.current.them_hinh_anh),
              style: ButtonStyle(
                padding: MaterialStateProperty.resolveWith(
                  (states) => EdgeInsets.zero,
                ),
              ),
            );
          }
          final item = lsImage[index];
          return AppendixAttachmentWidget(
            attachment: item,
            cancelUpload: (attachmentId) {
              ref.read(provider(ref).notifier).cancelAttachmentUpload(item);
            },
            retryUpload: (attachmentId) {
              ref.read(provider(ref).notifier).retryAttachmentUpload(
                    attachmentId,
                    type: ImageType.dinhVi,
                  );
            },
            onTextChange: (String newText) {
              item.description = newText;
            },
          );
        },
      ),
    );
  }

  @override
  AutoDisposeStateNotifierProvider<C, AssetsDetailState<T>> provider(
          WidgetRef ref) =>
      pageProvider;

  Widget getTitleWidget(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: context.textMediumBold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: unused_element
class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.text,
    required this.value,
  });

  final String text;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text),
          Text(value),
        ],
      ),
    );
  }
}
