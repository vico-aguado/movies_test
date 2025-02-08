import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:movies_test/app/core/services/preferences_service.dart';
import 'package:movies_test/app/core/theme/theme_controller.dart';

class MockPreferencesService extends GetxService implements PreferencesService {
  bool savedTheme = false;

  @override
  Future<bool> getTheme() async => savedTheme;

  @override
  Future<void> saveTheme(bool isDarkMode) async {
    savedTheme = isDarkMode;
  }

  @override
  Future<String> getLanguage() async => 'en';

  @override
  Future<void> saveLanguage(String languageCode) async {}
}

void main() {
  late ThemeController themeController;
  late MockPreferencesService mockPreferencesService;

  setUp(() {
    mockPreferencesService = MockPreferencesService();
    themeController =
        ThemeController(preferencesService: mockPreferencesService);
  });

  test('initial theme mode should be light', () {
    expect(themeController.themeMode, equals(ThemeMode.light));
  });

  test('loadTheme should set dark mode if savedTheme is true', () async {
    mockPreferencesService.savedTheme = true;
    await themeController.loadTheme();
    expect(themeController.isDarkMode.value, isTrue);
    expect(themeController.themeMode, equals(ThemeMode.dark));
  });

  test('loadTheme should set light mode if savedTheme is false', () async {
    mockPreferencesService.savedTheme = false;
    await themeController.loadTheme();
    expect(themeController.isDarkMode.value, isFalse);
    expect(themeController.themeMode, equals(ThemeMode.light));
  });

  test('toggleTheme should switch from light to dark mode', () async {
    mockPreferencesService.savedTheme = false;
    await themeController.loadTheme();
    await themeController.toggleTheme();
    expect(themeController.isDarkMode.value, isTrue);
    expect(themeController.themeMode, equals(ThemeMode.dark));
  });

  test('toggleTheme should switch from dark to light mode', () async {
    mockPreferencesService.savedTheme = true;
    await themeController.loadTheme();
    await themeController.toggleTheme();
    expect(themeController.isDarkMode.value, isFalse);
    expect(themeController.themeMode, equals(ThemeMode.light));
  });

  test('toggleTheme should save the new theme preference', () async {
    mockPreferencesService.savedTheme = false;
    await themeController.loadTheme();
    await themeController.toggleTheme();
    expect(mockPreferencesService.savedTheme, isTrue);
  });

  test('onInit should call loadTheme and initialize theme', () async {
    mockPreferencesService.savedTheme = true;
    themeController.onInit();
    await Future.delayed(const Duration(milliseconds: 100));
    expect(themeController.isDarkMode.value, isTrue);
    expect(themeController.themeMode, equals(ThemeMode.dark));
  });
}
