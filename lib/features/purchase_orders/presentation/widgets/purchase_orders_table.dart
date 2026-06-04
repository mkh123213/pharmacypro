import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/app_status_chip.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/purchase_order_model.dart';
import '../refactor/purchase_orders_constants.dart';

part 'purchase_orders_table_info_row.dart';
part 'purchase_orders_table_purchase_order_card.dart';
part 'purchase_orders_table_purchase_orders_cards.dart';
part 'purchase_orders_table_purchase_orders_data_table.dart';

part 'purchase_orders_table_purchase_orders_data_table_columns.dart';
part 'purchase_orders_table_purchase_orders_data_table_rows.dart';

class PurchaseOrdersTable extends StatelessWidget {
  const PurchaseOrdersTable({
    required this.orders,
    required this.onView,
    required this.onEdit,
    required this.onNextStatus,
    required this.onCancel,
    this.isSubmitting = false,
    this.onDelete,
    super.key,
  });

  final List<PurchaseOrderModel> orders;
  final ValueChanged<PurchaseOrderModel> onView;
  final ValueChanged<PurchaseOrderModel> onEdit;
  final ValueChanged<PurchaseOrderModel> onNextStatus;
  final ValueChanged<PurchaseOrderModel> onCancel;
  final bool isSubmitting;
  final ValueChanged<PurchaseOrderModel>? onDelete;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 720) {
          return _PurchaseOrdersCards(
            orders: orders,
            onView: onView,
            onEdit: onEdit,
            onNextStatus: onNextStatus,
            onCancel: onCancel,
            isSubmitting: isSubmitting,
            onDelete: onDelete,
          );
        }

        return _PurchaseOrdersDataTable(
          orders: orders,
          onView: onView,
          onEdit: onEdit,
          onNextStatus: onNextStatus,
          onCancel: onCancel,
          isSubmitting: isSubmitting,
          onDelete: onDelete,
        );
      },
    );
  }
}





String _nextActionLabel(BuildContext context, String status) {
  final nextStatus = nextPurchaseOrderStatus[status];

  switch (nextStatus) {
    case 'sent':
      return context.translate(LangKeys.send);
    case 'confirmed':
      return context.translate(LangKeys.confirm);
    case 'received':
      return context.translate(LangKeys.receive);
    default:
      return context.translate(LangKeys.next);
  }
}

String _emptyFallback(String? value) {
  if (value == null || value.trim().isEmpty) return '-';
  return value;
}

AppStatusChipType _statusType(String status) {
  switch (status) {
    case 'draft':
      return AppStatusChipType.neutral;
    case 'sent':
      return AppStatusChipType.info;
    case 'confirmed':
      return AppStatusChipType.warning;
    case 'received':
      return AppStatusChipType.success;
    case 'cancelled':
      return AppStatusChipType.error;
    default:
      return AppStatusChipType.neutral;
  }
}
