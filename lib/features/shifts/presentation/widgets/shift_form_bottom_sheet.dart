import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/toast/show_toast.dart';
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

class _ShiftFormBottomSheetState extends State<ShiftFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  String? staffId;
  String? branchId;

  final date = TextEditingController();
  final start = TextEditingController();
  final end = TextEditingController();
  final notes = TextEditingController();

  bool _isSaving = false;

  @override
  void dispose() {
    date.dispose();
    start.dispose();
    end.dispose();
    notes.dispose();
    super.dispose();
  }

  Future<void> save() async {
    if (_isSaving) return;
    if (!_formKey.currentState!.validate()) return;

    if (staffId == null || branchId == null) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.pleaseSelectStaffAndBranch),
      );
      return;
    }

    final timeError = AppValidators.endTimeAfterStartTime(
      context,
      startTime: start.text,
      endTime: end.text,
    );

    if (timeError != null) {
      ShowToast.showToastErrorTop(message: timeError);
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final member = widget.staff.firstWhere((item) => item.id == staffId);

    final branch = widget.branches.firstWhere((item) => item.id == branchId);

    final shift = ShiftModel(
      id: '',
      staffId: member.id,
      staffName: member.fullName,
      branchId: branch.id,
      branchName: branch.name,
      date: date.text.trim(),
      startTime: start.text.trim(),
      endTime: end.text.trim(),
      notes: notes.text.trim().isEmpty ? null : notes.text.trim(),
    );

    final success = await context.read<ShiftsCubit>().createShift(shift);

    if (!mounted) return;

    setState(() {
      _isSaving = false;
    });

    if (!success) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.couldNotSaveShift),
      );
      return;
    }

    ShowToast.showToastSuccessTop(
      message: context.translate(LangKeys.shiftScheduledSuccessfully),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, bottomInset + 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 44.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                ),
                SizedBox(height: 18.h),
                TextApp(
                  text: context.translate(LangKeys.addShift),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                ),
                SizedBox(height: 16.h),
                AppDropdownField<String>(
                  value: staffId,
                  label: context.translate(LangKeys.staffMember),
                  isRequired: true,
                  items: widget.staff.map((member) {
                    return AppDropdownItem<String>(
                      value: member.id,
                      label: '${member.fullName} - ${member.role}',
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      staffId = value;
                    });
                  },
                  validator: AppValidators.required(
                    context,
                    fieldName: context.translate(LangKeys.staffMember),
                  ),
                ),
                SizedBox(height: 10.h),
                AppDropdownField<String>(
                  value: branchId,
                  label: context.translate(LangKeys.branch),
                  isRequired: true,
                  items: widget.branches.map((branch) {
                    return AppDropdownItem<String>(
                      value: branch.id,
                      label: branch.name,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      branchId = value;
                    });
                  },
                  validator: AppValidators.required(
                    context,
                    fieldName: context.translate(LangKeys.branch),
                  ),
                ),
                SizedBox(height: 10.h),
                AppDateField(
                  controller: date,
                  label: context.translate(LangKeys.date),
                  isRequired: true,
                  validator: AppValidators.requiredDate(
                    context,
                    fieldName: context.translate(LangKeys.date),
                  ),
                ),
                SizedBox(height: 10.h),
                AppTimeField(
                  controller: start,
                  label: context.translate(LangKeys.startTime),
                  isRequired: true,
                  validator: AppValidators.requiredTime(
                    context,
                    fieldName: context.translate(LangKeys.startTime),
                  ),
                ),
                SizedBox(height: 10.h),
                AppTimeField(
                  controller: end,
                  label: context.translate(LangKeys.endTime),
                  isRequired: true,
                  validator: AppValidators.requiredTime(
                    context,
                    fieldName: context.translate(LangKeys.endTime),
                  ),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: notes,
                  label: context.translate(LangKeys.notes),
                  maxLines: 3,
                ),
                SizedBox(height: 16.h),
                AppPrimaryButton(
                  text: context.translate(LangKeys.scheduleShift),
                  onPressed: _isSaving ? null : save,
                  isLoading: _isSaving,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
