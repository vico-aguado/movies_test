import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_test/app/core/localization/supported_locales.dart';

void main() {
  group('SupportedLocales Test', () {
    test('should have the correct supported locales', () {
      expect(
        SupportedLocales.all,
        equals([const Locale('en', 'US'), const Locale('es', 'ES')]),
      );
    });

    test('should not be empty', () {
      expect(SupportedLocales.all.isEmpty, isFalse);
    });

    test('should contain English locale', () {
      expect(SupportedLocales.all.contains(const Locale('en', 'US')), isTrue);
    });

    test('should contain Spanish locale', () {
      expect(SupportedLocales.all.contains(const Locale('es', 'ES')), isTrue);
    });
  });
}
