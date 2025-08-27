// import 'dart:ui';

// import 'package:sba/models/base/language.dart';
// import 'package:sba/src/utils/styles.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AppConfig  {
//   LanguageModel? appLocale;
//   Locale? locale;
//   ColorScheme? colorScheme;
//   Locale? _deviceLocale;

//   Locale? get deviceLocale => _deviceLocale;

//   set deviceLocale(Locale? locale) {
//     _deviceLocale ??= locale;
//   }

//   AppConfig({this.locale, this.appLocale, this.colorScheme});

//   AppConfig copyWith(
//       {Locale? locale, LanguageModel? appLocale, ColorScheme? colorScheme}) {
//     var currentLang = (locale ?? this.locale)?.languageCode == "vi"
//         ? LanguageModel.initViLanguage()
//         : LanguageModel.initEngLanguage();
//     return AppConfig(
//         locale: locale ?? this.locale,
//         appLocale: currentLang,
//         colorScheme: colorScheme ?? this.colorScheme);
//   }

//   Future init() async {
//     ColorScheme currentColor = AppStyle.lightTheme;
//     this.colorScheme = currentColor;
//     // var share = await SharedPreferences.getInstance();
//     var languageCode = /*share.getString(AppConstants.LANGUAGE_CODE) ?? */"vi";
//     Locale currentLocale = Locale(languageCode);
//     this.locale = currentLocale;
//     var currentLang = this.locale?.languageCode == "en"
//         ? LanguageModel(code: "en")
//         : LanguageModel(code: "vi");
//     this.appLocale = currentLang;
//   }
// }
