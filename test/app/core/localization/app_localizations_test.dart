import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:movies_test/app/core/localization/app_localizations.dart';

void main() {
  group('AppLocalizations Test', () {
    late AppLocalizations appLocalizations;

    setUp(() {
      appLocalizations = AppLocalizations();
      Get.addTranslations(appLocalizations.keys);
    });

    test('should have the correct keys for English', () {
      final enKeys = appLocalizations.keys['en'];
      expect(enKeys, isNotNull, reason: 'English keys should not be null');
      expect(enKeys!['home'], equals('Home'));
      expect(enKeys['settings'], equals('Settings'));
      expect(enKeys['change_language'], equals('Change Language'));
      expect(enKeys['change_theme'], equals('Change Theme'));
      expect(enKeys['light_mode'], equals('Light Mode'));
      expect(enKeys['dark_mode'], equals('Dark Mode'));
      expect(enKeys['search'], equals('Search'));
      expect(enKeys['release_date'], equals('Release Date'));
      expect(enKeys['genres'], equals('Genres'));
    });

    test('should have the correct keys for Spanish', () {
      final esKeys = appLocalizations.keys['es'];
      expect(esKeys, isNotNull, reason: 'Spanish keys should not be null');
      expect(esKeys!['home'], equals('Inicio'));
      expect(esKeys['settings'], equals('Configuración'));
      expect(esKeys['change_language'], equals('Cambiar Idioma'));
      expect(esKeys['change_theme'], equals('Cambiar Tema'));
      expect(esKeys['light_mode'], equals('Modo Claro'));
      expect(esKeys['dark_mode'], equals('Modo Oscuro'));
      expect(esKeys['search'], equals('Buscar'));
      expect(esKeys['release_date'], equals('Fecha de Lanzamiento'));
      expect(esKeys['genres'], equals('Géneros'));
    });

    test('should have the same keys for all languages', () {
      final enKeys = appLocalizations.keys['en']!.keys;
      final esKeys = appLocalizations.keys['es']!.keys;

      expect(
        enKeys,
        equals(esKeys),
        reason: 'All languages should have the same set of keys',
      );
    });

    test('should return the correct translation using GetX', () {
      Get.updateLocale(const Locale('en', 'US'));
      expect('home'.tr, equals('Home'));
      expect('settings'.tr, equals('Settings'));

      Get.updateLocale(const Locale('es', 'ES'));
      expect('home'.tr, equals('Inicio'));
      expect('settings'.tr, equals('Configuración'));
    });
  });
}
