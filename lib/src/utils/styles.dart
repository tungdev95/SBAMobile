/*
 * Copyright 2018 Eric Windmill. All rights reserved.
 * Use of this source code is governed by the MIT license that can be found in the LICENSE file.
 */

import 'package:flutter/material.dart';

class Spacing {
  static const double _matGridUnit = 10.0;

  static double value({scale = 1}) {
    return _matGridUnit * scale;
  }

  static const double padding = 13.0;
  static const double navigationBarHeight = 44.0;
  static const double margin_horizontal = 16.0;
}

class AppStyle {
  static ColorScheme lightTheme = const ColorScheme.light(
      primary: AppColor.primaryColor,
      secondary: AppColor.secondaryColor,
      surface: Color(0xFFFFFFFF),
      background: AppColor.backgroundColor,
      error: Color(0xFFB00020),
      onPrimary: Color(0xFFFFFFFF),
      onSecondary: Color(0xFFFFFFFF),
      onSurface: Color(0xFF000000),
      onBackground: Color(0xFF000000),
      onError: Color(0xFFFD9726),
      brightness: Brightness.light);
}

extension AppColor on Color {
  static Color fromHex(String strHex) {
    strHex = strHex.replaceAll("#", "");
    if (strHex.length == 6) {
      return Color(int.parse("0xFF$strHex"));
    } else if (strHex.length == 8) {
      return Color(int.parse("0x$strHex"));
    } else {
      return Colors.black;
    }
  }
  //199,207,240

  //Define color for app
  static const Color primaryColor = Color(0xFFc7cff0);
  static const Color secondaryColor = Color(0XFF111dc9);
  static const Color tertiaryColor = Color(0xFFF26126);
  static const Color fourthColor = Color(0xFFe7f1d7);
  static const Color cancelColor = Color(0xFFF26226);
  static const Color closeColor = Color(0xFF9c9c9c);
  static const Color backgroundColor = Color(0xFFedefee);
  static const Color calendarEventColor = Color(0xFFf6d6c9);
  static const Color calendarSelectedColor = Color(0xFF2C7438);

  static const Color primaryTextColor = Color(0xFF3F3F3F);
  static const Color secondaryTextColor = Color(0xFF9c9c9c);
  static const Color tertiaryTextColor = Color(0xFF717171);
  static const Color fourthTextColor = Color(0xFF9c9c9c);
  static const Color disableColor = Color.fromARGB(255, 245, 245, 245);
  static const Color dividerColor = Color(0xFFE0E0E0);
  static const Color headerBackgroundColor = Color(0xFFd1d1d1);
  static const Color redColor = Colors.redAccent;

  static const Color cornflowerBlue = Color(0xFF6069FF);
  static const Color amaranth = Color(0xFFEB2C4B);
  static const Color downriverapprox = Color(0xFF091D43);

  static const Color tabTopColor = Color(0xFF1b4d24);
  static const Color tabColor = Color(0xFF2C7438);
  static const Color tabbarItemColor = Color(0xFF707070);
  static const Color eastBay = Color(0xFF3F547B);

  static const LinearGradient defaultAppbarGradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [AppColor.primaryColor, Color(0xFF007CB9), Color(0xff00B4D8)]);

  static const boxShadowDefault = [
    BoxShadow(
      color: Colors.black12,
      offset: Offset(0.0, 3.0),
      blurRadius: 8,
    )
  ];

  //Colos/Typo/White/Text Sub
  static const Color colorBlackTypoSub = Color.fromARGB(102, 255, 255, 255);
  static const Color colorBlackTextSub = Color.fromARGB(102, 0, 0, 0);
}
