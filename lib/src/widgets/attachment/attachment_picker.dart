import 'dart:async';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/models/assets/assets.dart';
import 'package:sba/src/utils/utils.dart';
import 'package:sba/src/widgets/attachment/image_picker.dart' as img;

import 'attachment_handler_io.dart';

typedef ErrorListener = void Function(
  Object error,
  StackTrace? stackTrace,
);

/// The default maximum size for media attachments.
const kDefaultMaxAttachmentSize = 50 * 1024 * 1024; // 50MB in Bytes

/// The default maximum number of media attachments.
const kDefaultMaxAttachmentCount = 50;

const allowedExtensions = [
  'jpg',
  'png',
  'jpeg',
  'pdf',
  'txt',
  'doc',
  'docx',
  'xls',
  'ppt',
  'xlxs',
];

/// Controller class for [AttachmentPicker].
class AttachmentPickerController extends ValueNotifier<List<Attachment>> {
  /// Creates a new instance of [AttachmentPickerController].
  AttachmentPickerController({
    this.initialAttachments,
    this.maxAttachmentSize = kDefaultMaxAttachmentSize,
    this.maxAttachmentCount = kDefaultMaxAttachmentCount,
  })  : assert(
          (initialAttachments?.length ?? 0) <= maxAttachmentCount,
          '''The initial attachments count must be less than or equal to maxAttachmentCount''',
        ),
        super(initialAttachments ?? const []);

  /// The max attachment size allowed in bytes.
  final int maxAttachmentSize;

  /// The max attachment count allowed.
  final int maxAttachmentCount;

  /// The initial attachments.
  final List<Attachment>? initialAttachments;

  @override
  set value(List<Attachment> newValue) {
    if (newValue.length > maxAttachmentCount) {
      throw ArgumentError(
          S.current.ban_chi_duoc_chon_toi_da_anh(maxAttachmentCount));
    }
    super.value = newValue;
  }

  Future<String> _saveToCache(AttachmentFile file) async {
    // Cache the attachment in a temporary file.
    return AttachmentHandler.instance.saveAttachmentFile(
      attachmentFile: file,
    );
  }

  Set<AttachmentPickerType> filterEnabledTypes({
    required Iterable<AttachmentPickerOption> options,
  }) {
    final availableTypes = {
      AttachmentPickerType.images,
    };
    final enabledTypes = <AttachmentPickerType>{};
    for (final option in options) {
      final supportedTypes = option.supportedTypes;
      if (availableTypes.any(supportedTypes.contains)) {
        enabledTypes.addAll(supportedTypes);
      }
    }
    return enabledTypes;
  }

  Future<void> _removeFromCache(AttachmentFile file) {
    // Remove the cached attachment file.
    return AttachmentHandler.instance.deleteAttachmentFile(
      attachmentFile: file,
    );
  }

  /// Adds a new attachment to the message.
  Future<void> addAttachment(Attachment attachment) async {
    // assert(attachment.fileSize != null, '');
    if ((attachment.fileSize ?? 0) > maxAttachmentSize) {
      throw ArgumentError(
        S.current.dung_luong_file_error(
          fileSize(attachment.fileSize),
          fileSize(maxAttachmentSize),
        ),
      );
    }
    final fileExtension = attachment.file?.extension?.toLowerCase();
    final imageAllow = ['jpeg', 'jpg', 'png'];
    if (!imageAllow.contains(fileExtension)) {
      throw ArgumentError(
          'Định dạng ảnh "$fileExtension" không được hỗ trợ, chỉ upload được ảnh định dạng "${imageAllow.join(', ')}"');
    }

    final file = attachment.file;
    final uploadState = attachment.uploadState;

    // No need to cache the attachment if it's already uploaded
    // or we are on web.
    if (file == null || uploadState.isSuccess || kIsWeb) {
      value = [...value, attachment];
      return;
    }

    // Cache the attachment in a temporary file.
    final tempFilePath = await _saveToCache(file);

    value = [
      ...value,
      attachment.copyWith(
        file: file.copyWith(
          path: tempFilePath,
        ),
      ),
    ];
  }

  /// Removes the specified [attachment] from the message.
  Future<void> removeAttachment(Attachment attachment) async {
    final file = attachment.file;
    final uploadState = attachment.uploadState;

    if (file == null || uploadState.isSuccess || kIsWeb) {
      value = [...value]..remove(attachment);
      return;
    }

    // Remove the cached attachment file.
    await _removeFromCache(file);

    value = [...value]..remove(attachment);
  }

  /// Remove the attachment with the given [attachmentId].
  void removeAttachmentById(String attachmentId) {
    final attachment = value.firstWhereOrNull(
      (attachment) => attachment.id == attachmentId,
    );

    if (attachment == null) return;

    removeAttachment(attachment);
  }

  /// Clears all the attachments.
  Future<void> clear() async {
    final attachments = [...value];
    for (final attachment in attachments) {
      final file = attachment.file;
      final uploadState = attachment.uploadState;

      if (file == null || uploadState.isSuccess || kIsWeb) continue;

      await _removeFromCache(file);
    }
    value = const [];
  }

  /// Resets the controller to its initial state.
  Future<void> reset() async {
    final attachments = [...value];
    for (final attachment in attachments) {
      final file = attachment.file;
      final uploadState = attachment.uploadState;

      if (file == null || uploadState.isSuccess || kIsWeb) continue;

      await _removeFromCache(file);
    }
    value = initialAttachments ?? const [];
  }
}

/// The possible picker types of the attachment picker.
enum AttachmentPickerType {
  /// The attachment picker will only allow to pick images.
  images,

  /// The attachment picker will only allow to pick videos.
  videos,
}

/// Function signature for building the attachment picker option view.
typedef AttachmentPickerOptionViewBuilder = Widget Function(
  BuildContext context,
  AttachmentPickerController controller,
);

/// Model class for the attachment picker options.
class AttachmentPickerOption {
  /// Creates a new instance of [AttachmentPickerOption].
  const AttachmentPickerOption({
    this.key,
    required this.supportedTypes,
    required this.icon,
    this.title,
    this.optionViewBuilder,
  });

  /// A key to identify the option.
  final String? key;

  /// The icon of the option.
  final Widget icon;

  /// The title of the option.
  final String? title;

  /// The supported types of the option.
  final Iterable<AttachmentPickerType> supportedTypes;

  /// The option view builder.
  final AttachmentPickerOptionViewBuilder? optionViewBuilder;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttachmentPickerOption &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          const IterableEquality().equals(supportedTypes, other.supportedTypes);

  @override
  int get hashCode =>
      key.hashCode ^ const IterableEquality().hash(supportedTypes);
}

/// Helpful extensions for [AttachmentPickerController].
extension AttachmentPickerOptionTypeX on AttachmentPickerController {
  /// Returns true if the [initialAttachments] are changed.
  bool get isValueChanged {
    final isEqual = UnorderedIterableEquality(
      EqualityBy((Attachment attachment) => attachment.id),
    ).equals(value, initialAttachments);

    return !isEqual;
  }
}

/// Bottom sheet widget for the mobile version of the  attachment picker.
class MobileAttachmentPickerBottomSheet extends StatefulWidget {
  /// Creates a new instance of [MobileAttachmentPickerBottomSheet].
  const MobileAttachmentPickerBottomSheet({
    super.key,
    required this.options,
    required this.controller,
    this.initialOption,
    this.onSendAttachments,
  });

  /// The list of options.
  final Set<AttachmentPickerOption> options;

  /// The initial option to be selected.
  final AttachmentPickerOption? initialOption;

  /// The controller of the attachment picker.
  final AttachmentPickerController controller;

  /// The callback when the send button gets tapped.
  final ValueSetter<List<Attachment>>? onSendAttachments;

  @override
  State<MobileAttachmentPickerBottomSheet> createState() =>
      _MobileAttachmentPickerBottomSheetState();
}

class _MobileAttachmentPickerBottomSheetState
    extends State<MobileAttachmentPickerBottomSheet> {
  late AttachmentPickerOption _currentOption;

  @override
  void initState() {
    super.initState();
    if (widget.initialOption == null) {
      final enabledTypes = widget.controller.filterEnabledTypes(
        options: widget.options,
      );
      if (enabledTypes.isNotEmpty) {
        _currentOption = widget.options.firstWhere((it) {
          return it.supportedTypes.contains(enabledTypes.first);
        });
      } else {
        _currentOption = widget.options.first;
      }
    } else {
      _currentOption = widget.initialOption!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Attachment>>(
      valueListenable: widget.controller,
      builder: (context, attachments, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _AttachmentPickerOptions(
              controller: widget.controller,
              options: widget.options,
              currentOption: _currentOption,
              onSendAttachment: widget.onSendAttachments,
              onOptionSelected: (option) async {
                setState(() => _currentOption = option);
              },
            ),
            Expanded(
              child: _currentOption.optionViewBuilder
                      ?.call(context, widget.controller) ??
                  const SizedBox.shrink(),
            ),
          ],
        );
      },
    );
  }
}

class _AttachmentPickerOptions extends StatelessWidget {
  const _AttachmentPickerOptions({
    required this.options,
    required this.currentOption,
    required this.controller,
    this.onOptionSelected,
    this.onSendAttachment,
  });

  final Iterable<AttachmentPickerOption> options;
  final AttachmentPickerOption currentOption;
  final AttachmentPickerController controller;
  final ValueSetter<AttachmentPickerOption>? onOptionSelected;
  final ValueSetter<List<Attachment>>? onSendAttachment;

  @override
  Widget build(BuildContext context) {
    // final colorTheme = ChatTheme.of(context).colorTheme;
    return ValueListenableBuilder<List<Attachment>>(
      valueListenable: controller,
      builder: (context, attachments, __) {
        return Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...options.map(
                      (option) {
                        final supportedTypes = option.supportedTypes;

                        final isSelected = option == currentOption;
                        // final isEnabled = true;

                        final color = isSelected
                            ? AppColor.primaryColor
                            : context.theme.disabledColor;

                        // void onPressed() =>

                        return IconButton(
                          color: color,
                          disabledColor: context.theme.disabledColor,
                          icon: option.icon,
                          onPressed: () => onOptionSelected!.call(option),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Builder(
              builder: (context) {
                final isEnabled =
                    onSendAttachment != null && controller.isValueChanged;

                final onPressed = isEnabled
                    ? () {
                        onSendAttachment!(attachments);
                      }
                    : null;

                return IconButton(
                  iconSize: 22,
                  color: context.theme.colorScheme.primary,
                  disabledColor: context.theme.disabledColor,
                  icon: const Icon(Icons.send),
                  onPressed: onPressed,
                );
              },
            ),
          ],
        );
      },
    );
  }
}

/// Signature used by [EndOfFrameCallbackWidget.errorBuilder] to create a
/// replacement widget to render.
typedef EndOfFrameCallbackErrorWidgetBuilder = Widget Function(
  BuildContext context,
  Object error,
  StackTrace? stackTrace,
);

/// Function signature for a callback that is called when the end of the frame
/// is reached.
typedef EndOfFrameCallback = FutureOr<void> Function(BuildContext context);

/// A widget that calls the given [callback] when the end of the frame is
/// reached.
class EndOfFrameCallbackWidget extends StatefulWidget {
  /// Creates a new instance of [EndOfFrameCallbackWidget].
  const EndOfFrameCallbackWidget({
    super.key,
    required this.onEndOfFrame,
    this.child,
    this.errorBuilder,
  });

  /// The widget below this widget in the tree.
  final Widget? child;

  /// The callback that is called when the end of the frame is reached.x
  final EndOfFrameCallback onEndOfFrame;

  /// The callback that will be called if the [onEndOfFrame] callback throws an
  /// error.
  final EndOfFrameCallbackErrorWidgetBuilder? errorBuilder;

  @override
  State<EndOfFrameCallbackWidget> createState() =>
      _EndOfFrameCallbackWidgetState();
}

class _EndOfFrameCallbackWidgetState extends State<EndOfFrameCallbackWidget> {
  Object? _error;
  StackTrace? _stackTrace;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.endOfFrame.then((_) async {
      if (mounted) {
        try {
          await widget.onEndOfFrame(context);
        } catch (error, stackTrace) {
          setState(() {
            _error = error;
            _stackTrace = stackTrace;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final error = _error;
    final stackTrace = _stackTrace;

    if (error != null) {
      final errorBuilder = widget.errorBuilder;
      if (errorBuilder != null) {
        return errorBuilder(context, error, stackTrace);
      }
      return const Text('An error occurred');
    }

    // Reset the error and stack trace so that we don't keep showing the same
    // error over and over.
    _error = null;
    _stackTrace = null;

    return widget.child ?? const SizedBox.shrink();
  }
}

const _kDefaultOptionDrawerShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(16),
    topRight: Radius.circular(16),
  ),
);

/// A widget that will be shown in the attachment picker.
/// It can be used to show a custom view for each attachment picker option.
class OptionDrawer extends StatelessWidget {
  /// Creates a widget that will be shown in the attachment picker.
  const OptionDrawer({
    super.key,
    required this.child,
    this.color,
    this.elevation = 2,
    this.margin = EdgeInsets.zero,
    this.clipBehavior = Clip.hardEdge,
    this.shape = _kDefaultOptionDrawerShape,
    this.title,
    this.actions = const [],
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// The background color of the options card.
  ///
  /// Defaults to [ColorTheme.barsBg].
  final Color? color;

  /// The elevation of the options card.
  ///
  /// The default value is 2.
  final double elevation;

  /// The margin of the options card.
  ///
  /// The default value is [EdgeInsets.zero].
  final EdgeInsetsGeometry margin;

  /// The clip behavior of the options card.
  ///
  /// The default value is [Clip.hardEdge].
  final Clip clipBehavior;

  /// The shape of the options card.
  final ShapeBorder shape;

  /// The title of the options card.
  final Widget? title;

  /// The actions available for the options card.
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    // final colorTheme = ChatTheme.of(context).colorTheme;

    var height = 20.0;
    if (title != null || actions.isNotEmpty) {
      height = 40.0;
    }

    final leading = title ?? const SizedBox.shrink();

    Widget trailing;
    if (actions.isNotEmpty) {
      trailing = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: actions,
      );
    } else {
      trailing = const SizedBox.shrink();
    }

    return Card(
      elevation: elevation,
      // color: color ?? colorTheme.barsBg,
      margin: margin,
      shape: shape,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: height,
            child: Row(
              children: [
                Expanded(child: leading),
                Container(
                  height: 4,
                  width: 40,
                  decoration: BoxDecoration(
                    // color: colorTheme.disabled,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                Expanded(child: trailing),
              ],
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

/// Returns the mobile version of the attachment picker.
Widget mobileAttachmentPickerBuilder({
  required BuildContext context,
  required AttachmentPickerController controller,
  List<AttachmentPickerType> allowedTypes = AttachmentPickerType.values,
  int attachmentThumbnailQuality = 100,
  double attachmentThumbnailScale = 1,
  ErrorListener? onError,
  bool onlyGallery = false,
  bool onlyCamera = false,
}) {
  AttachmentPickerOption galleryPicker() {
    return AttachmentPickerOption(
      key: 'gallery-picker',
      icon: const Icon(Icons.image),
      supportedTypes: [
        AttachmentPickerType.images,
      ],
      optionViewBuilder: (context, controller) {
        final selectedIds = controller.value.map((it) => it.id);
        return OptionDrawer(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey),
                ),
                child: IconButton(
                  onPressed: () async {
                    try {
                      final lsImage =
                          await ImagePicker().pickMultiImage(maxWidth: 2048);
                      if (lsImage.isNotEmpty) {
                        for (var element in lsImage) {
                          await controller
                              .addAttachment(await element.toAttachment());
                        }
                        return Navigator.pop(context, controller.value);
                      } else {
                        return Navigator.pop(context, null);
                      }
                    } catch (e, stk) {
                      if (onError != null) return onError.call(e, stk);
                      rethrow;
                    }
                  },
                  icon: const Icon(Icons.add),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('Click để chọn ảnh từ thư viện!')
            ],
          ),
        );
        // return GalleryPicker(
        //   selectedMediaItems: selectedIds,
        //   mediaThumbnailQuality: attachmentThumbnailQuality,
        //   mediaThumbnailScale: attachmentThumbnailScale,
        //   onMediaItemSelected: (media) async {
        //     try {
        //       if (selectedIds.contains(media.id)) {
        //         return await controller.removeAssetAttachment(media);
        //       }
        //       return await controller.addAssetAttachment(media);
        //     } catch (e, stk) {
        //       // debugPrint(e.toString(), stk.toString());
        //       log(e.toString(), error: e, stackTrace: stk);
        //       if (onError != null) return onError.call(e, stk);
        //       rethrow;
        //     }
        //   },
        // );
      },
    );
  }

  AttachmentPickerOption cameraPicker() {
    return AttachmentPickerOption(
      key: 'image-picker',
      icon: const Icon(
        Icons.camera_alt,
      ),
      supportedTypes: [AttachmentPickerType.images],
      optionViewBuilder: (context, controller) {
        return img.ImagePicker(
          onImagePicked: (image) async {
            try {
              if (image != null) {
                await controller.addAttachment(image);
                return Navigator.pop(context, controller.value);
              }
              return Navigator.pop(context, null);
            } catch (e, stk) {
              log('Lỗi chụp ảnh', error: e, stackTrace: stk);
              Navigator.pop(context, null);
              if (onError != null) return onError.call(e, stk);

              rethrow;
            }
          },
        );
      },
    );
  }

  return MobileAttachmentPickerBottomSheet(
    controller: controller,
    onSendAttachments: Navigator.of(context).pop,
    options: {
      if (onlyGallery) galleryPicker(),
      if (onlyCamera) cameraPicker(),
      if (!onlyCamera && !onlyGallery)
        ...{
          galleryPicker(),
          cameraPicker(),
        }..where(
            (option) => option.supportedTypes.every(allowedTypes.contains),
          ),
    },
  );
}
