import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../core/theme/theme_controller.dart';

class SettingsController extends GetxController {
  final ThemeController themeController;

  SettingsController({required this.themeController});

  void changeLanguage(String languageCode) {
    Get.updateLocale(Locale(languageCode));
  }

  void toggleTheme() {
    themeController.toggleTheme();
  }
}
