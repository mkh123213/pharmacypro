import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/common/widgets/app_status_chip.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/customer_order_model.dart';
import '../refactor/customer_orders_constants.dart';

part 'customer_order_card_compact_order_card.dart';
part 'customer_order_card_info_row.dart';
part 'customer_order_card_order_header.dart';
part 'customer_order_card_wide_order_card.dart';

class CustomerOrderCard extends StatelessWidget {
  const CustomerOrderCard({
    required this.order,
    required this.onNextStatus,
    this.onDelete,
    super.key,
  });

  final CustomerOrderModel order;
  final VoidCallback? onNextStatus;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 520;

            if (compact) {
              return _CompactOrderCard(
                order: order,
                onNextStatus: onNextStatus,
                onDelete: onDelete,
              );
            }

            return _WideOrderCard(order: order, onNextStatus: onNextStatus, onDelete: onDelete);
          },
        ),
      ),
    );
  }
}





String _itemsText(CustomerOrderModel order) {
  if (order.items.isEmpty) return '-';

  return order.items
      .map((item) => '${item.medicationName} x${item.quantity}')
      .join(', ');
}

String _dateText(CustomerOrderModel order) {
  if (order.createdAt == null) return '-';

  return DateFormat('MMM d').format(order.createdAt!);
}

AppStatusChipType _statusType(String status) {
  switch (status) {
    case 'pending':
      return AppStatusChipType.warning;
    case 'confirmed':
      return AppStatusChipType.info;
    case 'processing':
      return AppStatusChipType.primary;
    case 'ready':
      return AppStatusChipType.success;
    case 'out_for_delivery':
      return AppStatusChipType.info;
    case 'delivered':
      return AppStatusChipType.success;
    case 'cancelled':
      return AppStatusChipType.error;
    default:
      return AppStatusChipType.neutral;
  }
}
