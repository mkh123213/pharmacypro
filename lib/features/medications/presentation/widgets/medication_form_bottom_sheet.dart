import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/common/widgets/app_bottom_sheet_header.dart';
import '../../../../core/common/widgets/app_dropdown_field.dart';
import '../../../../core/common/widgets/app_primary_button.dart';
import '../../../../core/common/widgets/app_switch_field.dart';
import '../../../../core/common/widgets/app_text_field.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../../../core/utils/app_validators.dart';
import '../../data/models/medication_model.dart';
import '../cubit/medications_cubit.dart';
import '../cubit/medications_state.dart';
import '../refactor/medication_error_mapper.dart';
import '../refactor/medication_form_controller.dart';
import '../refactor/medications_constants.dart';
import 'medication_barcode_scanner_button.dart';

part 'medication_form_bottom_sheet_medication_form_bottom_sheet_state.dart';

part 'medication_form_bottom_sheet_medication_form_bottom_sheet_state_save_medication.dart';

part 'medication_form_bottom_sheet_medication_form_bottom_sheet_state_fields_1.dart';
part 'medication_form_bottom_sheet_medication_form_bottom_sheet_state_fields_2.dart';
part 'medication_form_bottom_sheet_medication_form_bottom_sheet_state_fields_3.dart';

class MedicationFormBottomSheet extends StatefulWidget {
  const MedicationFormBottomSheet({this.medication, this.initialBarcode, super.key});

  final MedicationModel? medication;
  final String? initialBarcode;

  @override
  State<MedicationFormBottomSheet> createState() =>
      _MedicationFormBottomSheetState();
}
