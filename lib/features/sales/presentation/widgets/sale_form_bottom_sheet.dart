import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/common/widgets/app_bottom_sheet_header.dart';
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
import '../../data/models/sale_item_model.dart';
import '../../data/models/sale_model.dart';
import '../cubit/sales_cubit.dart';
import '../cubit/sales_state.dart';
import '../refactor/sales_body.dart';
import 'sale_summary_card.dart';

part 'sale_form_bottom_sheet_sale_form_bottom_sheet_state.dart';

part 'sale_form_bottom_sheet_sale_form_bottom_sheet_state_add_item.dart';
part 'sale_form_bottom_sheet_sale_form_bottom_sheet_state_build_sale_error_message.dart';
part 'sale_form_bottom_sheet_sale_form_bottom_sheet_state_remove_item.dart';
part 'sale_form_bottom_sheet_sale_form_bottom_sheet_state_save.dart';
part 'sale_form_bottom_sheet_sale_form_bottom_sheet_state_validate_sale_items.dart';

part 'sale_form_bottom_sheet_sale_form_bottom_sheet_state_fields_1.dart';
part 'sale_form_bottom_sheet_sale_form_bottom_sheet_state_fields_2.dart';
part 'sale_form_bottom_sheet_sale_form_bottom_sheet_state_fields_3.dart';

class SaleFormBottomSheet extends StatefulWidget {
  const SaleFormBottomSheet({
    required this.medications,
    required this.branches,
    super.key,
  });

  final List<MedicationModel> medications;
  final List<BranchModel> branches;

  @override
  State<SaleFormBottomSheet> createState() => _SaleFormBottomSheetState();
}
