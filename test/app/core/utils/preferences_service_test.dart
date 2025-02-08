import 'package:flutter_test/flutter_test.dart';
import 'package:movies_test/app/core/services/preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('PreferencesService Tests', () {
    late PreferencesService preferencesService;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      preferencesService = PreferencesService();
    });

    test('saveTheme and getTheme works correctly', () async {
      await preferencesService.saveTheme(true);
      expect(await preferencesService.getTheme(), true);

      await preferencesService.saveTheme(false);
      expect(await preferencesService.getTheme(), false);
    });

    test('getTheme returns false when no value is saved', () async {
      expect(await preferencesService.getTheme(), false);
    });

    test('saveLanguage and getLanguage works correctly', () async {
      await preferencesService.saveLanguage('es');
      expect(await preferencesService.getLanguage(), 'es');

      await preferencesService.saveLanguage('fr');
      expect(await preferencesService.getLanguage(), 'fr');
    });

    test('getLanguage returns "en" when no value is saved', () async {
      expect(await preferencesService.getLanguage(), 'en');
    });
  });
}
