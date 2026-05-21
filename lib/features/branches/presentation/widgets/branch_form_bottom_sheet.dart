import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/common/widgets/app_bottom_sheet_header.dart';
import '../../../../core/common/widgets/app_primary_button.dart';
import '../../../../core/common/widgets/app_switch_field.dart';
import '../../../../core/common/widgets/app_text_field.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../../../core/utils/app_validators.dart';
import '../../data/models/branch_model.dart';
import '../cubit/branches_cubit.dart';
import '../cubit/branches_state.dart';
import '../refactor/branches_body.dart';

part 'branch_form_bottom_sheet_branch_form_bottom_sheet_state.dart';

part 'branch_form_bottom_sheet_branch_form_bottom_sheet_state_empty_to_null.dart';
part 'branch_form_bottom_sheet_branch_form_bottom_sheet_state_failure_message.dart';
part 'branch_form_bottom_sheet_branch_form_bottom_sheet_state_save.dart';

part 'branch_form_bottom_sheet_branch_form_bottom_sheet_state_fields_1.dart';
part 'branch_form_bottom_sheet_branch_form_bottom_sheet_state_fields_2.dart';

class BranchFormBottomSheet extends StatefulWidget {
  const BranchFormBottomSheet({this.branch, super.key});

  final BranchModel? branch;

  @override
  State<BranchFormBottomSheet> createState() => _BranchFormBottomSheetState();
}
