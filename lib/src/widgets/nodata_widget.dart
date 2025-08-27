import 'package:flutter/cupertino.dart';
import 'package:sba/gen/assets.gen.dart';
import 'package:sba/generated/l10n.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    super.key,
    this.message,
  });

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.images.icNodata.svg(),
          const SizedBox(
            height: 8,
          ),
          Text(
            message ?? S.current.khong_co_du_lieu,
          )
        ],
      ),
    );
  }
}
