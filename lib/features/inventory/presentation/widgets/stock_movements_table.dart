import 'package:flutter/material.dart';

import '../../../../core/common/widgets/app_status_chip.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../data/models/stock_movement_model.dart';
import 'stock_movement_filter_bar.dart';

part 'stock_movements_table_columns.dart';
part 'stock_movements_table_rows.dart';

class StockMovementsTable extends StatelessWidget {
  const StockMovementsTable({required this.movements, super.key});

  final List<StockMovementModel> movements;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: this._buildStockMovementsTableColumns(context),
          rows: this._buildStockMovementsTableRows(context),
        ),
      ),
    );
  }
}
