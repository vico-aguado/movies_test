import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:get/get.dart';
import 'package:movies_test/app/core/services/preferences_service.dart';
import 'package:movies_test/app/core/theme/theme_controller.dart';
import 'package:movies_test/app/presentation/controllers/settings_controller.dart';
import 'settings_controller_test.mocks.dart';

@GenerateMocks([PreferencesService, ThemeController])
void main() {
  late SettingsController controller;
  late MockPreferencesService mockPreferencesService;
  late MockThemeController mockThemeController;

  setUp(() {
    mockPreferencesService = MockPreferencesService();
    mockThemeController = MockThemeController();
    controller = SettingsController(
      themeController: mockThemeController,
      preferencesService: mockPreferencesService,
    );
  });

  group('SettingsController Tests', () {
    test('onInit calls loadSavedLanguage', () async {
      // Arrange
      when(mockPreferencesService.getLanguage()).thenAnswer((_) async => 'en');

      // Act
      controller.onInit();

      // Assert
      expect(controller.currentLanguage.value, 'en');
      verify(mockPreferencesService.getLanguage()).called(1);
    });

    test('loadSavedLanguage updates currentLanguage with saved language',
        () async {
      // Arrange
      when(mockPreferencesService.getLanguage()).thenAnswer((_) async => 'es');

      // Act
      await controller.loadSavedLanguage();

      // Assert
      expect(controller.currentLanguage.value, 'es');
      verify(mockPreferencesService.getLanguage()).called(1);
    });

    test('changeLanguage updates language and locale', () async {
      // Arrange
      when(mockPreferencesService.saveLanguage('es')).thenAnswer((_) async {});

      // Act
      await controller.changeLanguage('es');

      // Assert
      expect(controller.currentLanguage.value, 'es');
      verify(mockPreferencesService.saveLanguage('es')).called(1);
      expect(Get.locale?.languageCode, 'es');
    });

    test('loadLanguage retrieves saved language', () async {
      // Arrange
      when(mockPreferencesService.getLanguage()).thenAnswer((_) async => 'fr');

      // Act
      final result = await controller.loadLanguage();

      // Assert
      expect(result, 'fr');
      verify(mockPreferencesService.getLanguage()).called(1);
    });

    test('toggleTheme calls themeController.toggleTheme', () {
      // Act
      controller.toggleTheme();

      // Assert
      verify(mockThemeController.toggleTheme()).called(1);
    });
  });
}
