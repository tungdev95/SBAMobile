import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/widgets/attachment/attachment_handler_io.dart';
import 'package:sba/src/widgets/attachment/attachment_picker.dart';
import 'package:sba/src/widgets/attachment/gallery_picker.dart';

/// Widget used to pick images from the device.
class ImagePicker extends StatelessWidget {
  /// Creates a [StreamImagePicker] widget.
  const ImagePicker({
    super.key,
    required this.onImagePicked,
    this.source = ImageSource.camera,
    this.maxWidth,
    this.maxHeight,
    this.imageQuality,
    this.preferredCameraDevice = CameraDevice.rear,
  });

  /// Callback called when an image is picked.
  final ValueSetter<Attachment?> onImagePicked;

  /// Source of the image to pick.
  final ImageSource source;

  /// Maximum width of the image.
  final double? maxWidth;

  /// Maximum height of the image.
  final double? maxHeight;

  /// Quality of the image.
  final int? imageQuality;

  /// Preferred camera device to use.
  final CameraDevice preferredCameraDevice;

  @override
  Widget build(BuildContext context) {
    // final theme = StreamChatTheme.of(context);
    return OptionDrawer(
      child: EndOfFrameCallbackWidget(
        // child: StreamSvgIcon.camera(
        //   size: 240,
        //   color: theme.colorTheme.disabled,
        // ),
        child: const Icon(Icons.camera),
        onEndOfFrame: (_) async {
          final pickedImage = await runInPermissionRequestLock(() {
            return AttachmentHandler.instance.pickImage(
              source: source,
              maxWidth: maxWidth,
              maxHeight: maxHeight,
              imageQuality: imageQuality,
              preferredCameraDevice: preferredCameraDevice,
            );
          });

          onImagePicked.call(pickedImage);
        },
        errorBuilder: (context, error, stacktrace) {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.camera_alt,
                size: 240,
                // color: context.theme.disabledColor,
              ),
              Text(
                'Vui lòng cấp quyền',
                // style: theme.textTheme.body.copyWith(
                //   color: theme.colorTheme.textLowEmphasis,
                // ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              TextButton(
                onPressed: PhotoManager.openSetting,
                child: Text(
                 'Vui lòng cấp quyền truy cập camera để chụp ảnh',
                  // style: theme.textTheme.bodyBold.copyWith(
                  //   color: theme.colorTheme.accentPrimary,
                  // ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
