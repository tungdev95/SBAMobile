import 'package:flutter/material.dart';

/// A tile that is used to display the error indicator when
/// loading more items fails.
class ScrollViewLoadMoreError extends StatelessWidget {
  /// Creates a new instance of [ScrollViewLoadMoreError.list].
  const ScrollViewLoadMoreError.list({
    super.key,
    this.error,
    this.errorStyle,
    this.errorIcon,
    this.backgroundColor,
    required this.onTap,
    this.padding = const EdgeInsets.all(16),
    this.mainAxisSize = MainAxisSize.max,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : _isList = true;

  /// Creates a new instance of [ScrollViewLoadMoreError.grid].
  const ScrollViewLoadMoreError.grid({
    super.key,
    this.error,
    this.errorStyle,
    this.errorIcon,
    this.backgroundColor,
    required this.onTap,
    this.padding = const EdgeInsets.all(16),
    this.mainAxisSize = MainAxisSize.max,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : _isList = false;

  /// The error message to display.
  final Widget? error;

  /// The style of the error message.
  final TextStyle? errorStyle;

  /// The icon to display next to the message.
  final Widget? errorIcon;

  /// The background color of the error message.
  final Color? backgroundColor;

  /// The callback to invoke when the user taps on the error indicator.
  final GestureTapCallback onTap;

  /// The amount of space by which to inset the child.
  final EdgeInsetsGeometry padding;

  /// The main axis size of the error view.
  final MainAxisSize mainAxisSize;

  /// The main axis alignment of the error view.
  final MainAxisAlignment mainAxisAlignment;

  /// The cross axis alignment of the error view.
  final CrossAxisAlignment crossAxisAlignment;

  final bool _isList;

  @override
  Widget build(BuildContext context) {
    // final theme = ChatTheme.of(context);

    final errorText = AnimatedDefaultTextStyle(
      style: errorStyle ?? TextStyle(color: Colors.white),
      duration: kThemeChangeDuration,
      child: error ?? const SizedBox(),
    );

    final errorIcon = AnimatedSwitcher(
      duration: kThemeChangeDuration,
      child: this.errorIcon ?? Icon(Icons.refresh),
    );

    final backgroundColor = this.backgroundColor ??
        Colors.white; //theme.colorTheme.textLowEmphasis.withOpacity(0.9);

    final children = [errorText, errorIcon];

    return InkWell(
      onTap: onTap,
      child: ColoredBox(
        color: backgroundColor,
        child: Padding(
          padding: padding,
          child: _isList
              ? Row(
                  mainAxisSize: mainAxisSize,
                  mainAxisAlignment: mainAxisAlignment,
                  crossAxisAlignment: crossAxisAlignment,
                  children: children,
                )
              : Column(
                  mainAxisSize: mainAxisSize,
                  mainAxisAlignment: mainAxisAlignment,
                  crossAxisAlignment: crossAxisAlignment,
                  children: children,
                ),
        ),
      ),
    );
  }
}
