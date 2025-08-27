import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sba/src/screens/base/top_level_provider.dart';
import 'package:sba/src/screens/splash/splash_page.dart';
import 'package:sba/src/utils/utils.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'generated/l10n.dart';
import 'src/widgets/base/color_schemes.dart';
import 'package:bot_toast/bot_toast.dart';

class SBAApp extends ConsumerWidget {
  const SBAApp({Key? key}) : super(key: key);

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Intl.defaultLocale = 'vi_VN';
    final appData = ref.watch(appController.notifier);
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'SBA',
      locale: Locale(appData.language.code),
      themeMode: ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        checkboxTheme: CheckboxThemeData(
          checkColor:
              MaterialStateProperty.resolveWith((states) => Colors.white),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.resolveWith(
              (states) => const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
            ),
            padding: MaterialStateProperty.resolveWith(
              (states) => const EdgeInsets.symmetric(vertical: 16),
            ),
            backgroundColor: MaterialStateProperty.resolveWith(
              (states) => Colors.transparent,
            ),
            textStyle: MaterialStateProperty.resolveWith(
              (states) => Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
            ),
          ),
        ),
        buttonTheme: const ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          errorStyle: const TextStyle(backgroundColor: Colors.transparent),
          hintStyle: context.textTheme.bodyMedium?.copyWith(),
          filled: true,
          fillColor: Colors.white,
        ),
        dividerColor: AppColor.dividerColor,
        fontFamily: 'Averta',
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      builder: (context, child) {
        return Portal(
          child: _Unfocus(
            child: BotToastInit().call(context, child),
          ),
        );
      },
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    );
  }
}

class Logger extends ProviderObserver {
  const Logger();

  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {}

  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer container) {
    log('Disposed provider: "${provider.runtimeType}- "${provider.name ?? ''}""');
  }

  @override
  void didAddProvider(
      ProviderBase provider, Object? value, ProviderContainer container) {
    log('Added provider: "${provider.runtimeType} - "${provider.name ?? ''}"');
  }
}

class _Unfocus extends StatelessWidget {
  const _Unfocus({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // FocusManager.instance.primaryFocus?.unfocus();
        try {
          SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
        } catch (e) {}
      },
      child: child,
    );
  }
}
