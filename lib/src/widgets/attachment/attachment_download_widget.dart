import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/widgets/attachment/attachment_handler_io.dart';
import 'package:sba/src/widgets/attachment/gallery_picker.dart';

class AttachmentDownloadWidget extends ConsumerWidget {
  AttachmentFile attachment;
  AttachmentDownloadWidget({
    super.key,
    required this.attachment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        download(context, ref);
      },
      icon: const Icon(
        Icons.download,
        color: Colors.white,
      ),
    );
  }

  void download(BuildContext context, WidgetRef ref) async {
    await runInPermissionRequestLock(() async {
      final isOk = await _checkPermission();
      downloadFile(ref, context);
    });
  }

  Future<bool> _checkPermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  void downloadFile(WidgetRef ref, BuildContext context) {
    final downloader = AttachmentHandler.instance.downloadFile;

    downloader(
      ref,
      attachment,
      onReceiveProgress: (received, total) {
        // progressNotifier.value = _DownloadProgress(
        //   total,
        //   received,
        // );
      },
    ).then((path) {
      OpenFilex.open(path);
    }).catchError((e, stk) {});
  }
}
