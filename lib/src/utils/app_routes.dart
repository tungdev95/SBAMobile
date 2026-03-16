import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:sba/pages/splash/page_splash.dart';
// import 'package:sba/pages/splash/page_splash_uat.dart';

import 'custom_route_builder.dart';

class AppRoutes {
  static dynamic showPopup(BuildContext context, Widget page) async {
    return Navigator.of(context)
        .push(TransparentRoute(builder: (context) => page));
  }

  static dynamic showBottomPopup(BuildContext context, Widget page) async {
    return Navigator.of(context)
        .push(BottomPopupRoute(builder: (context) => page));
  }

  static dynamic push(BuildContext context, Widget page, {String? name}) {
    return Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) => page,
        settings: name != null ? RouteSettings(name: name) : null));
  }

  static dynamic pushReplacement(BuildContext context, Widget page,
      {String? name}) async {
    return Navigator.of(context).pushReplacement(CupertinoPageRoute(
        builder: (context) => page,
        settings: name != null ? RouteSettings(name: name) : null));
  }

  static dynamic showDiaglog(BuildContext context, Widget diaglog,
      {bool dismissible = true}) async {
    return showDialog(
        context: context,
        barrierDismissible: dismissible,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => dismissible,
            child: diaglog,
          );
        });
  }

  static dynamic popUntilCustom(BuildContext context, String page) async {
    return Navigator.popUntil(context, ModalRoute.withName(page));
  }
}
