import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';

class InventoryAlertFilterValues {
  const InventoryAlertFilterValues._();

  static const String all = 'all';
  static const String lowStock = 'low_stock';
  static const String expiringSoon = 'expiring_soon';
  static const String expired = 'expired';

  static const List<String> values = [
    all,
    lowStock,
    expiringSoon,
    expired,
  ];

  static String normalize(String? value) {
    if (value == null || value.trim().isEmpty) return all;

    final normalized = value.trim().toLowerCase();

    return values.contains(normalized) ? normalized : all;
  }

  static String label(BuildContext context, String value) {
    final normalized = normalize(value);

    if (normalized == all) return context.translate(LangKeys.allAlerts);
    if (normalized == lowStock) return context.translate(LangKeys.lowStock);
    if (normalized == expiringSoon) {
      return context.translate(LangKeys.expiringSoon);
    }
    if (normalized == expired) return context.translate(LangKeys.expired);

    return value;
  }
}
