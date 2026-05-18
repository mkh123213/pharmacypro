import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';

const purchaseOrderStatuses = [
  'draft',
  'sent',
  'confirmed',
  'received',
  'cancelled',
];

const nextPurchaseOrderStatus = {
  'draft': 'sent',
  'sent': 'confirmed',
  'confirmed': 'received',
};

String purchaseOrderStatusLabel(BuildContext context, String value) {
  switch (value) {
    case 'draft':
      return context.translate(LangKeys.draft);
    case 'sent':
      return context.translate(LangKeys.sent);
    case 'confirmed':
      return context.translate(LangKeys.confirmed);
    case 'received':
      return context.translate(LangKeys.received);
    case 'cancelled':
      return context.translate(LangKeys.cancelled);
    default:
      return value;
  }
}
