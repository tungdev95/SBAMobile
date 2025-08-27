import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sba/gen/assets.gen.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/utils/utils.dart';

class MemuItemWidget extends StatelessWidget {
  const MemuItemWidget({
    super.key,
    required this.item,
    required this.icon,
    this.onTap,
    this.isSelected = false,
  });

  final AssetMenuModel item;
  final Widget icon;
  final bool? isSelected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected == true ? Colors.white : Colors.transparent,
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Assets.images.bgItem.image(
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  icon,
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    item.title,
                    style: context.textTheme.bodySmall
                        ?.copyWith(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
