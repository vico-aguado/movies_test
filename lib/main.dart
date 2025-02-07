import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/app.dart';
import 'app/core/utils/preferences_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferencesService = PreferencesService();

  final isDarkMode = await preferencesService.getTheme();
  final languageCode = await preferencesService.getLanguage();

  Get.put(preferencesService);

  runApp(MyApp(
    isDarkMode: isDarkMode,
    languageCode: languageCode,
  ));
}
