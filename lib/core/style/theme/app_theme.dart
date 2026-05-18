import 'package:flutter/material.dart';
import 'package:pharmacypro/core/style/colors/colors_dark.dart';
import 'package:pharmacypro/core/style/colors/colors_light.dart';
import 'package:pharmacypro/core/style/fonts/font_family_helper.dart';
import 'package:pharmacypro/core/style/theme/assets_extension.dart';
import 'package:pharmacypro/core/style/theme/color_extension.dart';

ThemeData themeDark() {
  final fontFamily = FontFamilyHelper.geLocalozedFontFamily();

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ColorsDark.background,
    primaryColor: ColorsDark.primary,
    colorScheme: const ColorScheme.dark(
      primary: ColorsDark.primary,
      secondary: ColorsDark.info,
      surface: ColorsDark.surface,
      error: ColorsDark.error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: ColorsDark.textPrimary,
      onError: Colors.white,
    ),
    extensions: const <ThemeExtension<dynamic>>[MyColors.dark, MyAssets.dark],
    dividerColor: ColorsDark.divider,
    fontFamily: fontFamily,
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: ColorsDark.textPrimary,
        fontFamily: fontFamily,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: ColorsDark.textPrimary,
        fontFamily: fontFamily,
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: ColorsDark.textPrimary,
        fontFamily: fontFamily,
      ),
      headlineLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: ColorsDark.textPrimary,
        fontFamily: fontFamily,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: ColorsDark.textPrimary,
        fontFamily: fontFamily,
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: ColorsDark.textPrimary,
        fontFamily: fontFamily,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: ColorsDark.textPrimary,
        fontFamily: fontFamily,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: ColorsDark.textPrimary,
        fontFamily: fontFamily,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: ColorsDark.textPrimary,
        fontFamily: fontFamily,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: ColorsDark.textPrimary,
        fontFamily: fontFamily,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: ColorsDark.textPrimary,
        fontFamily: fontFamily,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: ColorsDark.textSecondary,
        fontFamily: fontFamily,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: ColorsDark.textPrimary,
        fontFamily: fontFamily,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: ColorsDark.textSecondary,
        fontFamily: fontFamily,
      ),
      labelSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: ColorsDark.textSecondary,
        fontFamily: fontFamily,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsDark.background,
      foregroundColor: ColorsDark.textPrimary,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: ColorsDark.textPrimary,
        fontFamily: fontFamily,
      ),
      iconTheme: const IconThemeData(color: ColorsDark.textPrimary),
    ),
    cardTheme: CardThemeData(
      color: ColorsDark.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: ColorsDark.border),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorsDark.surface,
      hintStyle: TextStyle(
        color: ColorsDark.textSecondary,
        fontFamily: fontFamily,
      ),
      labelStyle: TextStyle(
        color: ColorsDark.textSecondary,
        fontFamily: fontFamily,
      ),
      errorStyle: TextStyle(color: ColorsDark.error, fontFamily: fontFamily),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: ColorsDark.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: ColorsDark.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: ColorsDark.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: ColorsDark.error, width: 1.5),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsDark.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ColorsDark.primary,
        side: const BorderSide(color: ColorsDark.primary),
        textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ColorsDark.primary,
        textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily,
        ),
      ),
    ),
    iconTheme: const IconThemeData(color: ColorsDark.textPrimary),
  );
}

ThemeData themeLight() {
  final fontFamily = FontFamilyHelper.geLocalozedFontFamily();

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: ColorsLight.background,
    primaryColor: ColorsLight.primary,
    colorScheme: const ColorScheme.light(
      primary: ColorsLight.primary,
      secondary: ColorsLight.info,
      surface: ColorsLight.surface,
      error: ColorsLight.error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: ColorsLight.textPrimary,
      onError: Colors.white,
    ),
    extensions: const <ThemeExtension<dynamic>>[MyColors.light, MyAssets.light],
    dividerColor: ColorsLight.divider,
    fontFamily: fontFamily,
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: ColorsLight.textPrimary,
        fontFamily: fontFamily,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: ColorsLight.textPrimary,
        fontFamily: fontFamily,
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: ColorsLight.textPrimary,
        fontFamily: fontFamily,
      ),
      headlineLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: ColorsLight.textPrimary,
        fontFamily: fontFamily,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: ColorsLight.textPrimary,
        fontFamily: fontFamily,
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: ColorsLight.textPrimary,
        fontFamily: fontFamily,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: ColorsLight.textPrimary,
        fontFamily: fontFamily,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: ColorsLight.textPrimary,
        fontFamily: fontFamily,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: ColorsLight.textPrimary,
        fontFamily: fontFamily,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: ColorsLight.textPrimary,
        fontFamily: fontFamily,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: ColorsLight.textPrimary,
        fontFamily: fontFamily,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: ColorsLight.textSecondary,
        fontFamily: fontFamily,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: ColorsLight.textPrimary,
        fontFamily: fontFamily,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: ColorsLight.textSecondary,
        fontFamily: fontFamily,
      ),
      labelSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: ColorsLight.textSecondary,
        fontFamily: fontFamily,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsLight.background,
      foregroundColor: ColorsLight.textPrimary,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: ColorsLight.textPrimary,
        fontFamily: fontFamily,
      ),
      iconTheme: const IconThemeData(color: ColorsLight.textPrimary),
    ),
    cardTheme: CardThemeData(
      color: ColorsLight.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: ColorsLight.border),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorsLight.background,
      hintStyle: TextStyle(
        color: ColorsLight.textSecondary,
        fontFamily: fontFamily,
      ),
      labelStyle: TextStyle(
        color: ColorsLight.textSecondary,
        fontFamily: fontFamily,
      ),
      errorStyle: TextStyle(color: ColorsLight.error, fontFamily: fontFamily),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: ColorsLight.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: ColorsLight.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: ColorsLight.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: ColorsLight.error, width: 1.5),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsLight.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: ColorsLight.primary,
        side: const BorderSide(color: ColorsLight.primary),
        textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ColorsLight.primary,
        textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontFamily: fontFamily,
        ),
      ),
    ),
    iconTheme: const IconThemeData(color: ColorsLight.textPrimary),
  );
}
