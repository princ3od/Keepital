import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keepital/app/core/values/app_colors.dart';

class AppTheme {
  static final ElevatedButtonThemeData _elevatedButtonThemeData =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: AppColors.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
    ),
  );

  static final TextButtonThemeData _secondaryButtonThemeData =
      TextButtonThemeData(
          style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18))));

  static final OutlinedButtonThemeData _outlinedButtonDarkThemeData =
      OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              primary: Colors.white,
              side: BorderSide(color: Colors.white, width: 2),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)))));

  static final OutlinedButtonThemeData _outlinedButtonLightThemeData =
      OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              primary: AppColors.primaryColor,
              side: BorderSide(color: AppColors.primaryColor, width: 2),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)))));

  static TextTheme _textTheme(Color textColor) => TextTheme(
        headline1: GoogleFonts.montserrat(
          color: textColor,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        headline2: GoogleFonts.montserrat(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        headline3: GoogleFonts.montserrat(
          color: textColor,
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
        headline4: GoogleFonts.montserrat(
          color: textColor,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        headline5: GoogleFonts.montserrat(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        headline6: GoogleFonts.montserrat(
          color: textColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        subtitle1: GoogleFonts.montserrat(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.normal,
        ),
        subtitle2: GoogleFonts.montserrat(
          color: textColor.withOpacity(0.5),
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
        bodyText1: GoogleFonts.montserrat(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        bodyText2: GoogleFonts.montserrat(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        button: GoogleFonts.montserrat(
          color: textColor,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          wordSpacing: 1.5,
        ),
        caption: GoogleFonts.montserrat(
          color: textColor,
          fontSize: 14,
        ),
        overline: GoogleFonts.montserrat(
          color: textColor,
        ),
      );
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    colorScheme: ColorScheme.light().copyWith(
      primary: AppColors.primaryColor,
    ),
    appBarTheme: AppBarTheme(
      color: AppColors.lightBackgroundColor,
      titleTextStyle: GoogleFonts.montserrat(
        color: AppColors.lightTextColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      elevation: 1,
    ),
    elevatedButtonTheme: _elevatedButtonThemeData,
    textButtonTheme: _secondaryButtonThemeData,
    outlinedButtonTheme: _outlinedButtonLightThemeData,
    primaryColor: AppColors.primaryColor,
    primaryColorDark: AppColors.primaryColor,
    primaryColorLight: AppColors.primaryColor,
    backgroundColor: AppColors.lightBackgroundColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.lightBackgroundColor,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: AppColors.lightTextColor,
      unselectedItemColor:
          AppColors.lightTextColor.withOpacity(AppColors.disabledTextOpacity),
      selectedIconTheme:
          IconThemeData(color: AppColors.lightTextColor, opacity: 1),
      unselectedIconTheme: IconThemeData(
          color: AppColors.lightTextColor,
          opacity: AppColors.disabledIconOpacity),
      selectedLabelStyle: GoogleFonts.montserrat(
        fontSize: 10,
        fontWeight: FontWeight.normal,
      ),
      unselectedLabelStyle: GoogleFonts.montserrat(
        fontSize: 10,
        fontWeight: FontWeight.normal,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
    ),
    tabBarTheme: TabBarTheme(
      labelColor: AppColors.lightTextColor,
      unselectedLabelColor:
          AppColors.lightTextColor.withOpacity(AppColors.disabledTextOpacity),
      labelPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 12.0),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(width: 2.0, color: AppColors.lightTextColor),
      ),
    ),
    textTheme: _textTheme(AppColors.lightTextColor),
    iconTheme: IconThemeData(color: AppColors.lightTextColor),
    scaffoldBackgroundColor: AppColors.lightDeepBackgroundColor,
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    colorScheme: ColorScheme.dark().copyWith(
      primary: AppColors.primaryColor,
    ),
    appBarTheme: AppBarTheme(
      color: AppColors.darkBackgroundColor,
      titleTextStyle: GoogleFonts.montserrat(
        color: AppColors.darkTextColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      elevation: 1,
    ),
    elevatedButtonTheme: _elevatedButtonThemeData,
    textButtonTheme: _secondaryButtonThemeData,
    outlinedButtonTheme: _outlinedButtonDarkThemeData,
    primaryColor: AppColors.primaryColor,
    primaryColorDark: AppColors.primaryColor,
    primaryColorLight: AppColors.primaryColor,
    backgroundColor: AppColors.darkBackgroundColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkBackgroundColor,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: AppColors.darkTextColor,
      unselectedItemColor:
          AppColors.darkTextColor.withOpacity(AppColors.disabledTextOpacity),
      selectedIconTheme:
          IconThemeData(color: AppColors.darkTextColor, opacity: 1),
      unselectedIconTheme: IconThemeData(
          color: AppColors.darkTextColor,
          opacity: AppColors.disabledIconOpacity),
      selectedLabelStyle: GoogleFonts.montserrat(
        fontSize: 10,
        fontWeight: FontWeight.normal,
      ),
      unselectedLabelStyle: GoogleFonts.montserrat(
        fontSize: 10,
        fontWeight: FontWeight.normal,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
    ),
    tabBarTheme: TabBarTheme(
      labelColor: AppColors.darkTextColor,
      unselectedLabelColor:
          AppColors.darkTextColor.withOpacity(AppColors.disabledTextOpacity),
      labelPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 12.0),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(width: 2.0, color: AppColors.darkTextColor),
      ),
    ),
    textTheme: _textTheme(AppColors.darkTextColor),
    iconTheme: IconThemeData(color: AppColors.darkTextColor),
    scaffoldBackgroundColor: AppColors.darkDeepBackgroundColor,
  );
  static ThemeData currentTheme = (Get.isDarkMode ? darkTheme : lightTheme);
}
