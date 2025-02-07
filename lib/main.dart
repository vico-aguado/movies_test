import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app/app.dart';
import 'app/core/utils/preferences_service.dart';

void main() async {
  await dotenv.load(fileName: ".env");

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
