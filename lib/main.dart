import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/theme/app_theme.dart';
import 'package:keepital/app/data/services/theme_service.dart';
import 'package:keepital/app/modules/home/screens/home_screen.dart';
import 'package:keepital/app/routes/pages.dart';

import 'app/data/services/localization_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Keepital',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeService.theme,
      initialRoute: Routes.walletBalance,
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
      debugShowCheckedModeBanner: false,
      getPages: AppPages.pages,
    );
  }
}
