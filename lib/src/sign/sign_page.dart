import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:riverpod/src/state_notifier_provider.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/screens/assets/assets.dart';
import 'package:sba/src/screens/base/base_page.dart';
import 'package:sba/src/sign/sign.dart';
import 'package:sba/src/utils/utils.dart';
import 'package:sba/src/widgets/add_signature_widget.dart';
import 'package:sba/src/widgets/attachment/attachment_download_widget.dart';
import 'package:sba/src/widgets/buttons/stadium_button.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SignPage extends BasePage<SignPageController, SignState> {
  const SignPage({super.key});

  @override
  String get title => S.current.ky_bien_ban;

  @override
  Widget bodyWidget(BuildContext context, WidgetRef ref, SignState state) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          pdfViewContent(context, ref, state),
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, top: 16.0),
                child: Row(
                  children: [
                    Text(S.current.chuyen_vien_ky),
                    Expanded(child: Container()),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Uint8List? signature = await showDialog(
                    context: context,
                    builder: (cContext) {
                      return AddSignatureDialogWidget(
                        title: S.current.chuyen_vien_ky,
                      );
                    },
                  );
                  ref.read(provider(ref).notifier).updateChuKyChuyenVien(
                        signature ?? state.chuKyChuyenVien,
                      );
                },
                child: Container(
                  color: Colors.white,
                  height: 150,
                  width: double.infinity,
                  margin: const EdgeInsets.all(10.0),
                  child: Stack(
                    children: [
                      DottedBorder(
                        color: Colors.black,
                        strokeWidth: 1,
                        child: state.chuKyChuyenVien != null
                            ? Center(
                                child: Image.memory(
                                height: 150,
                                state.chuKyChuyenVien!,
                                fit: BoxFit.cover,
                              ))
                            : const Center(
                                child: Text('Thêm chữ ký'),
                              ),
                      ),
                      deleteSignWidget(
                          onPressed:
                              ref.read(provider(ref).notifier).deleteStaffSign),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, top: 16.0),
                child: Row(
                  children: [
                    Text(S.current.nguoi_huong_dan_ky),
                    Expanded(child: Container()),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Uint8List? signature = await showDialog(
                    context: context,
                    builder: (cContext) {
                      return AddSignatureDialogWidget(
                        title: S.current.nguoi_huong_dan_ky,
                      );
                    },
                  );
                  ref
                      .read(provider(ref).notifier)
                      .updateChuKyKhachHang(signature ?? state.chuKyKhachHang);
                },
                child: Container(
                  color: Colors.white,
                  height: 150,
                  margin: const EdgeInsets.all(10.0),
                  child: Stack(
                    children: [
                      DottedBorder(
                        color: Colors.black,
                        strokeWidth: 1,
                        child: state.chuKyKhachHang != null
                            ? Center(
                                child: Image.memory(
                                  height: 150,
                                  state.chuKyKhachHang!,
                                  fit: BoxFit.fitHeight,
                                ),
                              )
                            : const Center(
                                child: Text('Thêm chữ ký'),
                              ),
                      ),
                      deleteSignWidget(
                          onPressed: ref
                              .read(provider(ref).notifier)
                              .deleteCustomerSign),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: context.padding.bottom,
          )
        ],
      ),
    );
  }

  Widget deleteSignWidget({required void Function() onPressed}) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: 24,
        height: 24,
        margin: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: RawMaterialButton(
            elevation: 0,
            highlightElevation: 0,
            focusElevation: 0,
            hoverElevation: 0,
            onPressed: onPressed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.close,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  @override
  AutoDisposeStateNotifierProvider<SignPageController, SignState> provider(
      WidgetRef ref) {
    return SignPageController.signPageProvider(ref.read(assetsDetailProvider));
  }

  Widget pdfViewContent(BuildContext context, WidgetRef ref, SignState state) {
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
                  S.current.bien_ban_khao_sat,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              if (state.attachment != null) ...[
                AttachmentDownloadWidget(attachment: state.attachment!),
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
            child: state.attachment != null
                ? SfPdfViewer.memory(
                    state.attachment!.bytes!,
                    onDocumentLoadFailed: (details) async {},
                  )
                : const SizedBox.shrink(),
          )
        ],
      ),
    );
  }

  @override
  List<Widget>? persistentFooterButtons(BuildContext context, WidgetRef ref) {
    var state = ref.read(provider(ref));
    return [
      Row(
        children: [
          // Expanded(
          //   child: CustomButton.save(
          //     onPressed: () {
          //       // ref.read(provider(ref).notifier).save();
          //     },
          //   ),
          // ),
          // const SizedBox(
          //   width: 8,
          // ),
          Expanded(
            child: CustomButton.primary(
              context,
              title: S.current.hoan_thanh,
              onPressed: () {
                ref.read(provider(ref).notifier).complete();
              },
            ),
          )
        ],
      )
    ];
  }
}
