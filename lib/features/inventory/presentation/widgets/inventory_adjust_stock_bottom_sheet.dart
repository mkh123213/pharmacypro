import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/common/widgets/app_primary_button.dart';
import '../../../../core/common/widgets/app_text_field.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../../../core/utils/app_validators.dart';
import '../../data/models/inventory_model.dart';
import '../cubit/inventory_cubit.dart';
import '../cubit/inventory_state.dart';

part 'inventory_adjust_stock_bottom_sheet_inventory_adjust_stock_bottom_sheet_state.dart';

part 'inventory_adjust_stock_bottom_sheet_inventory_adjust_stock_bottom_sheet_state_build_error_message.dart';
part 'inventory_adjust_stock_bottom_sheet_inventory_adjust_stock_bottom_sheet_state_save.dart';

class InventoryAdjustStockBottomSheet extends StatefulWidget {
  const InventoryAdjustStockBottomSheet({required this.item, super.key});

  final InventoryModel item;

  @override
  State<InventoryAdjustStockBottomSheet> createState() {
    return _InventoryAdjustStockBottomSheetState();
  }
}
