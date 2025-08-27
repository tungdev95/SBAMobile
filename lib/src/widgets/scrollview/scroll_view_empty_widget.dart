import 'package:flutter/material.dart';

/// A widget that shows an empty view when the [ScrollView] loads
/// empty data.
class ScrollViewEmptyWidget extends StatelessWidget {
  /// Creates a new instance of the [ScrollViewEmptyWidget].
  const ScrollViewEmptyWidget({
    super.key,
    required this.emptyIcon,
    required this.emptyTitle,
    this.emptyTitleStyle,
    this.mainAxisSize = MainAxisSize.max,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  /// The title of the empty view.
  final Widget emptyTitle;

  /// The style of the title.
  final TextStyle? emptyTitleStyle;

  /// The icon of the empty view.
  final Widget emptyIcon;

  /// The main axis size of the empty view.
  final MainAxisSize mainAxisSize;

  /// The main axis alignment of the empty view.
  final MainAxisAlignment mainAxisAlignment;

  /// The cross axis alignment of the empty view.
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    // final chatThemeData = ChatTheme.of(context);

    final emptyIcon = AnimatedSwitcher(
      duration: kThemeChangeDuration,
      child: this.emptyIcon,
    );

    final emptyTitleText = AnimatedDefaultTextStyle(
      // style: emptyTitleStyle ?? chatThemeData.textTheme.headline,
      style: TextStyle(),
      duration: kThemeChangeDuration,
      child: emptyTitle,
    );

    return Column(
      mainAxisSize: mainAxisSize,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        emptyIcon,
        emptyTitleText,
      ],
    );
  }
}
