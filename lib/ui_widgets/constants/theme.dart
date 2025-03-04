import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

class AppTheme {
  AppTheme._();

  static ThemeData _baseTheme(BuildContext context) => ThemeData(
        primaryColor: AppColors.appPrimaryColor,
        indicatorColor: AppColors.appPrimaryColor,
        scaffoldBackgroundColor: AppColors.scaffold,
        textTheme: TextTheme(
          headlineLarge: const TextStyle(
            fontSize: 32,
            color: AppColors.black,
            fontWeight: FontWeight.w700,
          ),
          headlineMedium: const TextStyle(
            fontSize: 20,
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
          headlineSmall: const TextStyle(
            fontSize: 24,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
          titleMedium: const TextStyle(
            fontSize: 18,
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
          bodyMedium: const TextStyle(
            fontSize: 16,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
          bodySmall: TextStyle(
            fontSize: 14,
            color: AppColors.black,
            fontWeight: FontWeight.w400,
            fontFamily: GoogleFonts.inter().fontFamily,
            letterSpacing: 0.2,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(
              vertical: Insets.dim_8,
              horizontal: Insets.dim_12,
            ),
            shadowColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: Corners.xsBorder,
            ),
            backgroundColor: AppColors.appPrimaryColor,
            foregroundColor: Colors.white,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.scaffold,
          selectedItemColor: AppColors.appPrimaryColor,
          unselectedItemColor: AppColors.grey,
          type: BottomNavigationBarType.fixed,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.appPrimaryColor,
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconColor: WidgetStateProperty.all<Color>(
              AppColors.appPrimaryColor,
            ),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Insets.dim_10),
              ),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Insets.dim_10),
              ),
            ),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.appPrimaryColor,
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: AppColors.scaffold,
          elevation: 0,
          centerTitle: false,
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: AppColors.appPrimaryColor,
          textTheme: ButtonTextTheme.accent,
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            vertical: Insets.dim_8,
            horizontal: Insets.dim_10,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.borderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Insets.dim_6),
            borderSide: BorderSide(
              color: AppColors.borderColor,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.borderErrorColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Insets.dim_6),
            borderSide: const BorderSide(
              color: AppColors.grey,
            ),
          ),
          labelStyle: const TextStyle(color: AppColors.black),
          hintStyle: TextStyle(
            color: AppColors.borderColor,
            fontFamily: GoogleFonts.inter().fontFamily,
          ),
        ),
      );

  static ThemeData defaultTheme(BuildContext context) =>
      _baseTheme(context).copyWith(
        brightness: Brightness.light,
        textTheme: GoogleFonts.interTextTheme(_baseTheme(context).textTheme),
      );
}
