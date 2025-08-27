import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heif_converter/heif_converter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/widgets/attachment/attachment_picker.dart';
import 'package:sba/src/widgets/attachment/photo_gallery.dart';
import 'package:sba/src/widgets/attachment/photo_gallery_controller.dart';
import 'package:synchronized/synchronized.dart';

final _permissionRequestLock = Lock();

/// Executes [computation] when [_permissionRequestLock] is available.
///
/// Only one asynchronous block can run while the [_permissionRequestLock]
/// is retained.
Future<T> runInPermissionRequestLock<T>(
  FutureOr<T> Function() computation, {
  Duration? timeout,
}) {
  return _permissionRequestLock.synchronized(
    computation,
    timeout: timeout,
  );
}

/// Max image resolution which can be resized by the CDN.
const maxCDNImageResolution = 16800000;

/// Widget used to pick media from the device gallery.
class GalleryPicker extends StatefulWidget {
  /// Creates a [GalleryPicker] widget.
  const GalleryPicker({
    super.key,
    this.limit = 50,
    required this.selectedMediaItems,
    required this.onMediaItemSelected,
    this.mediaThumbnailQuality = 100,
    this.mediaThumbnailScale = 1,
  });

  /// Maximum number of media items that can be selected.
  final int limit;

  /// List of selected media items.
  final Iterable<String> selectedMediaItems;

  /// Callback called when an media item is selected.
  final ValueSetter<AssetEntity> onMediaItemSelected;

  /// The quality value for the attachment thumbnails.
  ///
  /// Valid from 1 to 100.
  /// Defaults to 100.
  final int mediaThumbnailQuality;

  /// The scale to apply on the [attachmentThumbnailSize].
  final double mediaThumbnailScale;

  @override
  State<GalleryPicker> createState() => _GalleryPickerState();
}

class _GalleryPickerState extends State<GalleryPicker> {
  Future<PermissionState>? requestPermission;
  late PhotoGalleryController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PhotoGalleryController(limit: widget.limit);
    requestPermission = runInPermissionRequestLock(
      PhotoManager.requestPermissionExtend,
    );
  }

  @override
  void didUpdateWidget(GalleryPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.limit != oldWidget.limit) {
      _controller.dispose();
      _controller = PhotoGalleryController(limit: widget.limit);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PermissionState>(
      future: requestPermission,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();

        // Available on both Android and iOS.
        final isAuthorized = snapshot.data == PermissionState.authorized;
        // Only available on iOS.
        final isLimited = snapshot.data == PermissionState.limited;

        final isPermissionGranted = isAuthorized || isLimited;

        return OptionDrawer(
          actions: [
            if (isLimited)
              IconButton(
                // color: colorTheme.accentPrimary,
                icon: const Icon(Icons.add_circle_outline_rounded),
                onPressed: () async {
                  await PhotoManager.presentLimited();
                  _controller.doInitialLoad();
                },
              ),
          ],
          child: Builder(
            builder: (context) {
              if (!isPermissionGranted) {
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.photo,
                      size: 240,
                    ),
                    Text(
                      'Vui lòng cấp quyền truy cập vào thư viện',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    TextButton(
                      onPressed: PhotoManager.openSetting,
                      child: Text(
                        'Cấp quyền truy cập vào thư viện để chọn hình ảnh',
                      ),
                    ),
                  ],
                );
              }

              return PhotoGallery(
                shrinkWrap: true,
                controller: _controller,
                onMediaTap: widget.onMediaItemSelected,
                loadMoreTriggerIndex: 10,
                padding: const EdgeInsets.all(2),
                thumbnailQuality: widget.mediaThumbnailQuality,
                thumbnailScale: widget.mediaThumbnailScale,
                itemBuilder: (context, mediaItems, index, defaultWidget) {
                  final media = mediaItems[index];
                  return defaultWidget.copyWith(
                    selected: widget.selectedMediaItems.contains(media.id),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

///
extension ImagePickerX on AttachmentPickerController {
  ///
  Future<void> addAssetAttachment(AssetEntity asset) async {
    final mediaFile = await asset.originFile;

    if (mediaFile == null) return;

    var cachedFile = mediaFile;

    final type = asset.type;
    if (type == AssetType.image) {
      // Resize image if it's resolution
      final imageResolution = asset.width * asset.height;
      if (imageResolution > maxCDNImageResolution) {
        final aspect = imageResolution / maxCDNImageResolution;
        final updatedSize = asset.size / (math.sqrt(aspect));
        final resizedImage = await asset.thumbnailDataWithSize(
          ThumbnailSize(
            updatedSize.width.floor(),
            updatedSize.height.floor(),
          ),
          quality: 70,
        );
        final tempDir = await getTemporaryDirectory();
        cachedFile = await File(
          '${tempDir.path}/${mediaFile.path.split('/').last}',
        ).create().then((it) => it.writeAsBytes(resizedImage!));
      }
    }

    final extension = cachedFile.path.split('.').last.toLowerCase();
    if (extension == 'heic') {
      final tempDir = await getTemporaryDirectory();
      final fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final outputPath = '${tempDir.path}/$fileName';
      String? jpgPath = await HeifConverter.convert(cachedFile.path,
          output: outputPath, format: 'jpg');
      if (jpgPath != null) {
        cachedFile = File.fromUri(Uri.file(jpgPath));
      }
    }

    final file = AttachmentFile(
      path: cachedFile.path,
      size: await cachedFile.length(),
      bytes: cachedFile.readAsBytesSync(),
    );

    final mimeType = file.mimeType?.mimeType;

    final attachment = Attachment(
      id: asset.id,
      file: file,
      fileSize: file.size,
      mediaType: mimeType,
    );

    return addAttachment(attachment);
  }

  ///
  Future<void> removeAssetAttachment(AssetEntity asset) async {
    if (asset.type == AssetType.image) {
      final image = await asset.originFile;
      if (image != null) {
        final tempDir = await getTemporaryDirectory();
        final cachedFile =
            File('${tempDir.path}/${image.path.split('/').last}');
        if (cachedFile.existsSync()) {
          cachedFile.deleteSync();
        }
      }
    }
    return removeAttachmentById(asset.id);
  }
}

///
extension AssetTypeX on AssetType {
  ///
  String toAttachmentType() {
    switch (this) {
      case AssetType.image:
        return 'image';
      case AssetType.video:
        return 'video';
      case AssetType.audio:
        return 'audio';
      case AssetType.other:
        return 'file';
    }
  }
}
