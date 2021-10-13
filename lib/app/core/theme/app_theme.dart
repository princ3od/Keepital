import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keepital/app/core/values/app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: AppColors.primaryColor,
    primaryColorDark: AppColors.primaryColor,
    primaryColorLight: AppColors.primaryColor,
    backgroundColor: AppColors.lightBgColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.lightBgColor,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: AppColors.lightTextColor,
      unselectedItemColor:
          AppColors.lightTextColor.withOpacity(AppColors.disabledTextOpacity),
      selectedIconTheme: IconThemeData(color: AppColors.lightTextColor),
      unselectedIconTheme: IconThemeData(
          color: AppColors.lightTextColor,
          opacity: AppColors.disabledIconOpacity),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.primaryColor,
    ),
    textTheme: TextTheme(
      headline1: GoogleFonts.montserrat(
        color: AppColors.lightTextColor,
      ),
      headline2: GoogleFonts.montserrat(
        color: AppColors.lightTextColor,
      ),
      headline3: GoogleFonts.montserrat(
        color: AppColors.lightTextColor,
      ),
      headline4: GoogleFonts.montserrat(
        color: AppColors.lightTextColor,
      ),
      headline5: GoogleFonts.montserrat(
        color: AppColors.lightTextColor,
        fontWeight: FontWeight.bold,
      ),
      headline6: GoogleFonts.montserrat(
        color: AppColors.lightTextColor,
      ),
      subtitle1: GoogleFonts.montserrat(
        color: AppColors.lightTextColor,
      ),
      subtitle2: GoogleFonts.montserrat(
        color: AppColors.lightTextColor,
      ),
      bodyText1: GoogleFonts.montserrat(
        color: AppColors.lightTextColor,
      ),
      bodyText2: GoogleFonts.montserrat(
        color: AppColors.lightTextColor,
        fontWeight: FontWeight.bold,
      ),
      button: GoogleFonts.montserrat(
        color: AppColors.lightTextColor,
      ),
      caption: GoogleFonts.montserrat(
        color: AppColors.lightTextColor,
      ),
      overline: GoogleFonts.montserrat(
        color: AppColors.lightTextColor,
      ),
    ),
    iconTheme: IconThemeData(color: AppColors.secondaryColor),
    appBarTheme: AppBarTheme(color: AppColors.primaryColor),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: AppColors.primaryColor,
    primaryColorDark: AppColors.primaryColor,
    primaryColorLight: AppColors.primaryColor,
    backgroundColor: AppColors.darkBgColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkBgColor,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: AppColors.darkTextColor,
      unselectedItemColor:
          AppColors.darkTextColor.withOpacity(AppColors.disabledTextOpacity),
      selectedIconTheme: IconThemeData(color: AppColors.darkTextColor),
      unselectedIconTheme: IconThemeData(
          color: AppColors.darkTextColor,
          opacity: AppColors.disabledIconOpacity),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.primaryColor,
    ),
    textTheme: TextTheme(
      headline1: GoogleFonts.montserrat(
        color: AppColors.darkTextColor,
      ),
      headline2: GoogleFonts.montserrat(
        color: AppColors.darkTextColor,
      ),
      headline3: GoogleFonts.montserrat(
        color: AppColors.darkTextColor,
      ),
      headline4: GoogleFonts.montserrat(
        color: AppColors.darkTextColor,
      ),
      headline5: GoogleFonts.montserrat(
        color: AppColors.darkTextColor,
        fontWeight: FontWeight.bold,
      ),
      headline6: GoogleFonts.montserrat(
        color: AppColors.darkTextColor,
      ),
      subtitle1: GoogleFonts.montserrat(
        color: AppColors.darkTextColor,
      ),
      subtitle2: GoogleFonts.montserrat(
        color: AppColors.darkTextColor,
      ),
      bodyText1: GoogleFonts.montserrat(
        color: AppColors.darkTextColor,
      ),
      bodyText2: GoogleFonts.montserrat(
        color: AppColors.darkTextColor,
        fontWeight: FontWeight.bold,
      ),
      button: GoogleFonts.montserrat(
        color: AppColors.darkTextColor,
      ),
      caption: GoogleFonts.montserrat(
        color: AppColors.darkTextColor,
      ),
      overline: GoogleFonts.montserrat(
        color: AppColors.darkTextColor,
      ),
    ),
    iconTheme: IconThemeData(color: AppColors.secondaryColor),
    appBarTheme: AppBarTheme(color: AppColors.darkBgColor),
  );
}