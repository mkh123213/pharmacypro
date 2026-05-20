import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/common/widgets/app_date_field.dart';
import '../../../../core/common/widgets/app_dropdown_field.dart';
import '../../../../core/common/widgets/app_primary_button.dart';
import '../../../../core/common/widgets/app_switch_field.dart';
import '../../../../core/common/widgets/app_text_field.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../branches/data/models/branch_model.dart';
import '../../data/models/staff_model.dart';
import '../cubit/staff_cubit.dart';
import '../cubit/staff_state.dart';
import '../refactor/staff_constants.dart';

part 'staff_form_bottom_sheet_staff_form_bottom_sheet_state.dart';

part 'staff_form_bottom_sheet_staff_form_bottom_sheet_state_failure_message.dart';
part 'staff_form_bottom_sheet_staff_form_bottom_sheet_state_save.dart';

part 'staff_form_bottom_sheet_staff_form_bottom_sheet_state_fields_1.dart';
part 'staff_form_bottom_sheet_staff_form_bottom_sheet_state_fields_2.dart';

class StaffFormBottomSheet extends StatefulWidget {
  const StaffFormBottomSheet({required this.branches, this.staff, super.key});

  final StaffModel? staff;
  final List<BranchModel> branches;

  @override
  State<StaffFormBottomSheet> createState() => _StaffFormBottomSheetState();
}
