import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/common/widgets/app_bottom_sheet_header.dart';
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
import '../../data/models/inventory_model.dart';
import '../cubit/inventory_cubit.dart';
import '../cubit/inventory_state.dart';

part 'inventory_form_bottom_sheet_inventory_form_bottom_sheet_state.dart';

part 'inventory_form_bottom_sheet_inventory_form_bottom_sheet_state_build_inventory_error_message.dart';
part 'inventory_form_bottom_sheet_inventory_form_bottom_sheet_state_save.dart';

part 'inventory_form_bottom_sheet_inventory_form_bottom_sheet_state_fields_1.dart';
part 'inventory_form_bottom_sheet_inventory_form_bottom_sheet_state_fields_2.dart';
part 'inventory_form_bottom_sheet_inventory_form_bottom_sheet_state_fields_3.dart';

class InventoryFormBottomSheet extends StatefulWidget {
  const InventoryFormBottomSheet({
    required this.medications,
    required this.branches,
    this.item,
    super.key,
  });

  final List<MedicationModel> medications;
  final List<BranchModel> branches;
  final InventoryModel? item;

  @override
  State<InventoryFormBottomSheet> createState() {
    return _InventoryFormBottomSheetState();
  }
}
