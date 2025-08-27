import 'package:flutter/material.dart';

/// A widget that is displayed while the [ScrollView] is loading.
class ScrollViewLoadingWidget extends StatelessWidget {
  /// Creates a new instance of [ScrollViewLoadingWidget].
  const ScrollViewLoadingWidget({
    super.key,
    this.height = 42,
    this.width = 42,
  });

  /// The height of the indicator.
  final double height;

  /// The width of the indicator.
  final double width;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: height,
        width: width,
        child: const CircularProgressIndicator(),
      );
}
