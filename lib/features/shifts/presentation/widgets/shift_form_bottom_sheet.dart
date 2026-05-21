import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/common/widgets/app_bottom_sheet_header.dart';
import '../../../../core/common/widgets/app_date_field.dart';
import '../../../../core/common/widgets/app_dropdown_field.dart';
import '../../../../core/common/widgets/app_primary_button.dart';
import '../../../../core/common/widgets/app_text_field.dart';
import '../../../../core/common/widgets/app_time_field.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../branches/data/models/branch_model.dart';
import '../../../staff/data/models/staff_model.dart';
import '../../data/models/shift_model.dart';
import '../cubit/shifts_cubit.dart';
import '../cubit/shifts_state.dart';
import '../refactor/shifts_body.dart';

part 'shift_form_bottom_sheet_shift_form_bottom_sheet_state.dart';

part 'shift_form_bottom_sheet_shift_form_bottom_sheet_state_failure_message.dart';
part 'shift_form_bottom_sheet_shift_form_bottom_sheet_state_save.dart';

part 'shift_form_bottom_sheet_shift_form_bottom_sheet_state_fields_1.dart';
part 'shift_form_bottom_sheet_shift_form_bottom_sheet_state_fields_2.dart';

class ShiftFormBottomSheet extends StatefulWidget {
  const ShiftFormBottomSheet({
    required this.staff,
    required this.branches,
    super.key,
  });

  final List<StaffModel> staff;
  final List<BranchModel> branches;

  @override
  State<ShiftFormBottomSheet> createState() => _ShiftFormBottomSheetState();
}
