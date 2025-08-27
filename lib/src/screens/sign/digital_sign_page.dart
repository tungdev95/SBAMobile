import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/enum.dart';
import 'package:sba/src/screens/base/base_page.dart';
import 'package:sba/src/screens/sign/controller/digital_sign_page_controller.dart';
import 'package:sba/src/screens/sign/state/digital_sign_data_state.dart';
import 'package:sba/src/screens/sign/state/digital_sign_state.dart';
import 'package:sba/src/widgets/buttons/stadium_button.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

final digitalSignDataProvider = Provider<DigitalSignDataState>((ref) {
  throw UnimplementedError();
});

class DigitalSignPage
    extends BasePage<DigitalSignPageController, DigitalSignState> {
  const DigitalSignPage({super.key});

  @override
  String get title => S.current.ky_so_thong_bao_kqtd;

  @override
  Widget bodyWidget(
      BuildContext context, WidgetRef ref, DigitalSignState state) {
    final controller = useTabController(initialLength: 2);

    return Column(
      children: [
        TabBar(
          controller: controller,
          onTap: (index) {
            ref.read(provider(ref).notifier).changeTab(index);
          },
          tabs: [
            Tab(
              text: S.current.tbkq_tham_dinh,
            ),
            Tab(
              text: S.current.kq_tham_dinh,
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: controller,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              HookConsumer(
                builder: (context, ref, widget) {
                  if (state.tbkqThamDinh == null) {
                    return const Center(
                      child: LoadingWidget(),
                    );
                  }
                  return SfPdfViewer.memory(
                    key: const ValueKey(1),
                    state.tbkqThamDinh!,
                    onDocumentLoadFailed: (error) {
                      // ref
                      //     .read(provider(ref).notifier)
                      //     .showMessageDialog(error.description);
                    },
                  );
                },
              ),
              HookConsumer(
                builder: (context, ref, widget) {
                  final keepAlive = useAutomaticKeepAlive(wantKeepAlive: true);
                  if (state.kqThamDinh == null) {
                    return const Center(
                      child: LoadingWidget(),
                    );
                  }
                  return SfPdfViewer.memory(
                    key: const ValueKey(2),
                    state.kqThamDinh!,
                    onDocumentLoadFailed: (error) {
                      // ref
                      //     .read(provider(ref).notifier)
                      //     .showMessageDialog(error.description);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  AutoDisposeStateNotifierProvider<DigitalSignPageController, DigitalSignState>
      provider(WidgetRef ref) =>
          DigitalSignPageController.digitalSignPageController(
              ref.read(digitalSignDataProvider));

  @override
  List<Widget>? persistentFooterButtons(BuildContext context, WidgetRef ref) {
    final state = ref.read(provider(ref));
    bool showKySo = state.fileStatus != FileStatus.daKySo;
    final coQuyenKySo = state.coQuyenKySo;
    if (!showKySo || coQuyenKySo == null) {
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
            )
          ],
        )
      ];
    }
    return [
      coQuyenKySo
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CustomButton.danger(
                    context,
                    title: S.current.tu_choi,
                    onPressed: () {
                      ref.read(provider(ref).notifier).tuChoiToTrinh(context);
                    },
                  ),
                  const SizedBox(width: 8),
                  CustomButton.primary(
                    context,
                    title: S.current.ky_so,
                    onPressed: () {
                      ref.read(provider(ref).notifier).kySo(context);
                    },
                  ),
                  const SizedBox(width: 8),
                  CustomButton.primary(
                    context,
                    title: S.current.dieu_chinh_nguoi_ky_so,
                    onPressed: () {
                      ref.read(provider(ref).notifier).chonCapDuyet(context);
                    },
                  ),
                ],
              ),
            )
          : Row(
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
