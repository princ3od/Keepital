import 'package:flutter/material.dart';
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

  static TextTheme _textTheme(Color textColor) => TextTheme(
        headline1: GoogleFonts.montserrat(
          color: textColor,
          fontSize: 14,
          fontWeight: FontWeight.w600
        ),
        headline2: GoogleFonts.montserrat(
          color: textColor,
        ),
        headline3: GoogleFonts.montserrat(
          color: textColor,
        ),
        headline4: GoogleFonts.montserrat(
          color: textColor,
        ),
        headline5: GoogleFonts.montserrat(
          color: textColor,
        ),
        headline6: GoogleFonts.montserrat(
          color: textColor,
        ),
        subtitle1: GoogleFonts.montserrat(
          color: textColor,
        ),
        subtitle2: GoogleFonts.montserrat(
          color: textColor,
        ),
        bodyText1: GoogleFonts.montserrat(
          color: textColor,
        ),
        bodyText2: GoogleFonts.montserrat(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
        button: GoogleFonts.montserrat(
          color: textColor,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          wordSpacing: 1.5,
        ),
        caption: GoogleFonts.montserrat(
          color: textColor,
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
      ),
      elevation: 1,
    ),
    elevatedButtonTheme: _elevatedButtonThemeData,
    textButtonTheme: _secondaryButtonThemeData,
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
    appBarTheme: AppBarTheme(
      color: AppColors.darkBackgroundColor,
      titleTextStyle: GoogleFonts.montserrat(
        color: AppColors.darkTextColor,
      ),
      elevation: 1,
    ),
    elevatedButtonTheme: _elevatedButtonThemeData,
    textButtonTheme: _secondaryButtonThemeData,
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
}
