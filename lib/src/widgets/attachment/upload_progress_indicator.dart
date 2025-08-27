import 'package:flutter/material.dart';

class UploadProgressIndicator extends StatelessWidget {
  const UploadProgressIndicator({
    super.key,
    required this.uploaded,
    required this.total,
    this.progressIndicatorColor = const Color(0xffb2b2b2),
    this.padding = const EdgeInsets.only(
      top: 5,
      bottom: 5,
      right: 11,
      left: 5,
    ),
    this.showBackground = true,
    this.textStyle,
  });

  /// Bytes uploaded
  final int uploaded;

  /// Total bytes
  final int total;

  /// Color of progress indicator
  final Color progressIndicatorColor;

  /// Padding for widget
  final EdgeInsetsGeometry padding;

  /// Flag for showing background
  final bool showBackground;

  /// [TextStyle] to be applied to text
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final percentage = (uploaded / total) * 100;
    Widget child = Padding(
      padding: padding,
      child: SizedBox(
        height: 16,
        width: 16,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          strokeAlign: 4,
          value: percentage,
          valueColor: AlwaysStoppedAnimation(progressIndicatorColor),
        ),
      ),
    );
    if (showBackground) {
      child = DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          // color: theme.colorTheme.overlayDark.withOpacity(0.6),
        ),
        child: child,
      );
    }
    return child;
  }
}
