import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/preferences_service.dart';

class ThemeController extends GetxController {
  final isDarkMode = false.obs;

  final PreferencesService _preferencesService;

  ThemeController({required PreferencesService preferencesService})
      : _preferencesService = preferencesService;

  ThemeMode get themeMode =>
      isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  @override
  void onInit() {
    super.onInit();
    loadTheme();
  }

  Future<void> loadTheme() async {
    final savedTheme = await _preferencesService.getTheme();
    isDarkMode.value = savedTheme;
    Get.changeThemeMode(themeMode);
  }

  Future<void> toggleTheme() async {
    isDarkMode.value = !isDarkMode.value;
    await _preferencesService.saveTheme(isDarkMode.value);
    Get.changeThemeMode(themeMode);
  }
}
