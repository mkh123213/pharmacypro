import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';

const allCustomerOrderStatusesValue = 'all';

const customerOrderStatuses = [
  allCustomerOrderStatusesValue,
  'pending',
  'confirmed',
  'processing',
  'ready',
  'out_for_delivery',
  'delivered',
  'cancelled',
];

const nextCustomerOrderStatus = {
  'pending': 'confirmed',
  'confirmed': 'processing',
  'processing': 'ready',
  'ready': 'out_for_delivery',
  'out_for_delivery': 'delivered',
};

const customerOrderTypes = ['pickup', 'delivery'];

const customerOrderPaymentMethods = ['cash', 'card', 'online'];

String customerOrderStatusLabel(BuildContext context, String value) {
  switch (value) {
    case allCustomerOrderStatusesValue:
      return context.translate(LangKeys.allStatuses);
    case 'pending':
      return context.translate(LangKeys.pending);
    case 'confirmed':
      return context.translate(LangKeys.confirmed);
    case 'processing':
      return context.translate(LangKeys.processing);
    case 'ready':
      return context.translate(LangKeys.ready);
    case 'out_for_delivery':
      return context.translate(LangKeys.outForDelivery);
    case 'delivered':
      return context.translate(LangKeys.delivered);
    case 'cancelled':
      return context.translate(LangKeys.cancelled);
    default:
      return value;
  }
}

String customerOrderTypeLabel(BuildContext context, String value) {
  switch (value) {
    case 'pickup':
      return context.translate(LangKeys.pickup);
    case 'delivery':
      return context.translate(LangKeys.delivery);
    default:
      return value;
  }
}

String customerOrderPaymentMethodLabel(BuildContext context, String value) {
  switch (value) {
    case 'cash':
      return context.translate(LangKeys.cash);
    case 'card':
      return context.translate(LangKeys.card);
    case 'online':
      return context.translate(LangKeys.online);
    default:
      return value;
  }
}
