// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'styles/app_colors.dart';

ThemeData mainTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: TextTheme(
    displayLarge: TextStyle(
      height: 1.2,
      color: AppColors.black,
      fontSize: Get.width <= 667 ? 17 : 18,
      fontWeight: FontWeight.w700,
    ),
    titleMedium: TextStyle(
      height: 1.2,
      color: AppColors.black,
      fontSize: Get.width <= 667 ? 13 : 14,
    ),
    bodyLarge: TextStyle(
      fontSize: Get.width <= 667 ? 16 : 17,
      color: AppColors.black,
      height: 1.2,
      fontWeight: FontWeight.w700,
    ),
    bodyMedium: TextStyle(
      fontSize: Get.width <= 667 ? 15 : 16,
      // color: AppColors.hintColor,
      height: 1.2,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      height: 1.2,
      color: AppColors.black,
      fontSize: Get.width <= 667 ? 12 : 13,
    ),
    labelLarge: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: Get.width <= 667 ? 14 : 15,
      letterSpacing: 2,
    ),
    titleLarge: TextStyle(
      fontSize: Get.width <= 667 ? 18 : 20,
      height: 1.3,
      color: Colors.white,
      fontWeight: FontWeight.w700,
    ),
  ), colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: Colors.cyan[600],
    primary: Colors.blue,
    surface: Colors.white,
  ),
);
