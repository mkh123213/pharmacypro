import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/toast/show_toast.dart';
import '../../../../core/common/widgets/app_date_field.dart';
import '../../../../core/common/widgets/app_dropdown_field.dart';
import '../../../../core/common/widgets/app_primary_button.dart';
import '../../../../core/common/widgets/app_text_field.dart';
import '../../../../core/common/widgets/text_app.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/language/lang_keys.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../branches/data/models/branch_model.dart';
import '../../data/models/prescription_model.dart';
import '../cubit/prescriptions_cubit.dart';

class PrescriptionFormBottomSheet extends StatefulWidget {
  const PrescriptionFormBottomSheet({required this.branches, super.key});

  final List<BranchModel> branches;

  @override
  State<PrescriptionFormBottomSheet> createState() =>
      _PrescriptionFormBottomSheetState();
}

class _PrescriptionFormBottomSheetState
    extends State<PrescriptionFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final patient = TextEditingController();
  final phone = TextEditingController();
  final doctor = TextEditingController();
  final license = TextEditingController();
  final issueDate = TextEditingController();
  final expiryDate = TextEditingController();
  final notes = TextEditingController();

  String? branchId;
  bool _isSaving = false;

  @override
  void dispose() {
    patient.dispose();
    phone.dispose();
    doctor.dispose();
    license.dispose();
    issueDate.dispose();
    expiryDate.dispose();
    notes.dispose();
    super.dispose();
  }

  Future<void> save() async {
    if (_isSaving) return;
    if (!_formKey.currentState!.validate()) return;

    if (branchId == null) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.pleaseSelectBranch),
      );
      return;
    }

    final dateError = AppValidators.endDateAfterStartDate(
      context,
      startDate: issueDate.text,
      endDate: expiryDate.text,
    );

    if (dateError != null) {
      ShowToast.showToastErrorTop(message: dateError);
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final branch = widget.branches.firstWhere(
      (branch) => branch.id == branchId,
    );

    final prescription = PrescriptionModel(
      id: '',
      patientName: patient.text.trim(),
      patientPhone: phone.text.trim().isEmpty ? null : phone.text.trim(),
      doctorName: doctor.text.trim().isEmpty ? null : doctor.text.trim(),
      doctorLicense: license.text.trim().isEmpty ? null : license.text.trim(),
      issueDate: issueDate.text.trim().isEmpty ? null : issueDate.text.trim(),
      expiryDate: expiryDate.text.trim().isEmpty
          ? null
          : expiryDate.text.trim(),
      branchId: branch.id,
      branchName: branch.name,
      notes: notes.text.trim().isEmpty ? null : notes.text.trim(),
      prescriptionNumber:
          'RX-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
    );

    final success = await context.read<PrescriptionsCubit>().createPrescription(
      prescription,
    );

    if (!mounted) return;

    setState(() {
      _isSaving = false;
    });

    if (!success) {
      ShowToast.showToastErrorTop(
        message: context.translate(LangKeys.couldNotSavePrescription),
      );
      return;
    }

    ShowToast.showToastSuccessTop(
      message: context.translate(LangKeys.prescriptionCreatedSuccessfully),
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
                  text: context.translate(LangKeys.newPrescription),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  theme: context.textStyle,
                ),
                SizedBox(height: 16.h),
                AppTextField(
                  controller: patient,
                  label: context.translate(LangKeys.patientName),
                  isRequired: true,
                  validator: AppValidators.required(
                    context,
                    fieldName: context.translate(LangKeys.patientName),
                  ),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: phone,
                  label: context.translate(LangKeys.patientPhone),
                  keyboardType: TextInputType.phone,
                  validator: AppValidators.optionalPhone(context),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: doctor,
                  label: context.translate(LangKeys.doctorName),
                ),
                SizedBox(height: 10.h),
                AppTextField(
                  controller: license,
                  label: context.translate(LangKeys.doctorLicense),
                ),
                SizedBox(height: 10.h),
                AppDateField(
                  controller: issueDate,
                  label: context.translate(LangKeys.issueDate),
                  validator: AppValidators.optionalDate(context),
                ),
                SizedBox(height: 10.h),
                AppDateField(
                  controller: expiryDate,
                  label: context.translate(LangKeys.expiryDate),
                  validator: AppValidators.optionalDate(context),
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
                AppTextField(
                  controller: notes,
                  label: context.translate(LangKeys.notes),
                  maxLines: 3,
                ),
                SizedBox(height: 16.h),
                AppPrimaryButton(
                  text: context.translate(LangKeys.createPrescription),
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
