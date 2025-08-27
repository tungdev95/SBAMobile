import 'package:flutter/material.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/utils/utils.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final Color? textColor;
  final Color? borderColor;
  final Color? backgroundColor;

  const CustomButton({
    super.key,
    this.onPressed,
    required this.title,
    this.textColor = Colors.black,
    this.borderColor,
    this.backgroundColor = Colors.white,
  });

  factory CustomButton.save({String? title, VoidCallback? onPressed}) =>
      CustomButton(
        title: title ?? S.current.luu,
        onPressed: onPressed,
        borderColor: Colors.black.withOpacity(.2),
      );

  factory CustomButton.primary(BuildContext context,
          {required String title, VoidCallback? onPressed}) =>
      CustomButton(
        title: title,
        backgroundColor: context.colorScheme.primary,
        textColor: Colors.white,
        onPressed: onPressed,
      );

  factory CustomButton.danger(BuildContext context,
          {required String title, VoidCallback? onPressed}) =>
      CustomButton(
        title: title,
        backgroundColor: AppColor.redColor,
        textColor: Colors.white,
        onPressed: onPressed,
      );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.resolveWith(
          (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: borderColor != null
                  ? BorderSide(width: 1, color: borderColor!)
                  : BorderSide.none),
        ),
        elevation: MaterialStateProperty.resolveWith((states) => 0),
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) => backgroundColor,
        ),
      ),
      child: Text(
        title,
        style: context.textMediumBold.copyWith(color: textColor),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
