import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/localization/app_localizations.dart';
import 'core/localization/localization_delegate.dart';
import 'core/localization/supported_locales.dart';
import 'presentation/routes/app_pages.dart';
import 'presentation/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());

    return GetMaterialApp(
      title: 'Movie App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeController.themeMode,
      locale: LocalizationDelegate.defaultLocale,
      fallbackLocale: LocalizationDelegate.defaultLocale,
      translations: AppLocalizations(),
      supportedLocales: SupportedLocales.all,
      localizationsDelegates: LocalizationDelegate.delegates,
      initialRoute: AppRoutes.home,
      getPages: AppPages.routes,
    );
  }
}
