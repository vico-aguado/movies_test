import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class LocalizationDelegate {
  static const Locale defaultLocale = Locale('en', 'US');
  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('es', 'ES'),
  ];

  static const delegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
}
