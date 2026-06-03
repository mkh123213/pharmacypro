import 'package:flutter/material.dart';

import '../language/app_localizations.dart';
import '../style/theme/color_extension.dart';

extension ContextExt on BuildContext {
  MyColors get color => Theme.of(this).extension<MyColors>()!;

  TextStyle get textStyle {
    return Theme.of(this).textTheme.bodyMedium ?? const TextStyle();
  }

  String translate(String langkey) {
    return AppLocalizations.of(this)?.translate(langkey).toString() ?? langkey;
  }

  Future<dynamic> pushName(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(
      this,
    ).pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(
      this,
    ).pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  void pop() {
    Navigator.of(this).pop();
  }
}
