import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/common/widgets/app_date_field.dart';
import '../../../../core/common/widgets/app_dropdown_field.dart';
import '../../../../core/common/widgets/app_primary_button.dart';
import '../../../../core/common/widgets/app_text_field.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../branches/data/models/branch_model.dart';
import '../../../medications/data/models/medication_model.dart';
import '../../../suppliers/data/models/supplier_model.dart';
import '../../data/models/purchase_order_item_model.dart';
import '../../data/models/purchase_order_model.dart';
import '../cubit/purchase_orders_cubit.dart';
import '../cubit/purchase_orders_state.dart';
import '../refactor/purchase_orders_body.dart';

part 'purchase_order_form_bottom_sheet_purchase_order_form_bottom_sheet_state.dart';
part 'purchase_order_form_bottom_sheet_purchase_order_item_form_bottom_sheet.dart';
part 'purchase_order_form_bottom_sheet_purchase_order_item_form_bottom_sheet_state.dart';

part 'purchase_order_form_bottom_sheet_purchase_order_form_bottom_sheet_state_add_purchase_order_item.dart';
part 'purchase_order_form_bottom_sheet_purchase_order_form_bottom_sheet_state_failure_message.dart';
part 'purchase_order_form_bottom_sheet_purchase_order_form_bottom_sheet_state_remove_item.dart';
part 'purchase_order_form_bottom_sheet_purchase_order_form_bottom_sheet_state_save.dart';
part 'purchase_order_form_bottom_sheet_purchase_order_form_bottom_sheet_state_validate_items_before_save.dart';

part 'purchase_order_form_bottom_sheet_purchase_order_item_form_bottom_sheet_state_on_medication_changed.dart';
part 'purchase_order_form_bottom_sheet_purchase_order_item_form_bottom_sheet_state_save_item.dart';

part 'purchase_order_form_bottom_sheet_purchase_order_form_bottom_sheet_state_fields_1.dart';
part 'purchase_order_form_bottom_sheet_purchase_order_form_bottom_sheet_state_fields_2.dart';
part 'purchase_order_form_bottom_sheet_purchase_order_form_bottom_sheet_state_fields_3.dart';
part 'purchase_order_form_bottom_sheet_purchase_order_form_bottom_sheet_state_fields_4.dart';

class PurchaseOrderFormBottomSheet extends StatefulWidget {
  const PurchaseOrderFormBottomSheet({
    required this.suppliers,
    required this.branches,
    required this.medications,
    this.order,
    super.key,
  });

  final List<SupplierModel> suppliers;
  final List<BranchModel> branches;
  final List<MedicationModel> medications;
  final PurchaseOrderModel? order;

  @override
  State<PurchaseOrderFormBottomSheet> createState() =>
      _PurchaseOrderFormBottomSheetState();
}


Future<PurchaseOrderItemModel?> showPurchaseOrderItemFormBottomSheet({
  required BuildContext context,
  required List<MedicationModel> medications,
}) {
  return showModalBottomSheet<PurchaseOrderItemModel>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return _PurchaseOrderItemFormBottomSheet(medications: medications);
    },
  );
}
