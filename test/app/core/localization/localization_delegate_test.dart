import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_test/app/core/localization/localization_delegate.dart';

void main() {
  group('LocalizationDelegate Test', () {
    test('should have the correct default locale', () {
      expect(
          LocalizationDelegate.defaultLocale, equals(const Locale('en', 'US')));
    });

    test('should have the correct supported locales', () {
      expect(
        LocalizationDelegate.supportedLocales,
        equals([const Locale('en', 'US'), const Locale('es', 'ES')]),
      );
    });

    test('should include GlobalMaterialLocalizations delegate', () {
      expect(
        LocalizationDelegate.delegates
            .contains(GlobalMaterialLocalizations.delegate),
        isTrue,
      );
    });

    test('should include GlobalWidgetsLocalizations delegate', () {
      expect(
        LocalizationDelegate.delegates
            .contains(GlobalWidgetsLocalizations.delegate),
        isTrue,
      );
    });

    test('should include GlobalCupertinoLocalizations delegate', () {
      expect(
        LocalizationDelegate.delegates
            .contains(GlobalCupertinoLocalizations.delegate),
        isTrue,
      );
    });
  });
}
