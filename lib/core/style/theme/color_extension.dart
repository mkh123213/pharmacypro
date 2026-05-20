import 'package:flutter/material.dart';
import '../colors/colors_dark.dart';
import '../colors/colors_light.dart';

class MyColors extends ThemeExtension<MyColors> {
  const MyColors({
    required this.primary,
    required this.background,
    required this.surface,
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
    required this.divider,
    required this.sidebarBg,
    required this.sidebarActive,
    required this.success,
    required this.error,
    required this.warning,
    required this.info,
  });

  final Color primary;

  final Color background;
  final Color surface;

  final Color textPrimary;
  final Color textSecondary;

  final Color border;
  final Color divider;

  final Color sidebarBg;
  final Color sidebarActive;

  final Color success;
  final Color error;
  final Color warning;
  final Color info;

  @override
  ThemeExtension<MyColors> copyWith({
    Color? primary,
    Color? background,
    Color? surface,
    Color? textPrimary,
    Color? textSecondary,
    Color? border,
    Color? divider,
    Color? sidebarBg,
    Color? sidebarActive,
    Color? success,
    Color? error,
    Color? warning,
    Color? info,
  }) {
    return MyColors(
      primary: primary ?? this.primary,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      border: border ?? this.border,
      divider: divider ?? this.divider,
      sidebarBg: sidebarBg ?? this.sidebarBg,
      sidebarActive: sidebarActive ?? this.sidebarActive,
      success: success ?? this.success,
      error: error ?? this.error,
      warning: warning ?? this.warning,
      info: info ?? this.info,
    );
  }

  @override
  ThemeExtension<MyColors> lerp(
    covariant ThemeExtension<MyColors>? other,
    double t,
  ) {
    if (other is! MyColors) {
      return this;
    }

    return MyColors(
      primary: Color.lerp(primary, other.primary, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      border: Color.lerp(border, other.border, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      sidebarBg: Color.lerp(sidebarBg, other.sidebarBg, t)!,
      sidebarActive: Color.lerp(sidebarActive, other.sidebarActive, t)!,
      success: Color.lerp(success, other.success, t)!,
      error: Color.lerp(error, other.error, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      info: Color.lerp(info, other.info, t)!,
    );
  }

  static const MyColors light = MyColors(
    primary: ColorsLight.primary,
    background: ColorsLight.background,
    surface: ColorsLight.surface,
    textPrimary: ColorsLight.textPrimary,
    textSecondary: ColorsLight.textSecondary,
    border: ColorsLight.border,
    divider: ColorsLight.divider,
    sidebarBg: ColorsLight.sidebarBg,
    sidebarActive: ColorsLight.sidebarActive,
    success: ColorsLight.success,
    error: ColorsLight.error,
    warning: ColorsLight.warning,
    info: ColorsLight.info,
  );

  static const MyColors dark = MyColors(
    primary: ColorsDark.primary,
    background: ColorsDark.background,
    surface: ColorsDark.surface,
    textPrimary: ColorsDark.textPrimary,
    textSecondary: ColorsDark.textSecondary,
    border: ColorsDark.border,
    divider: ColorsDark.divider,
    sidebarBg: ColorsDark.sidebarBg,
    sidebarActive: ColorsDark.sidebarActive,
    success: ColorsDark.success,
    error: ColorsDark.error,
    warning: ColorsDark.warning,
    info: ColorsDark.info,
  );
}
