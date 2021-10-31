import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/theme/app_theme.dart';
import 'package:keepital/app/data/services/app_start_service.dart';
import 'package:keepital/app/data/services/theme_service.dart';
import 'package:keepital/app/routes/pages.dart';

import 'app/data/services/localization_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppStartService.instance.initGetStorage();
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
      initialRoute: Routes.addTransaction,
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
      debugShowCheckedModeBanner: false,
      getPages: AppPages.pages,
    );
  }
}
