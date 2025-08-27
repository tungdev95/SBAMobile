import 'package:flutter/material.dart';

class CaiDatItemWidget extends StatelessWidget {
  final Widget icon;
  final String title;
  final Widget? trailing;
  final VoidCallback onClicked;
  final TextStyle? titleStyle;
  const CaiDatItemWidget({
    Key? key,
    required this.icon,
    required this.title,
    this.trailing,
    required this.onClicked,
    this.titleStyle,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClicked,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 8,
            ),
            icon,
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: titleStyle,
                    ),
                  ),
                  trailing ??
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 20,
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
