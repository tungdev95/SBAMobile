import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/services/base_api_services.dart';
import 'package:sba/src/utils/utils.dart';

/// AttachmentHandler implementation for io.
class AttachmentHandler {
  AttachmentHandler.__();

  factory AttachmentHandler._() {
    return AttachmentHandler.__();
  }

  static AttachmentHandler? _instance;

  String? _localPath;

  /// Returns the singleton instance of [AttachmentHandler].
  // ignore: prefer_constructors_over_static_methods
  static AttachmentHandler get instance => _instance ??= AttachmentHandler._();

  late final _imagePicker = ImagePicker();
  late final _filePicker = FilePicker.platform;

  Future<String?> downloadFile(
    WidgetRef ref,
    AttachmentFile attachment, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    await _prepareSaveDir();
    final appDir = _localPath;
    // attachment.
    var ext = attachment.name ??
        'pdf_file_${DateTime.now().millisecondsSinceEpoch.toString()}.pdf';

    final path = '$appDir/$ext';

    final oldFile = File(path);

    //File đã tồn tại, xóa file
    if (await oldFile.exists()) {
      await oldFile.delete();
      // return path;
    }

    // Create an XFile for proper file saving.
    final file = XFile.fromData(
      attachment.bytes!,
      name: attachment.name,
      path: path,
    );

    // Save the file to a temporary location.
    await file.saveTo(path);

    return path;
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;

    // print(_localPath);
    final savedDir = Directory(_localPath ?? '');
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    if (Platform.isAndroid) {
      return '/storage/emulated/0/Download';
    } else {
      var directory = await getApplicationDocumentsDirectory();
      return '${directory.path}${Platform.pathSeparator}Download';
    }
  }

  Future<Attachment?> pickImage({
    required ImageSource source,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
  }) async {
    final image = await _imagePicker.pickImage(
      source: source,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: imageQuality,
      preferredCameraDevice: preferredCameraDevice,
    );
    try {
      if (source == ImageSource.camera && image != null) {
        BotToast.showLoading();
        final newImage = await compute<XFile?, Uint8List?>(
          (message) async => bakeOrientation(await image.readAsBytes()),
          image,
        );
        XFile newFile = XFile.fromData(
          newImage!,
          path: image.path,
          name: image.name,
          mimeType: image.mimeType,
        );
        BotToast.closeAllLoading();
        return newFile.toAttachment();
      }

      return image?.toAttachment();
    } catch (e) {
      BotToast.closeAllLoading();
      // log('Error load image', error: e);
      // return null;
      return image?.toAttachment();
    }
  }

  Future<String> saveAttachmentFile({
    required AttachmentFile attachmentFile,
  }) async {
    final fileName = attachmentFile.name;
    assert(fileName != null, 'Attachment file name is required');

    final tempDir = await getTemporaryDirectory();
    final tempPath = Uri.file(tempDir.path);
    final tempFilePath = tempPath.resolve(fileName!).toFilePath();

    final attachmentFileBytes = attachmentFile.bytes;
    if (attachmentFileBytes == null) {
      final attachmentFilePath = attachmentFile.path!;
      final file = File(attachmentFilePath);
      return file.copy(tempFilePath).then((it) => it.path);
    } else {
      final file = File(tempFilePath);
      return file.writeAsBytes(attachmentFileBytes).then((it) => it.path);
    }
  }

  Future<void> deleteAttachmentFile({
    required AttachmentFile attachmentFile,
  }) async {
    final attachmentFilePath = attachmentFile.path;
    if (attachmentFilePath != null) {
      final file = File(attachmentFilePath);
      if (file.existsSync()) {
        await file.delete();
      }
    }
  }

  Future<String?> downloadAttachmentFile(
    Ref<Object?> ref,
    Attachment attachment, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    await _prepareSaveDir();
    final appDir = _localPath;
    // attachment.
    var ext = attachment.filename ??
        'pdf_file_${DateTime.now().millisecondsSinceEpoch.toString()}.pdf';

    final path = '$appDir/$ext';

    final oldFile = File(path);

    //File đã tồn tại, Không tải nữa
    if (await oldFile.exists()) {
      return path;
    }

    final data = await downloadAttachmentData(
      ref,
      attachment,
      onReceiveProgress: onReceiveProgress,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      options: options,
    );

    if (data == null) return null;

    // Create an XFile for proper file saving.
    final file = XFile.fromData(
      data,
      name: ext,
      path: path,
    );

    // Save the file to a temporary location.
    await file.saveTo(path);

    return file.path;
  }

  /// Downloads the [attachment] and returns the [AttachmentData].
  Future<Uint8List?> downloadAttachmentData(
    Ref<Object?> ref,
    Attachment attachment, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    if ((attachment.fileDownloadUrl ?? '').isEmpty) return null;

    final response = await ref.read(dioProvider).get<List<int>>(
          attachment.fileDownloadUrl!,
          onReceiveProgress: onReceiveProgress,
          queryParameters: queryParameters,
          cancelToken: cancelToken,
          options: options?.copyWith(responseType: ResponseType.bytes) ??
              Options(responseType: ResponseType.bytes),
        );

    final bytes = Uint8List.fromList(response.data!);

    return bytes;
  }
}
