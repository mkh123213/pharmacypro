import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../services/shared_pref/pref_keys.dart';
import '../../services/shared_pref/shared_pref.dart';

part 'app_cubit.freezed.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState.initial());

  bool isDark = false;
  String currentLangCode = 'en';

  void getSavedThemeMode() {
    isDark = SharedPref().getBoolean(PrefKeys.themeMode) ?? false;
    emit(AppState.themeChangeMode(isDark: isDark));
  }

  Future<void> changeAppThemeMode({bool? sharedMode}) async {
    isDark = sharedMode ?? !isDark;
    await SharedPref().setBoolean(PrefKeys.themeMode, isDark);
    emit(AppState.themeChangeMode(isDark: isDark));
  }

  void getSavedLanguage() {
    currentLangCode = SharedPref().getString(PrefKeys.language) ?? 'en';
    emit(AppState.languageChange(locale: Locale(currentLangCode)));
  }

  Future<void> changeLanguage(String langCode) async {
    if (currentLangCode == langCode) return;

    await SharedPref().setString(PrefKeys.language, langCode);
    currentLangCode = langCode;
    emit(AppState.languageChange(locale: Locale(currentLangCode)));
  }

  Future<void> toggleLanguage() async {
    await changeLanguage(currentLangCode == 'ar' ? 'en' : 'ar');
  }

  Future<void> toArabic() async => changeLanguage('ar');

  Future<void> toEnglish() async => changeLanguage('en');
}
