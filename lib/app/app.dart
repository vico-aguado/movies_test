import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/localization/app_localizations.dart';
import 'core/localization/localization_delegate.dart';
import 'core/localization/supported_locales.dart';
import 'presentation/routes/app_pages.dart';
import 'presentation/routes/app_routes.dart';
import 'core/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  final bool isDarkMode;
  final String languageCode;

  const MyApp({
    super.key,
    required this.isDarkMode,
    required this.languageCode,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Movie App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      locale: Locale(languageCode),
      fallbackLocale: LocalizationDelegate.defaultLocale,
      translations: AppLocalizations(),
      supportedLocales: SupportedLocales.all,
      localizationsDelegates: LocalizationDelegate.delegates,
      initialRoute: AppRoutes.home,
      getPages: AppPages.routes,
    );
  }
}
