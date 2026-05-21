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
import '../../data/models/prescription_item_model.dart';
import '../../data/models/prescription_model.dart';
import '../cubit/prescriptions_cubit.dart';
import '../cubit/prescriptions_state.dart';
import '../refactor/prescriptions_body.dart';

part 'prescription_form_bottom_sheet_prescription_form_bottom_sheet_state.dart';
part 'prescription_form_bottom_sheet_prescription_item_form_bottom_sheet.dart';
part 'prescription_form_bottom_sheet_prescription_item_form_bottom_sheet_state.dart';
part 'prescription_form_bottom_sheet_prescription_items_section.dart';

part 'prescription_form_bottom_sheet_prescription_form_bottom_sheet_state_add_prescription_item.dart';
part 'prescription_form_bottom_sheet_prescription_form_bottom_sheet_state_remove_prescription_item.dart';
part 'prescription_form_bottom_sheet_prescription_form_bottom_sheet_state_save.dart';

part 'prescription_form_bottom_sheet_prescription_item_form_bottom_sheet_state_save_item.dart';

part 'prescription_form_bottom_sheet_prescription_form_bottom_sheet_state_fields_1.dart';
part 'prescription_form_bottom_sheet_prescription_form_bottom_sheet_state_fields_2.dart';

class PrescriptionFormBottomSheet extends StatefulWidget {
  const PrescriptionFormBottomSheet({
    required this.branches,
    required this.medications,
    super.key,
  });

  final List<BranchModel> branches;
  final List<MedicationModel> medications;

  @override
  State<PrescriptionFormBottomSheet> createState() {
    return _PrescriptionFormBottomSheetState();
  }
}



Future<PrescriptionItemModel?> showPrescriptionItemFormBottomSheet({
  required BuildContext context,
  required List<MedicationModel> medications,
}) {
  return showModalBottomSheet<PrescriptionItemModel>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return _PrescriptionItemFormBottomSheet(medications: medications);
    },
  );
}
