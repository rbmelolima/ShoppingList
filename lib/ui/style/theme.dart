import 'package:flutter/material.dart';
import 'package:shoppinglist/ui/style/style.dart';

ThemeData defaultTheme() {
  return ThemeData(
    primaryColor: AppColors.primary,
    primaryColorDark: AppColors.primaryDark,
    primaryColorLight: AppColors.primaryLight,
    backgroundColor: AppColors.backgroundScaffold,
    scaffoldBackgroundColor: AppColors.backgroundScaffold,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textAppBar,
    ),
    textTheme: TextTheme(
      headline1: AppText.h1(AppColors.black01),
      headline2: AppText.h2(AppColors.black01),
      headline3: AppText.h3(AppColors.black01),
      headline4: AppText.h4(AppColors.black01),
      headline5: AppText.h5(AppColors.black01),
      bodyText1: AppText.p(AppColors.black03),
      button: AppText.btn(AppColors.black01),
    ),
    buttonTheme: const ButtonThemeData(
      height: 64,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 22),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
    ),
    chipTheme: ChipThemeData(
      labelStyle: AppText.chip(AppColors.black01),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 22),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color.fromRGBO(33, 33, 33, 0.05),
      hintStyle: AppText.input(
        const Color.fromRGBO(0, 0, 0, 0.6),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(
          color: Colors.transparent,
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: AppColors.primary,
          width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(
          color: Colors.transparent,
          width: 2,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(
          color: Colors.transparent,
          width: 2,
        ),
      ),
    ),
  );
}
