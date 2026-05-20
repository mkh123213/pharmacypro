import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './app_localizations.dart';

class AppLocalizationsSetup {
  static const Iterable<Locale> supportedLocales = [Locale('en'), Locale('ar')];

  static const Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates =
      [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ];

  static Locale localeResolutionCallback(
    Locale? locale,
    Iterable<Locale>? supportedLocales,
  ) {
    final supported = supportedLocales ?? AppLocalizationsSetup.supportedLocales;

    if (locale == null) return supported.first;

    for (final supportedLocale in supported) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return supportedLocale;
      }
    }

    return supported.first;
  }
}
