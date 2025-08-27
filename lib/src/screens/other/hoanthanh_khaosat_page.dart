import 'package:flutter/material.dart';
import 'package:sba/src/event/event.dart';
import 'package:sba/src/utils/utils.dart';

class HoanThanhKhaoSatPage extends StatelessWidget {
  ///Dùng để trả về danh sách item để qua tab chờ đồng bộ
  final String? assetsType;
  const HoanThanhKhaoSatPage({
    Key? key,
    this.assetsType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1)).then((value) {
      Navigator.of(context).popUntil(ModalRoute.withName('/'));
      if (assetsType != null) {
        eventBus.fire(OpenChoDongBoEvent(assetsType));
      }
    });
    return Container(
      color: Colors.white,
      width: context.screenSize.width,
      height: context.screenSize.height,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Image(
              image: AssetImage(ImageName.ic_complete),
              width: 70,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Hoàn tất biên bản khảo sát',
              style: context.textMediumMedium,
            )
          ],
        ),
      ),
    );
  }
}
