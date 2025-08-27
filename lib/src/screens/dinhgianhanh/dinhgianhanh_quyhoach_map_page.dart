import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:sba/src/utils/utils.dart';
import 'package:sba/src/widgets/base/color_schemes.dart';

class DinhGiaNhanhQuyHoachMapPage extends StatelessWidget {
  final String lat;
  final String lng;
  const DinhGiaNhanhQuyHoachMapPage(
      {super.key, required this.lat, required this.lng});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // leading: leadingAppbarWidget(context, ref),
        title: Text(
          'Quy hoạch',
          maxLines: 1,
          overflow: TextOverflow.fade,
          style: context.textTitleBold.copyWith(
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: defaultBGGradient,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: InAppWebView(
        initialUrlRequest:
            URLRequest(url: Uri.parse('https://map.ekgis.vn/#16/$lat/$lng')),
        onWebViewCreated: (controller) {
          // ref.read(provider(ref).notifier).controller = controller;
        },
        androidOnGeolocationPermissionsShowPrompt:
            (InAppWebViewController controller, String origin) async {
          bool? result = await showDialog<bool>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Cấp quyền truy cập vị trí'),
                content: const SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text(
                        'Vui lòng cho phép SBA truy cập vào vị trí của bạn!',
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Đồng ý'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                  TextButton(
                    child: const Text('Từ chối'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                ],
              );
            },
          );
          if (result == true) {
            return Future.value(GeolocationPermissionShowPromptResponse(
                origin: origin, allow: true, retain: true));
          } else {
            return Future.value(GeolocationPermissionShowPromptResponse(
                origin: origin, allow: false, retain: false));
          }
        },
        onLoadStop: (context, uri) {},
      ),
    );
  }
}
