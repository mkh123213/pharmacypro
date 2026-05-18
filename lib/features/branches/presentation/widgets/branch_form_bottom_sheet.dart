import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/common/widgets/app_primary_button.dart';
import '../../../../core/common/widgets/app_switch_field.dart';
import '../../../../core/common/widgets/app_text_field.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../../../core/utils/app_validators.dart';
import '../../data/models/branch_model.dart';
import '../cubit/branches_cubit.dart';

class BranchFormBottomSheet extends StatefulWidget {
  const BranchFormBottomSheet({this.branch, super.key});

  final BranchModel? branch;

  @override
  State<BranchFormBottomSheet> createState() => _BranchFormBottomSheetState();
}

class _BranchFormBottomSheetState extends State<BranchFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController name;
  late final TextEditingController city;
  late final TextEditingController address;
  late final TextEditingController phone;
  late final TextEditingController email;
  late final TextEditingController manager;
  late final TextEditingController hours;

  late bool isActive;
  bool _isSaving = false;

  bool get _isEditing => widget.branch != null;

  @override
  void initState() {
    super.initState();

    final branch = widget.branch;

    name = TextEditingController(text: branch?.name ?? '');
    city = TextEditingController(text: branch?.city ?? '');
    address = TextEditingController(text: branch?.address ?? '');
    phone = TextEditingController(text: branch?.phone ?? '');
    email = TextEditingController(text: branch?.email ?? '');
    manager = TextEditingController(text: branch?.managerName ?? '');
    hours = TextEditingController(text: branch?.openingHours ?? '');

    isActive = branch?.isActive ?? true;
  }

  @override
  void dispose() {
    name.dispose();
    city.dispose();
    address.dispose();
    phone.dispose();
    email.dispose();
    manager.dispose();
    hours.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_isSaving) return;
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSaving = true;
    });

    final branch = BranchModel(
      id: widget.branch?.id ?? '',
      name: name.text.trim(),
      address: address.text.trim(),
      city: city.text.trim().isEmpty ? null : city.text.trim(),
      phone: phone.text.trim().isEmpty ? null : phone.text.trim(),
      email: email.text.trim().isEmpty ? null : email.text.trim(),
      managerName: manager.text.trim().isEmpty ? null : manager.text.trim(),
      openingHours: hours.text.trim().isEmpty ? null : hours.text.trim(),
      isActive: isActive,
      createdAt: widget.branch?.createdAt,
      updatedAt: widget.branch?.updatedAt,
    );

    final success = _isEditing
        ? await context.read<BranchesCubit>().updateBranch(branch)
        : await context.read<BranchesCubit>().createBranch(branch);

    if (!mounted) return;

    setState(() {
      _isSaving = false;
    });

    if (!success) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.couldNotSaveBranch),
      );
      return;
    }

    ShowToast.showToastSuccessTop(
      message: _isEditing
          ? context.translate(LangKeys.branchUpdatedSuccessfully)
          : context.translate(LangKeys.branchAddedSuccessfully),
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
                      ? context.translate(LangKeys.editBranch)
                      : context.translate(LangKeys.addBranch),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                ),
                SizedBox(height: 16.h),
                AppTextField(
                  controller: name,
                  label: context.translate(LangKeys.branchName),
                  isRequired: true,
                  validator: AppValidators.required(
                    context,
                    fieldName: context.translate(LangKeys.branchName),
                  ),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: city,
                  label: context.translate(LangKeys.city),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: address,
                  label: context.translate(LangKeys.address),
                  isRequired: true,
                  validator: AppValidators.required(
                    context,
                    fieldName: context.translate(LangKeys.address),
                  ),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: phone,
                  label: context.translate(LangKeys.phone),
                  keyboardType: TextInputType.phone,
                  validator: AppValidators.optionalPhone(context),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: email,
                  label: context.translate(LangKeys.email),
                  keyboardType: TextInputType.emailAddress,
                  validator: AppValidators.optionalEmail(context),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: manager,
                  label: context.translate(LangKeys.managerName),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: hours,
                  label: context.translate(LangKeys.openingHours),
                ),
                SizedBox(height: 8.h),
                AppSwitchField(
                  value: isActive,
                  title: context.translate(LangKeys.active),
                  onChanged: (value) {
                    setState(() {
                      isActive = value;
                    });
                  },
                ),
                SizedBox(height: 16.h),
                AppPrimaryButton(
                  text: context.translate(LangKeys.saveBranch),
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
