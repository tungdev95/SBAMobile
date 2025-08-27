import 'package:flutter/material.dart';
import 'package:sba/src/utils/utils.dart';

class BaseBottomSheetBodyWidget extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const BaseBottomSheetBodyWidget({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                title.toUpperCase(),
                style: context.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Divider(
                  height: 0,
                ),
                ...children,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
