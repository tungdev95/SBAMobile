import 'dart:async';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/utils/dialog_utils.dart';
import 'package:sba/src/widgets/attachment/attachment_picker.dart';

Future<T?> showAttachmentPickerModalBottomSheet<T>({
  required BuildContext context,
  // Iterable<AttachmentPickerOption>? customOptions,
  List<AttachmentPickerType> allowedTypes = AttachmentPickerType.values,
  List<Attachment>? initialAttachments,
  AttachmentPickerController? controller,
  ErrorListener? onError,
  Color? backgroundColor,
  double? elevation,
  BoxConstraints? constraints,
  Color? barrierColor,
  bool isScrollControlled = false,
  bool useRootNavigator = false,
  bool isDismissible = true,
  bool enableDrag = true,
  RouteSettings? routeSettings,
  AnimationController? transitionAnimationController,
  Clip? clipBehavior = Clip.hardEdge,
  ShapeBorder? shape,
  ThumbnailSize attachmentThumbnailSize = const ThumbnailSize(400, 400),
  ThumbnailFormat attachmentThumbnailFormat = ThumbnailFormat.jpeg,
  int attachmentThumbnailQuality = 100,
  double attachmentThumbnailScale = 1,
  bool onlyGallery = false,
  bool onlyCamera = false,
  int? maxImage,
}) {
  return showModalBottomSheet<T>(
    context: context,
    backgroundColor: Colors.white,
    elevation: elevation,
    shape: shape,
    clipBehavior: clipBehavior,
    constraints: constraints,
    barrierColor: barrierColor,
    isScrollControlled: isScrollControlled,
    useRootNavigator: useRootNavigator,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    routeSettings: routeSettings,
    transitionAnimationController: transitionAnimationController,
    builder: (BuildContext context) {
      return PlatformAttachmentPickerBottomSheetBuilder(
        controller: controller,
        initialAttachments: initialAttachments,
        builder: (context, controller, child) {
          return mobileAttachmentPickerBuilder.call(
            context: context,
            onError: (e, stk) {
              var mess = e.toString();
              if (e is ArgumentError) mess = e.message;
              DialogUtils.showMessageDialog(context, mess);
            },
            controller: controller,
            allowedTypes: allowedTypes,
            attachmentThumbnailQuality: attachmentThumbnailQuality,
            attachmentThumbnailScale: attachmentThumbnailScale,
            onlyCamera: onlyCamera,
            onlyGallery: onlyGallery,
          );
        },
      );
    },
  );
}

/// Builds the attachment picker bottom sheet.
class PlatformAttachmentPickerBottomSheetBuilder extends StatefulWidget {
  /// Creates a new instance of the widget.
  const PlatformAttachmentPickerBottomSheetBuilder({
    super.key,
    this.customOptions,
    this.initialAttachments,
    this.child,
    this.controller,
    required this.builder,
  });

  /// The child widget.
  final Widget? child;

  /// Builder for the attachment picker bottom sheet.
  final Widget Function(
    BuildContext context,
    AttachmentPickerController controller,
    Widget? child,
  ) builder;

  /// The custom options to be displayed in the attachment picker.
  final List<AttachmentPickerOption>? customOptions;

  /// The initial attachments.
  final List<Attachment>? initialAttachments;

  /// The controller.
  final AttachmentPickerController? controller;

  @override
  State<PlatformAttachmentPickerBottomSheetBuilder> createState() =>
      _PlatformAttachmentPickerBottomSheetBuilderState();
}

class _PlatformAttachmentPickerBottomSheetBuilderState
    extends State<PlatformAttachmentPickerBottomSheetBuilder> {
  late AttachmentPickerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        AttachmentPickerController(
          initialAttachments: widget.initialAttachments,
        );
  }

  // Handle a potential change in AttachmentPickerController by properly
  // disposing of the old one and setting up the new one, if needed.
  void _updateTextEditingController(
    AttachmentPickerController? old,
    AttachmentPickerController? current,
  ) {
    if ((old == null && current == null) || old == current) return;
    if (old == null) {
      _controller.dispose();
      _controller = current!;
    } else if (current == null) {
      _controller = AttachmentPickerController();
    } else {
      _controller = current;
    }
  }

  @override
  void didUpdateWidget(
    PlatformAttachmentPickerBottomSheetBuilder oldWidget,
  ) {
    super.didUpdateWidget(oldWidget);
    _updateTextEditingController(
      oldWidget.controller,
      widget.controller,
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _controller, widget.child);
  }
}
