import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../core/theme/theme_controller.dart';
import '../../core/utils/preferences_service.dart';

class SettingsController extends GetxController {
  final ThemeController themeController;
  final PreferencesService _preferencesService;

  var currentLanguage = 'en'.obs;

  SettingsController({
    required this.themeController,
    required PreferencesService preferencesService,
  }) : _preferencesService = preferencesService;

  @override
  void onInit() {
    super.onInit();
    loadSavedLanguage();
  }

  Future<void> loadSavedLanguage() async {
    final savedLanguage = await _preferencesService.getLanguage();
    currentLanguage.value = savedLanguage;
  }

  Future<void> changeLanguage(String languageCode) async {
    await _preferencesService.saveLanguage(languageCode);
    currentLanguage.value = languageCode;
    Get.updateLocale(Locale(languageCode));
  }

  Future<String> loadLanguage() async {
    return await _preferencesService.getLanguage();
  }

  void toggleTheme() {
    themeController.toggleTheme();
  }
}
