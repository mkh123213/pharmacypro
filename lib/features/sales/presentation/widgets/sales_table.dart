import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/common/widgets/app_status_chip.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/sale_model.dart';

part 'sales_table_info_row.dart';
part 'sales_table_sales_cards.dart';
part 'sales_table_sales_data_table.dart';

part 'sales_table_sales_data_table_columns.dart';
part 'sales_table_sales_data_table_rows.dart';

class SalesTable extends StatelessWidget {
  const SalesTable({required this.sales, this.onDelete, super.key});

  final List<SaleModel> sales;
  final ValueChanged<SaleModel>? onDelete;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 760) {
          return _SalesCards(sales: sales, onDelete: onDelete);
        }

        return _SalesDataTable(sales: sales, onDelete: onDelete);
      },
    );
  }
}




String _saleNumber(SaleModel sale) {
  return sale.saleNumber ?? sale.id.substring(0, sale.id.length.clamp(0, 6));
}

String _dateText(SaleModel sale) {
  if (sale.createdAt == null) return '—';

  return DateFormat('MMM d, HH:mm').format(sale.createdAt!);
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

AppStatusChipType _statusType(String value) {
  switch (value) {
    case 'completed':
      return AppStatusChipType.success;
    case 'refunded':
      return AppStatusChipType.warning;
    case 'voided':
      return AppStatusChipType.error;
    default:
      return AppStatusChipType.neutral;
  }
}
