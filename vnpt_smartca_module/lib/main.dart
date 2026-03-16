// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures

import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scale_size/scale_size.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:vnpt_smartca_module/views/widgets/navigator_helper.dart';

import 'app_wrapper.dart';
import 'configs/app_config.dart';
import 'configs/injector/injector.dart';
import 'core/models/app/smartca_message_result.dart';
import 'core/utils/constants.dart';
import 'core/utils/language_enums.dart';
import 'gen/assets.gen.dart';
import 'method_channel_handler.dart';
import 'views/bindings/app.bindings.dart';
import 'views/controller/app_controller.dart';
import 'views/i18n/generated_locales/l10n.dart';
import 'views/routes/app_pages.dart';

main() async {
  // Errors not caught by Flutter
  runZonedGuarded(() async {
    await bootstrapSmartCAApp();
  }, (Object error, StackTrace stack) {
    debugPrint("error log ${error}");
    debugPrint("error log ${stack}");
  });
}

bootstrapSmartCAApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Errors caught by Flutter
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
  };

  final MethodChannelHandler methodChannelHandler = MethodChannelHandler();

  /// Call về app tích hợp khi app đã load xong
  methodChannelHandler.send(
    method: MethodChannelNames.isReady,
    data: SmartCaResult(ResultCode.SUCCESS_CODE, ResultCodeDesc.SUCCESS),
  );
  print("AppConfig.package la: ${AppConfig.package}");

  /// Khi có sự kiện configure thì mới tiến hành khởi tạo app
  methodChannelHandler.listen(
      method: MethodChannelNames.configure,
      listener: (event) async {
        final param = jsonDecode(event);
        print("Param la: $param");

        AppConfig.environment = (param['env'] as int) == PROD_ENV
            ? Environment.prod
            : Environment.dev;

        AppConfig.language = (param['lang'] as String) == AppLanguage.en
            ? AppLanguage.en
            : AppLanguage.vi;

        AppConfig.isFlutter = param['isFlutter'] ?? true;

        if ((param['clientId'] != null && param['clientId'] != "") ||
            (param['clientSecret'] != null && param['clientSecret'] != "")) {
          AppConfig.clientId = param['clientId'] ?? '';
          AppConfig.clientSecret = param['clientSecret'] ?? '';
        } else {
          throw Exception("ClientId and ClientSecret must assign value");
        }

        var customParams = param['customParams'];
        if (customParams != null) {
          if (customParams['colorPrimaryBtn'] != null &&
              customParams['colorPrimaryBtn'] != "") {
            AppConfig.colorPrimaryBtn = customParams['colorPrimaryBtn'];
          }

          if (customParams['logoCustom'] != null &&
              customParams['logoCustom'] != "") {
            AppConfig.logoCustom = customParams['logoCustom'];
            AppConfig.sizeLogo = 94;
          } else {
            AppConfig.sizeLogo = 118;
          }

          if (customParams['backgroundLogin'] != null &&
              customParams['backgroundLogin'] != "") {
            AppConfig.backgroundLogin = customParams['backgroundLogin'];
          }

          if (customParams['featuresLink'] != null &&
              customParams['featuresLink'] != "") {
            AppConfig.featuresLink = customParams['featuresLink'];
          }

          if (customParams['customerId'] != null &&
              customParams['customerId'] != "") {
            AppConfig.customerId = customParams['customerId'];
          }

          if (customParams['borderRadiusBtn'] != null) {
            AppConfig.borderRadiusBtn =
                double.parse(customParams['borderRadiusBtn'].toString());
          }

          if (customParams['colorSecondBtn'] != null &&
              customParams['colorSecondBtn'] != "") {
            AppConfig.colorSecondBtn = customParams['colorSecondBtn'];
          }

          if (customParams['customerPhone'] != null &&
              customParams['customerPhone'] != "") {
            AppConfig.customerPhone = customParams['customerPhone'];
          }

          if (customParams['customerEmail'] != null &&
              customParams['customerEmail'] != "") {
            AppConfig.customerEmail = customParams['customerEmail'];
          }

          if (customParams['packageDefault'] != null &&
              customParams['packageDefault'] != "") {
            AppConfig.packageDefault = customParams['packageDefault'];
          }

          if (customParams['password'] != null &&
              customParams['password'] != "") {
            AppConfig.password = customParams['password'];
          }
        }

        // Cấu hình các thành phần phụ thuộc
        await configureDependencies(AppConfig.environment);
        // PushNotificationManager.instance.initFirebase();

        // /// Cấu hình status bar
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
        ));

        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitDown,
          DeviceOrientation.portraitUp,
        ]);

        runApp(
          Material(
            color: Colors.transparent,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                GetMaterialApp(
                  // color: Colors.white,
                  home: Builder(builder: (context) {
                    ScaleSize.init(context, designWidth: 375);
                    return Stack(
                      children: [
                        Scaffold(
                          resizeToAvoidBottomInset: true,
                          // backgroundColor: Colors.white,
                          body: Stack(
                            children: [
                              AppWrapper(),
                              if (AppConfig.environment == Environment.dev)
                                const Banner(
                                  message: 'Demo',
                                  location: BannerLocation.topStart,
                                  color: Colors.red,
                                ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                  builder: (BuildContext context, Widget? child) {
                    double textScaleFactor =
                        MediaQuery.of(context).textScaleFactor;

                    if (textScaleFactor >= 1.2)
                      textScaleFactor = 1.08;
                    else if (textScaleFactor >= 1.1)
                      textScaleFactor = 1.06;
                    else
                      textScaleFactor = 1;

                    return MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(textScaleFactor: textScaleFactor),
                      child: child!,
                    );
                  },
                  // khởi tạo các controller, thành phần phụ thuộc khác
                  initialBinding: AppBinding(),
                  themeMode: ThemeMode.light,
                  theme: ThemeData(
                    fontFamily: AppConfig.fontFamily,
                    appBarTheme: const AppBarTheme(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    useMaterial3: false,
                  ),
                  debugShowCheckedModeBanner: false,
                  defaultTransition: Transition.noTransition,
                  locale: Locale(AppConfig.language),
                  localizationsDelegates: const [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    AppLocalizations.delegate,
                    FormBuilderLocalizations.delegate,
                  ],
                  supportedLocales: AppLocalizations.delegate.supportedLocales,
                  getPages: AppPages.routes,
                ),
                Builder(builder: (context) {
                  ScaleSize.init(context, designWidth: 375);
                  return GestureDetector(
                    onTap: () {
                      if (Get.context != null) {
                        try {
                          final currentHostAppMethod = Get.find<AppController>()
                              .currentHostAppMethod
                              .value;
                          if (currentHostAppMethod.isNotEmpty)
                            methodChannelHandler.send(
                                method: "${currentHostAppMethod}Result",
                                data: SmartCaResult.userCancel());
                        } catch (e, s) {}

                        Navigator.popUntil(
                            Get.context!, (route) => route.isFirst);
                        NavigatorHandler.closeSDK();
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 0.6.top),
                      padding: EdgeInsets.only(right: 10),
                      height: kToolbarHeight,
                      width: 50,
                      alignment: Alignment.centerRight,
                      child: Assets.images.close.svg(width: 30, height: 30),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      });
}
