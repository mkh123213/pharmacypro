import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/common/widgets/sale_medication_picker_bottom_sheet.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/common/widgets/app_dropdown_field.dart';
import '../../../../core/common/widgets/app_primary_button.dart';
import '../../../../core/common/widgets/app_text_field.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../branches/data/models/branch_model.dart';
import '../../../medications/data/models/medication_model.dart';
import '../../data/models/customer_order_item_model.dart';
import '../../data/models/customer_order_model.dart';
import '../cubit/customer_orders_cubit.dart';
import '../cubit/customer_orders_state.dart';
import '../refactor/customer_orders_constants.dart';

part 'customer_order_form_bottom_sheet_customer_order_form_bottom_sheet_state.dart';
part 'customer_order_form_bottom_sheet_order_total.dart';

part 'customer_order_form_bottom_sheet_customer_order_form_bottom_sheet_state_add_medication.dart';
part 'customer_order_form_bottom_sheet_customer_order_form_bottom_sheet_state_build_customer_order_error_message.dart';
part 'customer_order_form_bottom_sheet_customer_order_form_bottom_sheet_state_remove_item.dart';
part 'customer_order_form_bottom_sheet_customer_order_form_bottom_sheet_state_save.dart';
part 'customer_order_form_bottom_sheet_customer_order_form_bottom_sheet_state_validate_items.dart';

part 'customer_order_form_bottom_sheet_customer_order_form_bottom_sheet_state_fields_1.dart';
part 'customer_order_form_bottom_sheet_customer_order_form_bottom_sheet_state_fields_2.dart';
part 'customer_order_form_bottom_sheet_customer_order_form_bottom_sheet_state_fields_3.dart';

class CustomerOrderFormBottomSheet extends StatefulWidget {
  const CustomerOrderFormBottomSheet({
    required this.medications,
    required this.branches,
    super.key,
  });

  final List<MedicationModel> medications;
  final List<BranchModel> branches;

  @override
  State<CustomerOrderFormBottomSheet> createState() {
    return _CustomerOrderFormBottomSheetState();
  }
}
