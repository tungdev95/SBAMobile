import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sba/generated/l10n.dart';
import 'package:sba/src/screens/base/base_page.dart';
import 'package:sba/src/screens/map/controller/zoning_map_page_controller.dart';
import 'package:sba/src/screens/map/states/map_state.dart';

final zoningDataProvider = Provider<MapPageData>((ref) {
  throw UnimplementedError();
});

class ZoningMapPage extends BasePage<ZoningMapPageController, MapPageData> {
  const ZoningMapPage({super.key});

  @override
  String get title => S.current.quy_hoach;

  @override
  Widget bodyWidget(BuildContext context, WidgetRef ref, MapPageData state) {
    return RepaintBoundary(
      key: ref.read(provider(ref).notifier).mapKey,
      child: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse('https://map.ekgis.vn')),
        onWebViewCreated: (controller) {
          ref.read(provider(ref).notifier).controller = controller;
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
        onLoadStop: (context, uri) {
          ref.read(provider(ref).notifier).removeInfoView();
        },
      ),
    );
  }

  @override
  AutoDisposeStateNotifierProvider<ZoningMapPageController, MapPageData>
      provider(WidgetRef ref) {
    return ZoningMapPageController.zoningMapControllerProvider(
        ref.read(zoningDataProvider));
  }

  @override
  List<Widget>? actionWidget(BuildContext context, WidgetRef ref) {
    return [
      IconButton(
        icon: const Icon(
          Icons.save,
          color: Colors.white,
        ),
        onPressed: () async {
          ref.read(provider(ref).notifier).screenShoot();
        },
      )
    ];
  }
}
