import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/screens/base/controller/base_controller.dart';
import 'dart:ui' as ui;
import 'package:mime/mime.dart';
import 'package:sba/src/screens/map/states/map_state.dart';
import 'package:sba/src/services/file_service.dart';

class ZoningMapPageController extends BaseController<MapPageData> {
  ZoningMapPageController(super.state, super.ref);
  static final zoningMapControllerProvider = StateNotifierProvider.autoDispose
      .family<ZoningMapPageController, MapPageData, MapPageData>((ref, args) {
    return ZoningMapPageController(
      args,
      ref,
    );
  });

  late InAppWebViewController controller;
  GlobalKey mapKey = GlobalKey();
  bool isDeleteInfo = false;

  void screenShoot() async {
    await removeElement('//*[@id="divMap"]/div[2]/div[1]');
    await removeElement('//*[@id="divMap"]/div[2]/div[3]');
    await removeElement('//*[@id="container"]');
    Uint8List? mapImage;
    if (Platform.isAndroid) {
      RenderRepaintBoundary boundary =
          mapKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      mapImage = byteData!.buffer.asUint8List();
    } else {
      mapImage = await controller.takeScreenshot(
          screenshotConfiguration: ScreenshotConfiguration());
    }
    if (mapImage == null) return;
    var mime = lookupMimeType('', headerBytes: mapImage);
    var extension = extensionFromMime(mime ?? '');
    final result = Attachment(
      mediaType: mime,
      fileSize: mapImage.length,
      file: AttachmentFile(
        size: mapImage.length,
        bytes: mapImage,
        name: 'map_image_${DateTime.now().millisecondsSinceEpoch}.png',
      ),
    );
    saveMapLocation(context, result);
  }

  Future removeElement(String xpath) {
    return controller.evaluateJavascript(
        source:
            'document.evaluate(\'$xpath\', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.remove()');
  }

  void removeInfoView() {
    if (isDeleteInfo) return;

    isDeleteInfo = true;
    //Xóa thông tin bản đồ
    removeElement('//*[@id="divMap"]/div[2]/div[4]/details/div');
    Future.delayed(const Duration(seconds: 1)).then((value) {
      //Xóa chế độ xem
      removeElement('//*[@id="divMap"]/div[2]/div[4]/div[1]');
    });
  }

  void saveMapLocation(BuildContext context, Attachment result) async {
    if (isShowLoading) return;
    showLoading();

    try {
      final uploadResult = await ref.read(fileServiceProvider).sendImage(
            result.file,
            code: state.proposalCode,
          );
      hideLoading();

      if (!mounted) return;

      if (uploadResult != null) {
        Navigator.of(context).maybePop(uploadResult);
      } else {
        showMessageDialog(S.current.upload_anh_quy_hoach_loi);
      }
    } catch (e) {
      hideLoading();
      showMessageDialog(S.current.upload_anh_quy_hoach_loi);
    }
  }
}
