import 'package:flutter/material.dart';
import 'package:sba/gen/assets.gen.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/widgets/attachment/attachment_upload_state_builder.dart';
import 'package:sba/src/widgets/attachment/attachment_widget.dart';
import 'package:sba/src/widgets/widget_network_image.dart';
import 'package:sba/src/widgets/widget_photo_viewer.dart';

class ImageAttachment extends AttachmentWidget {
  /// {@macro streamImageAttachment}
  const ImageAttachment({
    super.key,
    required super.asset,
    required super.attachment,
    super.constraints,
    this.borderRadius,
    required this.cancelUpload,
    required this.retryUpload,
    this.allowDelete = true,
    this.allImages,
  });

  final BorderRadius? borderRadius;

  final Function(String) cancelUpload;

  final Function(String) retryUpload;

  final bool allowDelete;

  final List<Attachment>? allImages;

  @override
  Widget build(BuildContext context) {
    return source.when(
      local: () {
        if (attachment.file?.bytes != null) {
          return _buildImageAttachment(
            context,
            Image.memory(
              attachment.file!.bytes!,
              height: constraints?.maxHeight,
              width: constraints?.maxWidth,
              fit: BoxFit.cover,
              errorBuilder: _imageErrorBuilder,
            ),
          );
        } else if (attachment.localUri != null) {
          return _buildImageAttachment(
            context,
            Image.asset(
              attachment.localUri?.path ?? '',
              height: constraints?.maxHeight,
              width: constraints?.maxWidth,
              fit: BoxFit.cover,
              errorBuilder: _imageErrorBuilder,
            ),
          );
        } else {
          //Upload ảnh lỗi
          // return AttachmentError(
          //   constraints: constraints,
          // );
          return const SizedBox.shrink();
        }
      },
      network: () {
        var imageUrl = attachment.imageDownloadUrl;

        if (imageUrl == null) {
          // ảnh lỗi
          // return AttachmentError(constraints: constraints);
          return const SizedBox.shrink();
        }

        return _buildImageAttachment(
          context,
          NetworkLoadImage(
            url: imageUrl,
            height: constraints?.maxHeight,
            width: constraints?.maxWidth,
            fit: BoxFit.cover,
            borderRadius: borderRadius,
          ),
        );
      },
    );
  }

  Widget _imageErrorBuilder(BuildContext _, Object __, StackTrace? ___) =>
      Assets.images.placeholder.image();

  Widget _buildImageAttachment(BuildContext context, Widget imageWidget) {
    return Container(
      constraints: constraints,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              fit: StackFit.loose,
              children: [
                GestureDetector(
                  onTap: () {
                    showImageViewerPage(
                      context,
                      lsImage: allImages ?? [attachment],
                      index: (allImages ?? [attachment])
                          .indexWhere((e) => e.id == attachment.id),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: imageWidget,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: AttachmentUploadStateBuilder(
                    asset: asset,
                    attachment: attachment,
                    cancelUpload: cancelUpload,
                    retryUpload: retryUpload,
                  ),
                ),
                if (allowDelete)
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 24,
                      height: 24,
                      margin: const EdgeInsets.all(4),
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
                          onPressed: () => cancelUpload.call(attachment.id),
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
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<dynamic> showImageViewerPage(BuildContext context,
    {List<Attachment>? lsImage, int index = 0}) async {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) {
        return PhotoViewerWidget(
          lsImage: lsImage ?? [],
          index: index,
        );
      },
    ),
  );
}
