import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/common/widgets/app_bottom_sheet_header.dart';
import '../../../../core/common/widgets/app_primary_button.dart';
import '../../../../core/common/widgets/app_text_field.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../../../core/utils/app_validators.dart';
import '../../data/models/inventory_model.dart';
import '../cubit/inventory_alerts_cubit.dart';
import '../cubit/inventory_alerts_state.dart';

part 'remove_expired_stock_bottom_sheet_remove_expired_stock_bottom_sheet_state.dart';

part 'remove_expired_stock_bottom_sheet_remove_expired_stock_bottom_sheet_state_build_error_message.dart';
part 'remove_expired_stock_bottom_sheet_remove_expired_stock_bottom_sheet_state_save.dart';

class RemoveExpiredStockBottomSheet extends StatefulWidget {
  const RemoveExpiredStockBottomSheet({required this.item, super.key});

  final InventoryModel item;

  @override
  State<RemoveExpiredStockBottomSheet> createState() {
    return _RemoveExpiredStockBottomSheetState();
  }
}
