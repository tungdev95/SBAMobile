import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/screens/base/base_page.dart';
import 'package:sba/src/screens/other/controller/pdf_viewer_controller.dart';
import 'package:sba/src/screens/other/states/pdf_view_state.dart';
import 'package:sba/src/widgets/attachment/attachment_download_widget.dart';
import 'package:sba/src/widgets/buttons/stadium_button.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

final pdfViewProvider =
    Provider<({AssetsModel? assetsModel, AttachmentFile? file})>((ref) {
  throw UnimplementedError();
});

class PdfViewerPage extends BasePage<PdfViewerPageController, PdfViewState> {
  const PdfViewerPage({super.key, this.pageTitle});

  final String? pageTitle;

  @override
  String get title => pageTitle ?? S.current.bien_ban_khao_sat;

  @override
  Widget bodyWidget(BuildContext context, WidgetRef ref, PdfViewState state) {
    if (state.data?.bytes != null) {
      return SfPdfViewer.memory(state.data!.bytes!);
    }
    return const SizedBox.shrink();
  }

  @override
  AutoDisposeStateNotifierProvider<PdfViewerPageController, PdfViewState>
      provider(WidgetRef ref) {
    return PdfViewerPageController.pdfControllerProvider(
        ref.read(pdfViewProvider));
  }

  @override
  List<Widget>? actionWidget(BuildContext context, WidgetRef ref) {
    final data = ref.watch(provider(ref)).data;
    if (data == null) return [];
    return [AttachmentDownloadWidget(attachment: data)];
  }

  @override
  List<Widget>? persistentFooterButtons(BuildContext context, WidgetRef ref) {
    final state = ref.watch(provider(ref));
    return [
      Row(
        children: [
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
}
