import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/common/widgets/app_status_chip.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/sale_model.dart';

class SalesTable extends StatelessWidget {
  const SalesTable({required this.sales, super.key});

  final List<SaleModel> sales;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: TextApp(
                text: context.translate(LangKeys.saleNumber),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ),
            DataColumn(
              label: TextApp(
                text: context.translate(LangKeys.date),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                theme: context.textStyle,
              ),
            ),
            DataColumn(
              label: TextApp(
                text: context.translate(LangKeys.customer),
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
                text: context.translate(LangKeys.items),
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
                text: context.translate(LangKeys.payment),
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
          ],
          rows: sales.map((sale) {
            return DataRow(
              cells: [
                DataCell(
                  TextApp(
                    text:
                        sale.saleNumber ??
                        sale.id.substring(0, sale.id.length.clamp(0, 6)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  TextApp(
                    text: sale.createdAt == null
                        ? '—'
                        : DateFormat('MMM d, HH:mm').format(sale.createdAt!),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  TextApp(
                    text:
                        sale.customerName ?? context.translate(LangKeys.walkIn),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  TextApp(
                    text: sale.branchName ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  TextApp(
                    text: context
                        .translate(LangKeys.itemsCount)
                        .replaceAll('{count}', sale.items.length.toString()),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  TextApp(
                    text: '\$${sale.totalAmount.toStringAsFixed(2)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  TextApp(
                    text: _paymentLabel(context, sale.paymentMethod),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    theme: context.textStyle,
                  ),
                ),
                DataCell(
                  AppStatusChip(
                    label: _statusLabel(context, sale.status),
                    type: AppStatusChipType.success,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  String _paymentLabel(BuildContext context, String value) {
    switch (value) {
      case 'cash':
        return context.translate(LangKeys.cash);
      case 'card':
        return context.translate(LangKeys.card);
      case 'insurance':
        return context.translate(LangKeys.insurance);
      case 'online':
        return context.translate(LangKeys.online);
      default:
        return value;
    }
  }

  String _statusLabel(BuildContext context, String value) {
    switch (value) {
      case 'completed':
        return context.translate(LangKeys.completed);
      case 'refunded':
        return context.translate(LangKeys.refunded);
      case 'voided':
        return context.translate(LangKeys.voided);
      default:
        return value;
    }
  }
}
