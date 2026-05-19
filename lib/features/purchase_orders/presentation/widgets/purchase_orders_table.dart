import 'package:flutter/material.dart';

import '../../../../core/common/widgets/app_status_chip.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/purchase_order_model.dart';
import '../refactor/purchase_orders_constants.dart';

class PurchaseOrdersTable extends StatelessWidget {
  const PurchaseOrdersTable({
    required this.orders,
    required this.onView,
    required this.onNextStatus,
    required this.onCancel,
    this.isSubmitting = false,
    super.key,
  });

  final List<PurchaseOrderModel> orders;
  final ValueChanged<PurchaseOrderModel> onView;
  final ValueChanged<PurchaseOrderModel> onNextStatus;
  final ValueChanged<PurchaseOrderModel> onCancel;
  final bool isSubmitting;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: TextApp(
                text: context.translate(LangKeys.orderNumber),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ),
            DataColumn(
              label: TextApp(
                text: context.translate(LangKeys.supplier),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ),
            DataColumn(
              label: TextApp(
                text: context.translate(LangKeys.branch),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ),
            DataColumn(
              label: TextApp(
                text: context.translate(LangKeys.total),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ),
            DataColumn(
              label: TextApp(
                text: context.translate(LangKeys.status),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ),
            DataColumn(
              label: TextApp(
                text: context.translate(LangKeys.actions),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ),
          ],
          rows: orders.map((order) {
            final canMoveNext = nextPurchaseOrderStatus.containsKey(
              order.status,
            );

            final canCancel =
                order.status != 'received' && order.status != 'cancelled';

            return DataRow(
              cells: [
                DataCell(
                  TextApp(
                    text: order.orderNumber ?? order.id,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  TextApp(
                    text: order.supplierName ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  TextApp(
                    text: order.branchName ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  TextApp(
                    text: '\$${order.totalAmount.toStringAsFixed(2)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  AppStatusChip(
                    label: purchaseOrderStatusLabel(context, order.status),
                    type: _statusType(order.status),
                  ),
                ),
                DataCell(
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        tooltip: context.translate(LangKeys.view),
                        onPressed: isSubmitting
                            ? null
                            : () {
                                onView(order);
                              },
                        icon: const Icon(Icons.visibility_outlined),
                      ),
                      if (canMoveNext)
                        TextButton(
                          onPressed: isSubmitting
                              ? null
                              : () {
                                  onNextStatus(order);
                                },
                          child: TextApp(
                            text: context.translate(LangKeys.next),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            theme: context.textStyle,
                          ),
                        ),
                      if (canCancel)
                        TextButton(
                          onPressed: isSubmitting
                              ? null
                              : () {
                                  onCancel(order);
                                },
                          child: TextApp(
                            text: context.translate(LangKeys.cancel),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            theme: context.textStyle.copyWith(
                              color: Colors.red,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
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
}
