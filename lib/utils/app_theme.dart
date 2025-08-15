import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_styles.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
      hoverColor: AppColors.blackColor,
      primaryColor: AppColors.whiteColor,
      indicatorColor: AppColors.blackColor,
      scaffoldBackgroundColor: AppColors.whiteColor,
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.whiteColor,
          iconTheme: IconThemeData(color: AppColors.blackColor),
          centerTitle: true),
      textTheme: TextTheme(
          labelLarge: AppStyles.bold16Black,
          labelSmall: AppStyles.medium12Gray,
          labelMedium: AppStyles.medium14Black,
          headlineMedium: AppStyles.medium24Black,
          headlineLarge: AppStyles.medium20Black)
  );
  static final ThemeData darkTheme = ThemeData(
      hoverColor: AppColors.whiteColor,
      primaryColor: AppColors.blackColor,
      indicatorColor: AppColors.whiteColor,
      scaffoldBackgroundColor: AppColors.blackColor,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: AppColors.blackColor,
        iconTheme: IconThemeData(color: AppColors.whiteColor),
      ), // AppBarTheme
      textTheme: TextTheme(
          labelLarge: AppStyles.bold16White,
          labelMedium: AppStyles.medium14White,
          labelSmall: AppStyles.medium12Gray,
          headlineMedium: AppStyles.medium24White,
          headlineLarge: AppStyles.medium20White)
  ); // TextTheme, ThemeData
}