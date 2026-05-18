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
import '../refactor/staff_constants.dart';

class StaffFormBottomSheet extends StatefulWidget {
  const StaffFormBottomSheet({required this.branches, this.staff, super.key});

  final StaffModel? staff;
  final List<BranchModel> branches;

  @override
  State<StaffFormBottomSheet> createState() => _StaffFormBottomSheetState();
}

class _StaffFormBottomSheetState extends State<StaffFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _name;
  late final TextEditingController _email;
  late final TextEditingController _phone;
  late final TextEditingController _license;
  late final TextEditingController _hireDate;

  late String _role;
  String? _branchId;
  late bool _active;
  bool _isSaving = false;

  bool get _isEditing => widget.staff != null;

  @override
  void initState() {
    super.initState();

    final staff = widget.staff;

    _name = TextEditingController(text: staff?.fullName ?? '');
    _email = TextEditingController(text: staff?.email ?? '');
    _phone = TextEditingController(text: staff?.phone ?? '');
    _license = TextEditingController(text: staff?.licenseNumber ?? '');
    _hireDate = TextEditingController(text: staff?.hireDate ?? '');

    _role = staff?.role ?? 'technician';
    _branchId = staff?.branchId;
    _active = staff?.isActive ?? true;
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _license.dispose();
    _hireDate.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_isSaving) return;
    if (!_formKey.currentState!.validate()) return;

    if (_branchId == null) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.pleaseSelectBranch),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    BranchModel? selectedBranch;

    for (final branch in widget.branches) {
      if (branch.id == _branchId) {
        selectedBranch = branch;
        break;
      }
    }

    final staff = StaffModel(
      id: widget.staff?.id ?? '',
      fullName: _name.text.trim(),
      email: _email.text.trim(),
      phone: _phone.text.trim().isEmpty ? null : _phone.text.trim(),
      role: _role,
      branchId: _branchId ?? '',
      branchName: selectedBranch?.name,
      licenseNumber: _license.text.trim().isEmpty ? null : _license.text.trim(),
      hireDate: _hireDate.text.trim().isEmpty ? null : _hireDate.text.trim(),
      isActive: _active,
    );

    final success = _isEditing
        ? await context.read<StaffCubit>().updateStaff(staff)
        : await context.read<StaffCubit>().createStaff(staff);

    if (!mounted) return;

    setState(() {
      _isSaving = false;
    });

    if (!success) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.couldNotSaveStaffMember),
      );
      return;
    }

    ShowToast.showToastSuccessTop(
      message: _isEditing
          ? context.translate(LangKeys.staffMemberUpdatedSuccessfully)
          : context.translate(LangKeys.staffMemberAddedSuccessfully),
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
                  text: _isEditing
                      ? context.translate(LangKeys.editStaff)
                      : context.translate(LangKeys.addStaffMember),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                ),
                SizedBox(height: 16.h),
                AppTextField(
                  controller: _name,
                  label: context.translate(LangKeys.fullName),
                  isRequired: true,
                  validator: AppValidators.required(
                    context,
                    fieldName: context.translate(LangKeys.fullName),
                  ),
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _email,
                  label: context.translate(LangKeys.email),
                  isRequired: true,
                  keyboardType: TextInputType.emailAddress,
                  validator: AppValidators.requiredEmail(
                    context,
                    fieldName: context.translate(LangKeys.email),
                  ),
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _phone,
                  label: context.translate(LangKeys.phone),
                  keyboardType: TextInputType.phone,
                  validator: AppValidators.optionalPhone(context),
                ),
                SizedBox(height: 12.h),
                AppDropdownField<String>(
                  value: _role,
                  label: context.translate(LangKeys.role),
                  isRequired: true,
                  items: staffRoles.map((role) {
                    return AppDropdownItem<String>(
                      value: role,
                      label: formatStaffRole(context, role),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _role = value ?? _role;
                    });
                  },
                  validator: AppValidators.required(
                    context,
                    fieldName: context.translate(LangKeys.role),
                  ),
                ),
                SizedBox(height: 12.h),
                AppDropdownField<String>(
                  value: _branchId,
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
                      _branchId = value;
                    });
                  },
                  validator: AppValidators.required(
                    context,
                    fieldName: context.translate(LangKeys.branch),
                  ),
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _license,
                  label: context.translate(LangKeys.licenseNumber),
                ),
                SizedBox(height: 12.h),
                AppDateField(
                  controller: _hireDate,
                  label: context.translate(LangKeys.hireDate),
                  validator: AppValidators.optionalDate(context),
                ),
                SizedBox(height: 8.h),
                AppSwitchField(
                  value: _active,
                  title: context.translate(LangKeys.active),
                  onChanged: (value) {
                    setState(() {
                      _active = value;
                    });
                  },
                ),
                SizedBox(height: 16.h),
                AppPrimaryButton(
                  text: context.translate(LangKeys.saveStaff),
                  onPressed: _isSaving ? null : _save,
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
